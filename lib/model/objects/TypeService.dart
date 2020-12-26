import 'package:RendicontationPlatformLeo_Client/model/support/Cloneable.dart';


class TypeService extends Cloneable {
  int id;
  String name;
  bool selected = false;


  TypeService({this.id, this.name});

  factory TypeService.deepCopy(TypeService toCopy) => TypeService(id: toCopy.id, name: toCopy.name);

  factory TypeService.fromJson(Map<String, dynamic> json) {
    return TypeService(
      id: json['id'],
      name: json['name'],
    );
  }

  TypeService clone() {
    return TypeService(id: id, name: name);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };

  @override
  String toString() {
    return name;
  }

  bool operator == (other) {
    return (other is TypeService && other.id == id);
  }


}