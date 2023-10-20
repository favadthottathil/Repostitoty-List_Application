import 'package:shared_preferences/shared_preferences.dart';

class CurrentPageSharedPfr {
  static void storeCurrentPageToSharedPrf(int number) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt('currentPage', number);
  }

static  Future<int?> getCurrentPageFromSharedPrf() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

   return preferences.getInt('currentPage');
  }
}
