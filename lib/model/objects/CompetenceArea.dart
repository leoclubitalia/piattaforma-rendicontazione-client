class CompetenceArea {
  int id;
  String name;
  bool selected = false;


  CompetenceArea({this.id, this.name});

  factory CompetenceArea.fromJson(Map<String, dynamic> json) {
    return CompetenceArea(
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