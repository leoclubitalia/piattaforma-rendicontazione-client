import 'package:meta/meta.dart';


class GlobalStateManager {
  List<Function> delegatedFunctions = new List();


  void addStateListener(Function delegatedFunction) {
    delegatedFunctions.add(delegatedFunction);
  }

  void removeStateListener(Function delegatedFunction) {
    delegatedFunctions.remove(delegatedFunction);
  }

  @protected
  void refreshStates() {
    for (Function delegatedFunction in delegatedFunctions) {
      delegatedFunction();
    }
  }


}