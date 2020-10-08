import 'package:shared_preferences/shared_preferences.dart';
import 'package:dailybio/constants.dart';

class DatabaseService {
  SharedPreferences _prefs;
  saveSettings() async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setDouble('font_size', font_size);
  }

  getSettings() async {
    _prefs = await SharedPreferences.getInstance();

    font_size = _prefs.getDouble('font_size');
  }
}
