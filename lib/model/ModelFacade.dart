import 'package:RendicontationPlatformLeo_Client/model/managers/RestManager.dart';
import 'package:RendicontationPlatformLeo_Client/model/managers/StateManager.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Club.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Quantity.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/Constants.dart';


class ModelFacade {
  static ModelFacade sharedInstance = new ModelFacade();

  StateManager appState = new StateManager();

  RestManager _restManager = new RestManager();


  void getClub(String name) async {
    Club club = await _restManager.makeClubRequest(Constants.REQUEST_INFO_CLUB, name);
    Quantity quantityServices = await _restManager.makeQuantityRequest(Constants.REQUEST_CLUB_QUANTITY_SERVICES, club.id);
    club.quantityServices = quantityServices;
    Quantity quantityActivities = await _restManager.makeQuantityRequest(Constants.REQUEST_CLUB_QUANTITY_ACTIVITIES, club.id);
    club.quantityActivities = quantityActivities;
    appState.setClub(club);
  }


}