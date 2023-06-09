import 'package:http/http.dart';
import 'package:xml/xml.dart';

import 'post.dart';

/// A in memory cache of the clients
final Map<String, MoebooruClient> _clients = {};

/// Default headers for the requests
final Map<String, String> _defaultHeaders = {
  'User-Agent': 'moebooru-dart/0.0.1',
  'Accept': 'application/json',
};

/// A client to access a Moebooru-based imageboard API
class MoebooruClient {
  /// The host of the image board
  final String host;

  /// The user login
  final String login;

  /// The salted password
  final String hashedPassword;

  /// Shortcut to build the login / password url
  String get _loginPasswordUrl => '&login=$login&password_hash=$hashedPassword';

  /// Private constructor
  MoebooruClient._(this.host, this.login, this.hashedPassword);

  /// Create a new client to access a Moebooru-based imageboard API
  /// [host] is the host of the image board
  /// [login] is the user login
  /// [password] is the user password
  factory MoebooruClient(String host, String login, String password) {
    String key = host + login + password;

    if (_clients.containsKey(host)) {
      return _clients[key]!;
    }

    try {
      Uri.parse(host);
    } catch (e) {
      throw ArgumentError('Invalid host: $host');
    }

    if (login.isEmpty) {
      throw ArgumentError('Login cannot be empty');
    }

    if (password.isEmpty) {
      throw ArgumentError('Password cannot be empty');
    }

    var client = MoebooruClient._(host, login, password);
    _clients[key] = client;
    return client;
  }

  /// Get the number of all posts on the image board
  /// if [tags] is specified, only posts with these tags will be counted
  Future<int> getPostsCount({List<String> tags = const []}) async {
    Uri uri = Uri.parse(
        '$host/post.xml?limit=0&tags=${_buildTagsForUrl(tags)}$_loginPasswordUrl');

    Response response = await get(uri, headers: _defaultHeaders);

    if (response.statusCode != 200) {
      throw Exception('Failed to get posts count');
    }

    var document = XmlDocument.parse(response.body);

    return int.parse(
        document.findAllElements('posts').first.getAttribute('count')!);
  }

  /// Get a list of posts from the image board
  /// if [tags] is specified, only posts with these tags will be returned
  /// [limit] is the number of posts to return, [limit] over 1000 will be lowered to 1000
  /// [page] is the page of posts to return, [page] < 0 page will be set to 0
  /// Return a record with [count] - the number of posts on the image board, [offset] - the offset of the first post in the list, [posts] - the list of posts
  Future<({int count, int offset, List<Post> posts})> getPostList(
      {int limit = 1000, int page = 0, List<String> tags = const []}) async {
    Uri uri = Uri.parse(
        '$host/post.xml?limit=$limit&page=$page&tags=${_buildTagsForUrl(tags)}$_loginPasswordUrl');

    Response response = await get(uri, headers: _defaultHeaders);

    if (response.statusCode != 200) {
      throw Exception('Failed to get posts list');
    }

    var document = XmlDocument.parse(response.body);

    var posts = document.findAllElements('post').map((e) {
      return Post.fromXml(e);
    }).toList();

    return (
      count: int.parse(
          document.findAllElements('posts').first.getAttribute('count')!),
      offset: int.parse(
          document.findAllElements('posts').first.getAttribute('offset')!),
      posts: posts
    );
  }

  /// Create a new post by download pics from [source] and required [tags]
  Future<({Exception? exception, String location})> createPostByurl(
    String source,
    List<String> tags, {
    String rating = 'q',
    String parent = '',
    String md5 = '',
    bool isNoteLocked = false,
    bool isRatingLocked = false,
  }) async {
    var body = {
      'post[source]': source,
      'post[tags]': tags.join(' ').replaceAll(' ', '_'),
      'post[rating]': rating,
      'post[parent]': parent,
      'post[md5]': md5,
      'post[is_note_locked]': isNoteLocked ? '1' : '0',
      'post[is_rating_locked]': isRatingLocked ? '1' : '0',
    };

    Uri uri = Uri.parse('$host/post/create.json?$_loginPasswordUrl');

    var response = await post(uri, headers: _defaultHeaders, body: body);

    if (response.statusCode != 200) {
      return (
        location: '',
        exception: Exception(
            'Failed to create post ${response.statusCode} ${response.body}')
      );
    }

    return (location: response.body, exception: null);
  }

  String _buildTagsForUrl(List<String> tags) {
    return tags.join('+').replaceAll(' ', '_');
  }
}
