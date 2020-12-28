import 'package:RendicontationPlatformLeo_Client/model/objects/Report.dart';


class Statistics {
  int members;
  int aspirants;
  int quantityServices;
  int quantityActivities;
  List<Report> servicesReport;
  List<Report> activitiesReport;


  Statistics({this.members, this.aspirants, this.quantityServices, this.quantityActivities, this.servicesReport, this.activitiesReport});

  factory Statistics.fromJson(Map<String, dynamic> json) {
    List<Report> servicesReport = [];
    if ( json['serviceAreaReport'] != null ) {
      for ( Map<String, dynamic> rawReport in json['serviceAreaReport'] ) {
        servicesReport.add(Report.fromJson(rawReport));
      }
    }
    List<Report> activitiesReport = [];
    if ( json['activityTypeReport'] != null ) {
      for ( Map<String, dynamic> rawReport in json['activityTypeReport'] ) {
        activitiesReport.add(Report.fromJson(rawReport));
      }
    }
    return Statistics(
      members: json['members'],
      aspirants: json['aspirants'],
      quantityServices: json['services'],
      quantityActivities: json['activities'],
      servicesReport: servicesReport,
      activitiesReport: activitiesReport
    );
  }


}