import 'package:flutter/material.dart';
class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({Key? key}) : super(key: key);

  @override
  _AppointmentsPageState createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Text("Search Patients", style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 50,
            color: Colors.blue,

          ) ),
        )
    );
  }
}
