class Report {
  String name;
  int value;


  Report({this.name, this.value});

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      name: json['name'],
      value: json['value'],
    );
  }


}