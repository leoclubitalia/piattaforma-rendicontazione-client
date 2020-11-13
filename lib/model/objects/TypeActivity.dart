class TypeActivity {
  int id;
  String name;
  bool selected = false;


  TypeActivity({this.id, this.name});

  factory TypeActivity.fromJson(Map<String, dynamic> json) {
    return TypeActivity(
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