class TypeActivity {
  int id;
  String title;


  TypeActivity({this.id, this.title});

  factory TypeActivity.fromJson(Map<String, dynamic> json) {
    return TypeActivity(
      id: json['id'],
      title: json['title'],
    );
  }


}