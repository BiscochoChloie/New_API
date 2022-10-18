import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future saveToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString("token", token);
  }

  static Future getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // preferences.setString('token', json.decode(response.body)['token']);
    var token = preferences.getString("token");
    return token;
  }

  static Future removeToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('token');
    print(preferences.getString('token'));
  }

  static Future getLastPage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var lastpage = preferences.getInt("last_page");

    return lastpage;
  }

  static Future getCurrentPage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var currentpage = preferences.getInt('current_page');
    return currentpage;
  }
}
