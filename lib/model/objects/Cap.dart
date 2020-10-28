class Cap {
  int id;
  String number;


  Cap({this.id, this.number});

  factory Cap.fromJson(Map<String, dynamic> json) {
    return Cap(
      id: json['id'],
      number: json['number'],
    );
  }


}