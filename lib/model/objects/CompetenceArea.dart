class CompetenceArea {
  int id;
  String title;
  bool selected = false;


  CompetenceArea({this.id, this.title});

  factory CompetenceArea.fromJson(Map<String, dynamic> json) {
    return CompetenceArea(
      id: json['id'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
  };

  @override
  String toString() {
    return title;
  }


}