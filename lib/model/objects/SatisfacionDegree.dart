import 'package:RendicontationPlatformLeo_Client/model/support/Cloneable.dart';


class SatisfactionDegree extends Cloneable {
  int id;
  String name;
  bool selected = false;


  SatisfactionDegree({this.id, this.name});

  factory SatisfactionDegree.deepCopy(SatisfactionDegree toCopy) => SatisfactionDegree(id: toCopy.id, name: toCopy.name);

  factory SatisfactionDegree.fromJson(Map<String, dynamic> json) {
    return SatisfactionDegree(
      id: json['id'],
      name: json['name'],
    );
  }

  SatisfactionDegree clone() {
    return SatisfactionDegree(id: id, name: name);
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