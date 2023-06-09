import 'package:moebooru/moebooru.dart';
import 'package:sha_env/sha_env.dart';
import 'package:test/test.dart';

void main() {
  group('Moebooru test', () {
    late MoebooruClient client;

    setUp(() async {
      await ShaEnv().load();
      client = MoebooruClient(
          env['HOST'], env['LOGIN'], konachanPasswordHash(env['PASSWORD']));
    });

    test('Trying to get posts from konachan.com', () async {
      var number = await client.getPostsCount();

      expect(number, equals(287546));
    });
  });
}
