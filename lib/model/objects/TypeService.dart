class TypeService {
  int id;
  String name;
  bool selected = false;


  TypeService({this.id, this.name});

  factory TypeService.fromJson(Map<String, dynamic> json) {
    return TypeService(
      id: json['id'],
      name: json['name'],
    );
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