import 'package:RendicontationPlatformLeo_Client/model/GlobalStateManager.dart';


class StateManager extends GlobalStateManager {
  Map<String, dynamic> _statesContainer = new Map();


  void addValue(String key, dynamic value) {
    _statesContainer[key] = value;
    refreshStates();
  }

  void updateValue(String key, dynamic value) {
    _statesContainer[key] = value;
    refreshStates();
  }

  dynamic getValue(String key) {
    return _statesContainer[key];
  }

  bool existsValue(String key) {
    return _statesContainer.containsKey(key);
  }

  dynamic getAndDestroyValue(String key) {
    var result = _statesContainer[key];
    _statesContainer.remove(key);
    return result;
  }

  void removeValue(String key) {
    _statesContainer.remove(key);
  }

  void resetState() {
    _statesContainer = new Map();
    refreshStates();
  }


}