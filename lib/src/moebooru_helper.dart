import 'dart:convert';

import 'package:crypto/crypto.dart';

/// Helper method to encrypt password for konachan.com.
String konachanPasswordHash(String password) {
  String clearText = 'So-I-Heard-You-Like-Mupkids-?--$password--';

  return sha1.convert(utf8.encode(clearText)).toString();
}

/// Helper method to encrypt password for yande.re.
String yanderePasswordHash(String password) {
  String clearText = 'choujin-steiner--$password--';

  return sha1.convert(utf8.encode(clearText)).toString();
}
