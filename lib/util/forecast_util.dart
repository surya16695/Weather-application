import 'package:intl/intl.dart';

class Util {
//  static String appId = "751d7305f6f1ef6338c0998a6fbd2ccb";
  static String appId = "ed60fcfbd110ee65c7150605ea8aceea";
  static String appId1 = "751d7305f6f1ef6338c0998a6fbd2ccb";
  static String getFormattedDate(DateTime dateTime) {
    return new DateFormat("EEEE, MMM d, y").format(dateTime);
    //... 1999
  }

  static String dateFormat(DateTime dateTime) {
    return new DateFormat("EEEE, MMM d, y").format(dateTime);
  }
}
