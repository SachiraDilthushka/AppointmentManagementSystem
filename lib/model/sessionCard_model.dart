class SessionCardModel{
  String sessionName;
  bool isPublished;
  int NoOfAppointment;
  int duration;
  String date;
  String time;
  SessionCardModel(this.sessionName, this.isPublished, this.NoOfAppointment, this.duration, this.date, this.time);
}

// List<SessionCardModel> sessionCards = sessionCardData.map(
//     (item) =>SessionCardModel(
//       item['sessionName'],
//       item['isPublished'],
//       item['NoOfApdfpointment'],
//       item['duration'],
//       item['date'],
//       item['time'],
//     ),
//
// ).toList();

// var sessionCardData = [
//   { "sessionName": "Session One",
//     "isPublished": true,
//     "NoOfAppointment": 25,
//     "duration" : 15,
//     "date": "21-03-2022",
//     "time": "02:30",
//   },
//   { "sessionName": "Session One",
//     "isPublished": true,
//     "NoOfAppointment": 25,
//     "duration" : 15,
//     "date": "21-03-2022",
//     "time": "02:30",
//   }
// ];