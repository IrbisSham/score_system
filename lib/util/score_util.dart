import 'package:easy_localization/easy_localization.dart';

class ScoreUtil {

  static String getScoreByNumber(int num) {
    int remainder = num % 10;
    String rez = 'ScoreWords.$remainder';
    return rez.tr();
  }

}
