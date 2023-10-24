import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';

class WordUtil {

  static Codec<String, String> stringToBase64 = utf8.fuse(base64);

  static String checkEmail(final String value) {
    String rez = "";
    if (value.isEmpty)
      return 'UserNewScreen.FieldNotEmptyFieldMessage'.tr();
    if (value.length < 3)
      return 'UserNewScreen.FieldLongerMessage'.tr();
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value))
      rez = 'UserNewScreen.FieldEmailCorrectMessage'.tr();
    return rez;
  }

  static String checkLoginOrFio(final String value) {
    String rez = "";
    if (value.isEmpty)
      return 'UserNewScreen.FieldNotEmptyFieldMessage'.tr();
    if (value.length < 3)
        return 'UserNewScreen.FieldLongerMessage'.tr();
    return rez;
  }

  static String checkPassword(final String? value) {
    String rez = "";
    if (value == null || value.isEmpty)
      return 'UserNewScreen.FieldNotEmptyFieldMessage'.tr();
    // Minimum six characters, at least one uppercase letter, one lowercase letter, one number and one special character:
    String pattern =
        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value))
      rez = 'UserNewScreen.PasswordIncorrectMessage'.tr();
    return rez;
  }

  static String encode(String val) {
    return stringToBase64.encode(val);
  }

  static String decode(String val) {
    return stringToBase64.decode(val);
  }

  static transliterateToLatin(String value) {
    return value
        .replaceAll("а", "a")
        .replaceAll("б", "b")
        .replaceAll("в", "v")
        .replaceAll("г", "g")
        .replaceAll("д", "d")
        .replaceAll("е", "e")
        .replaceAll("ё", "jo")
        .replaceAll("ж", "zh")
        .replaceAll("з", "z")
        .replaceAll("и", "i")
        .replaceAll("й", "jj")
        .replaceAll("к", "k")
        .replaceAll("л", "l")
        .replaceAll("м", "m")
        .replaceAll("н", "n")
        .replaceAll("о", "o")
        .replaceAll("п", "p")
        .replaceAll("р", "r")
        .replaceAll("с", "c")
        .replaceAll("т", "t")
        .replaceAll("у", "u")
        .replaceAll("ф", "f")
        .replaceAll("х", "kh")
        .replaceAll("ц", "c")
        .replaceAll("ч", "ch")
        .replaceAll("ш", "sh")
        .replaceAll("щ", "shh")
        .replaceAll("ъ", "")
        .replaceAll("ы", "y")
        .replaceAll("ь", "")
        .replaceAll("э", "eh")
        .replaceAll("ю", "ju")
        .replaceAll("я", "ja")
        .replaceAll("А", "A")
        .replaceAll("Б", "B")
        .replaceAll("В", "V")
        .replaceAll("Г", "G")
        .replaceAll("Д", "D")
        .replaceAll("Е", "E")
        .replaceAll("Ё", "JO")
        .replaceAll("Ж", "ZH")
        .replaceAll("З", "Z")
        .replaceAll("И", "I")
        .replaceAll("Й", "JJ")
        .replaceAll("К", "K")
        .replaceAll("Л", "L")
        .replaceAll("М", "M")
        .replaceAll("Н", "N")
        .replaceAll("О", "O")
        .replaceAll("П", "P")
        .replaceAll("Р", "R")
        .replaceAll("С", "C")
        .replaceAll("Т", "T")
        .replaceAll("У", "U")
        .replaceAll("Ф", "F")
        .replaceAll("Х", "KH")
        .replaceAll("Ц", "C")
        .replaceAll("Ч", "CH")
        .replaceAll("Ш", "SH")
        .replaceAll("Щ", "SHH")
        .replaceAll("Ъ", "")
        .replaceAll("Ы", "Y")
        .replaceAll("Ь", "")
        .replaceAll("Э", "EH")
        .replaceAll("Ю", "JU")
        .replaceAll("Я", "JA");
  }

}
