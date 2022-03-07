import 'package:flutter/material.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
        body: Center(
          child: Text("Create Appointment", style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 50,
            color: Colors.blue,

          ) ),
        )
    );
  }
}
