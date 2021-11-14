import 'dart:convert';
import 'package:crypto/crypto.dart';

int generateTimeStamp() {
  return DateTime.now().toUtc().millisecondsSinceEpoch;
}

// md5 = ts+privateKey+publicKey
String generateMd5(String ts, String privateKey, String publicKey) {
  return md5.convert(utf8.encode(ts + privateKey + publicKey)).toString();
}
