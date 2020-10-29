import 'package:RendicontationPlatformLeo_Client/model/GlobalStateManager.dart';
import 'package:RendicontationPlatformLeo_Client/model/managers/RestManager.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Club.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/Constants.dart';


class ModelFacade extends GlobalStateManager {
  static ModelFacade sharedInstance = new ModelFacade();

  RestManager _restManager = new RestManager();

  Club club;


  void getClub(String name) async {
    club = await _restManager.makeClubRequest(Constants.REQUEST_INFO_CLUB, {"name": name});
    refreshStates();
  }


}