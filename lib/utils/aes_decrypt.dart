import 'package:encrypt/encrypt.dart';

extension AESDecrypt on Encrypted {
  String decryptAes(String key) {
    final encrypter = Encrypter(
      AES(Key.fromUtf8(key), mode: AESMode.cbc),
    );
    final iv = IV.fromLength(16);
    return encrypter.decrypt(this, iv: iv);
  }
}