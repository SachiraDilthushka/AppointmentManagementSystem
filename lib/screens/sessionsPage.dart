import 'package:flutter/material.dart';
class SessionsPage extends StatefulWidget {
  const SessionsPage({Key? key}) : super(key: key);

  @override
  _SessionsPageState createState() => _SessionsPageState();
}

class _SessionsPageState extends State<SessionsPage> {
  final items = [
    'Session one',
    'Session two',
    'Session three',
    'Session four',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
          // Container(
          //
          //   child: Center(
          //     child: Column(
          //       children: const [
          //         Text("Sessions ", style: TextStyle(
          //           fontWeight: FontWeight.bold,
          //           fontSize: 30,
          //           color: Colors.blue,
          //         ) ),
          //
          //       ],
          //     ),
          //   ),
          //
          // ),
       Container(
         padding: EdgeInsets.only(top: 10),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,

           children: const [

             Text('Date', style: TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold),),

             Text('Session', style: TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold),),
             Text('Session Start', style: TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold),),
             Padding(padding:EdgeInsets.all(10.0) ),
           ],
         ),
       ),


    );
  }
}
