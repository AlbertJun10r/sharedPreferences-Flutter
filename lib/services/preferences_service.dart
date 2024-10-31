import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  Future<void> saveTheme(bool isDarkTheme) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkTheme', isDarkTheme);
  }

  Future<bool> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isDarkTheme') ?? false;
  }
}
