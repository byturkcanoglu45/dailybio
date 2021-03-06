import 'package:shared_preferences/shared_preferences.dart';
import 'package:dailybio/constants.dart';
import 'package:dailybio/services/firebase_auth.dart';

class DatabaseService {
  SharedPreferences _prefs;
  saveSettings() async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setDouble('font_size', font_size);
    _prefs.setInt('notification', notification_time);
  }

  getSettings() async {
    _prefs = await SharedPreferences.getInstance();

    font_size = _prefs.getDouble('font_size') ?? 20;
    notification_time = _prefs.getInt('notification') ?? 12;
  }
}
