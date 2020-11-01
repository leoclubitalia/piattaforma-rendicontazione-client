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

  Map<String, dynamic> toJson() => {
    'id': id,
    'number': number,
  };

  @override
  String toString() {
    return number;
  }


}