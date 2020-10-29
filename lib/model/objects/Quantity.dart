class Quantity {
  int all;
  int currentYear;


  Quantity({this.all, this.currentYear});

  factory Quantity.fromJson(Map<String, dynamic> json) {
    return Quantity(
      all: json['all'],
      currentYear: json['current_year'],
    );
  }

  @override
  String toString() {
    return "all: " + all.toString() + " current_year: " + currentYear.toString();
  }

}