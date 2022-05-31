import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
class Session {
  String id;
  final String sessionName;
  final bool isPublished;
  final int NoOfAppointment;
  final int duration;
  final DateTime date;
  final DateTime time;

  
  Session({this.id = '',
    required this.sessionName,
    required this.isPublished,
    required this.NoOfAppointment,
    required this.duration,
    required this.date,
    required this.time, });

  Map<String, dynamic> toJson() =>{
    'id': id,
  'sessionName': this.sessionName,
    'isPublished': this.isPublished,
    'NoOfAppointment':this.NoOfAppointment,
    'duration':this.duration,
    'date': this.date,
    'time':this.time
  };

}