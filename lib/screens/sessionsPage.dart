import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rolling_switch/rolling_switch.dart';
class SessionsPage extends StatefulWidget {
  const SessionsPage({Key? key}) : super(key: key);

  @override
  _SessionsPageState createState() => _SessionsPageState();
}

class _SessionsPageState extends State<SessionsPage> {
  final int selectedSessionCard = 0;
  bool isSessionStart = false;
  bool isSelected = false;
  final List<String> sessionItems = [
    'Session one',
    'Session two',
    'Session three',
    'Session four',
  ];
  String? selectedSessionItem;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.bottomLeft,
            child: Text(
              'Sessions',
              style: TextStyle(fontSize: 25, color: Colors.blueAccent),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 2,
                spreadRadius: 1,
              ),
            ]),
            padding: EdgeInsets.all(10),
            height: screenHeight * 0.22,
            width: screenWidth * 0.9,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text('dgfd'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          DropdownButton<String>(
                            borderRadius: BorderRadius.circular(20),
                            iconEnabledColor: Colors.blueAccent,
                            iconSize: 30,
                            hint: Text(
                              'Select Your Session',
                              style: TextStyle(fontSize: 20),
                            ),

                            // decoration: InputDecoration(
                            // enabledBorder: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(12),
                            //   borderSide: BorderSide(width: 3, color: Colors.blueAccent)
                            // )
                            // ),
                            value: selectedSessionItem,
                            items: sessionItems
                                .map(
                                  (item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) => setState(() {
                              selectedSessionItem = value;
                            }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: RollingSwitch.icon(
                        width: 100,
                        onChanged: (bool value) {
                          setState(() {
                            value = !isSessionStart;
                          });
                        },
                        rollingInfoRight: const RollingIconInfo(
                          icon: Icons.check,
                          text: Text('Started'),
                          backgroundColor: Colors.green,
                        ),
                        rollingInfoLeft: const RollingIconInfo(
                          icon: Icons.start,
                          backgroundColor: Colors.grey,
                          text: Text('Start'),
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          color: Colors.indigo,
                          onPressed: () {},
                          child: Text(
                            "SUBMIT",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          color: Colors.red,
                          onPressed: () {},
                          child: Text(
                            "CANCEL",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget buildSessionCard() => InkWell(
  //       onTap: () {
  //         setState(() {
  //           isSelected = !isSelected;
  //         });
  //         print('selected');
  //       },
  //       focusColor: Colors.red,
  //       child: Container(
  //         width: 250,
  //         height: 50,
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(10.0),
  //           color: isSelected ? Colors.blue : Colors.grey,
  //         ),
  //         child: Column(
  //           children: [
  //             Container(
  //               padding: EdgeInsets.all(10),
  //                child: Row(
  //                 children: [
  //                   Text(
  //                     'Session Name',
  //                     style: TextStyle(fontSize: 22, color: Colors.black54),
  //                   ),
  //                   Switch(
  //                     value: true,
  //                     onChanged: (bool value) {},
  //                     activeColor: Colors.green,
  //                   )
  //                 ],
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     );
}
