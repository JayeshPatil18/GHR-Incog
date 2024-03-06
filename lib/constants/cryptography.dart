import 'package:encrypt/encrypt.dart';

class CryptographyConfig{
  static String keyString = 'ThisIsNotKeyThisIsStringThatCanRevealIdentityOfHackerHaHaWhoHasLengthOf400';
  static final key = Key.fromUtf8(keyString);
  static final iv = IV.fromLength((keyString.length/2).toInt() ?? 37);

  static String encryptText(String plainText, Key key, IV iv) {
    try{
      final encrypter = Encrypter(AES(key));

      final encrypted = encrypter.encrypt(plainText, iv: iv);

      return encrypted.base64;
    } catch(e){
      return plainText;
    }
  }

  static String decryptText(String encryptedText, Key key, IV iv) {
    try{
      final encrypter = Encrypter(AES(key));

      final encrypted = Encrypted.fromBase64(encryptedText);
      final decrypted = encrypter.decrypt(encrypted, iv: iv);

      return decrypted;
    } catch(e){
      return '';
    }
  }
}