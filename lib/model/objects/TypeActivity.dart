import 'package:RendicontationPlatformLeo_Client/model/support/Cloneable.dart';


class TypeActivity extends Cloneable {
  int id;
  String name;
  bool selected = false;


  TypeActivity({this.id, this.name});

  factory TypeActivity.deepCopy(TypeActivity toCopy) => TypeActivity(id: toCopy.id, name: toCopy.name);

  factory TypeActivity.fromJson(Map<String, dynamic> json) {
    return TypeActivity(
      id: json['id'],
      name: json['name'],
    );
  }

  TypeActivity clone() {
    return TypeActivity(id: id, name: name);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };

  @override
  String toString() {
    return name;
  }


}