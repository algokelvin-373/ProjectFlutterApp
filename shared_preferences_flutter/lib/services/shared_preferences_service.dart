// todo-01-service-02: create a services to handle a preferences
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_flutter/model/setting.dart';
import 'package:shared_preferences_flutter/utils/page_size_number.dart';

class SharedPreferencesService {
  final SharedPreferences _preferences;

  SharedPreferencesService(this._preferences);

  static const String _keyNotification = "MY_NOTIFICATION";
  static const String _keyPageNumber = "MY_PAGE_NUMBER";
  static const String _keySignature = "MY_SIGNATURE";

  Future<void> saveSettingValue(Setting setting) async {
    try {
      // todo-01-service-07: save all value and make a final result
      await _preferences.setBool(_keyNotification, setting.notificationEnable);
      await _preferences.setInt(_keyPageNumber, setting.pageNumber);
      await _preferences.setString(_keySignature, setting.signature);
    } catch (e) {
      throw Exception("Shared preferences cannot save the setting value.");
    }
  }

  // todo-01-service-09: add a function to get a setting value
  Setting getSettingValue() {
    return Setting(
      notificationEnable: _preferences.getBool(_keyNotification) ?? true,
      pageNumber: _preferences.getInt(_keyPageNumber) ?? defaultPageSizeNumbers,
      signature: _preferences.getString(_keySignature) ?? "",
    );
  }
}