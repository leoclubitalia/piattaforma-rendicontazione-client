import 'package:RendicontationPlatformLeo_Client/model/managers/GlobalStateManager.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PersistentStorageManager extends GlobalStateManager {


  void addValue(String key, dynamic value) async {
    SharedPreferences _storage = await SharedPreferences.getInstance();
    _storage.setString(key, value);
  }

  Future<String> getValue(String key) async {
    SharedPreferences _storage = await SharedPreferences.getInstance();
    return _storage.getString(key);
  }

  Future<bool> existsValue(String key) async {
    SharedPreferences _storage = await SharedPreferences.getInstance();
    return _storage.containsKey(key);
  }

  void removeValue(String key) async {
    SharedPreferences _storage = await SharedPreferences.getInstance();
    _storage.remove(key);
  }


}