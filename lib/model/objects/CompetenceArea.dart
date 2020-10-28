class CompetenceArea {
  int id;
  String title;


  CompetenceArea({this.id, this.title});

  factory CompetenceArea.fromJson(Map<String, dynamic> json) {
    return CompetenceArea(
      id: json['id'],
      title: json['title'],
    );
  }


}