class SatisfactionDegree {
  int id;
  String name;
  bool selected = false;


  SatisfactionDegree({this.id, this.name});

  factory SatisfactionDegree.fromJson(Map<String, dynamic> json) {
    return SatisfactionDegree(
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