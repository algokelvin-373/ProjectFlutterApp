import 'package:flutter/widgets.dart';
import 'package:person_list/model/profile.dart';
import 'package:person_list/services/sqlite_service.dart';

class LocalDatabaseProvider extends ChangeNotifier {
  final SqliteService _service;

  LocalDatabaseProvider(this._service);

  String _message = "";
  String get message => _message;

  List<Profile>? _profileList;
  List<Profile>? get profileList => _profileList;

  Profile? _profile;
  Profile? get profile => _profile;

  Future<void> saveProfileValue(Profile value) async {
    try {
      final result = await _service.insertItem(value);

      final isError = result == 0;
      if (isError) {
        _message = "Failed to save your data";
        notifyListeners();
      } else {
        _message = "Your data is saved";
        notifyListeners();
      }
    } catch (e) {
      _message = "Failed to save your data";
      notifyListeners();
    }
  }

  Future<void> loadAllProfileValue() async {
    try {
      _profileList = await _service.getAllItems();
      _message = "All of your data is loaded";
      notifyListeners();
    } catch (e) {
      _message = "Failed to load your all data";
      notifyListeners();
    }
  }

  Future<void> loadProfileValueById(int id) async {
    try {
      _profile = await _service.getItemById(id);
      _message = "Your data is loaded";
      notifyListeners();
    } catch (e) {
      _message = "Failed to load your data";
      notifyListeners();
    }
  }

  Future<void> updateProfileValueById(int id, Profile value) async {
    try {
      final result = await _service.updateItem(id, value);

      final isEmptyRowUpdated = result == 0;
      if (isEmptyRowUpdated) {
        _message = "Failed to update your data";
        notifyListeners();
      } else {
        _message = "Your data is updated";
        notifyListeners();
      }
    } catch (e) {
      _message = "Failed to update your data";
      notifyListeners();
    }
  }

  Future<void> removeProfileValueById(int id) async {
    try {
      await _service.removeItem(id);

      _message = "Your data is removed";
      notifyListeners();
    } catch (e) {
      _message = "Failed to remove your data";
      notifyListeners();
    }
  }
}