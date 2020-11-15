import 'package:RendicontationPlatformLeo_Client/model/support/Cloneable.dart';


extension ListDeepClone<T extends Cloneable> on List<T> {


  List<T> deepClone() {
    List<T> newList = List();
    for ( T element in this ) {
      newList.add(element.clone());
    }
    return newList;
  }


}
