import 'package:meta/meta.dart';
import 'package:xml/xml.dart';

/// Represent a post from the API
@immutable
final class Post {
  /// Preview image height
  final int actualPreviewHeight;

  /// Preview image width
  final int actualPreviewWidth;

  /// Name of the artist
  final String author;

  ///
  final int change;

  /// Timestramp of the creation
  final int createdAt;

  /// id of the creator
  final int creatorId;

  /// Size of the original file
  final int fileSize;

  /// Url of the file
  final String fileUrl;

  /// Number of frames
  final int frames;

  /// Number of frames pending
  final int framesPending;

  /// Number of frames pending string
  final String framesPendingString;

  /// Number of frames string
  final String framesString;

  /// The post if parent of another post
  final bool hasChildren;

  /// Height of the image
  final int height;

  /// Id of the post
  final int id;

  ///
  final bool isHeld;

  /// Is the post show in index
  final bool isShownInIndex;

  /// File of the file compressed
  final int jpegFilesize;

  /// Height of the file compressed
  final int jpegHeight;

  /// Width of the file compressed
  final String jpegUrl;

  /// Width of the file compressed
  final int jpegWidth;

  /// MD5 Digest of the file
  final String md5;

  /// Preview image height
  final int previewHeight;

  /// Preview image url
  final String previewUrl;

  /// Preview image width
  final int previewWidth;

  /// Rating of the post
  final String rating;

  /// Size of the sample file
  final int sampleFileSize;

  /// Height of the sample file
  final int sampleHeight;

  /// Url of the sample file
  final String sampleUrl;

  /// Width of the sample file
  final int sampleWidth;

  /// Score of the post
  final int score;

  /// Source of the post
  final String source;

  /// Status of the post
  final String status;

  /// Tags of the post
  final List<String> tags;

  /// Width of the image
  final int width;

  Post._(
      this.actualPreviewHeight,
      this.actualPreviewWidth,
      this.author,
      this.change,
      this.createdAt,
      this.creatorId,
      this.fileSize,
      this.fileUrl,
      this.frames,
      this.framesPending,
      this.framesPendingString,
      this.framesString,
      this.hasChildren,
      this.height,
      this.id,
      this.isHeld,
      this.isShownInIndex,
      this.jpegFilesize,
      this.jpegHeight,
      this.jpegUrl,
      this.jpegWidth,
      this.md5,
      this.previewHeight,
      this.previewUrl,
      this.previewWidth,
      this.rating,
      this.sampleFileSize,
      this.sampleHeight,
      this.sampleUrl,
      this.sampleWidth,
      this.score,
      this.source,
      this.status,
      this.tags,
      this.width);

  /// Create a post from an XML element
  factory Post.fromXml(XmlElement element) {
    return Post._(
        int.parse(element.getAttribute('actual_preview_height')!),
        int.parse(element.getAttribute('actual_preview_width')!),
        element.getAttribute('author')!,
        int.parse(element.getAttribute('change')!),
        int.parse(element.getAttribute('created_at')!),
        int.parse(element.getAttribute('creator_id')!),
        int.parse(element.getAttribute('file_size')!),
        element.getAttribute('file_url')!,
        element.getAttribute('frames')!.isEmpty
            ? 0
            : int.parse(element.getAttribute('frames')!),
        element.getAttribute('frames_pending')!.isEmpty
            ? 0
            : int.parse(element.getAttribute('frames_pending')!),
        element.getAttribute('frames_pending_string')!,
        element.getAttribute('frames_string')!,
        element.getAttribute('has_children')! == 'true',
        int.parse(element.getAttribute('height')!),
        int.parse(element.getAttribute('id')!),
        element.getAttribute('is_held')! == 'true',
        element.getAttribute('is_shown_in_index')! == 'true',
        int.parse(element.getAttribute('jpeg_file_size')!),
        int.parse(element.getAttribute('jpeg_height')!),
        element.getAttribute('jpeg_url')!,
        int.parse(element.getAttribute('jpeg_width')!),
        element.getAttribute('md5')!,
        int.parse(element.getAttribute('preview_height')!),
        element.getAttribute('preview_url')!,
        int.parse(element.getAttribute('preview_width')!),
        element.getAttribute('rating')!,
        int.parse(element.getAttribute('sample_file_size')!),
        int.parse(element.getAttribute('sample_height')!),
        element.getAttribute('sample_url')!,
        int.parse(element.getAttribute('sample_width')!),
        int.parse(element.getAttribute('score')!),
        element.getAttribute('source')!,
        element.getAttribute('status')!,
        element.getAttribute('tags')!.split(' '),
        int.parse(element.getAttribute('width')!));
  }

  /// Create a post from a JSON map
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post._(
        json['actual_preview_height'] as int,
        json['actual_preview_width'] as int,
        json['author'] as String,
        json['change'] as int,
        json['created_at'] as int,
        json['creator_id'] as int,
        json['file_size'] as int,
        json['file_url'] as String,
        json['frames'] as int,
        json['frames_pending'] as int,
        json['frames_pending_string'] as String,
        json['frames_string'] as String,
        json['has_children'] as bool,
        json['height'] as int,
        json['id'] as int,
        json['is_held'] as bool,
        json['is_shown_in_index'] as bool,
        json['jpeg_file_size'] as int,
        json['jpeg_height'] as int,
        json['jpeg_url'] as String,
        json['jpeg_width'] as int,
        json['md5'] as String,
        json['preview_height'] as int,
        json['preview_url'] as String,
        json['preview_width'] as int,
        json['rating'] as String,
        json['sample_file_size'] as int,
        json['sample_height'] as int,
        json['sample_url'] as String,
        json['sample_width'] as int,
        json['score'] as int,
        json['source'] as String,
        json['status'] as String,
        (json['tags'] as String).split(' '),
        json['width'] as int);
  }
}
