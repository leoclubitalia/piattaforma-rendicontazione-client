import 'package:RendicontationPlatformLeo_Client/model/GlobalStateManager.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Club.dart';


class StateManager extends GlobalStateManager {
  Club _club;


  void setClub(Club club) {
    _club = club;
    refreshStates();
  }

  Club getClub() {
    return _club;
  }


}