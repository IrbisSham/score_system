import 'package:easy_localization/easy_localization.dart';

class ScoreUtil {

  static String getScoreByNumber(int num) {
    int remainder = num % 10;
    String rez = 'ScoreWords.$remainder';
    return rez.tr();
  }

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

  static String checkPassword(final String value) {
    String rez = "";
    if (value.isEmpty)
      return 'UserNewScreen.FieldNotEmptyFieldMessage'.tr();
    // Minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character:
    String pattern =
        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value))
      rez = 'UserNewScreen.PasswordIncorrectMessage'.tr();
    return rez;
  }

}
