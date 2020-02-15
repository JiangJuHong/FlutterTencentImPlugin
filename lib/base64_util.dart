import 'dart:convert' as convert;

class Base64Util {
  /// Base64加密
  static String base64Encode(String data) {
    var content = convert.utf8.encode(data);
    var digest = convert.base64Encode(content);
    return digest;
  }

  /// Base64解密
  static String base64Decode(String data) {
    List<int> bytes = convert.base64Decode(data);
    // 网上找的很多都是String.fromCharCodes，这个中文会乱码
    //String txt1 = String.fromCharCodes(bytes);
    String result = convert.utf8.decode(bytes);
    return result;
  }
}
