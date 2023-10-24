import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  Future login() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("logged", true);
    prefs.setInt("userId", 1);
  }

  Future logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('logged', false);
    prefs.remove("userId");
  }
}
