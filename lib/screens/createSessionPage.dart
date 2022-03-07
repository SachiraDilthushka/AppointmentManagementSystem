import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/providers/SessionDetails.dart';
import 'package:frontend/widgets/createSessionForm.dart';
import 'package:intl/intl.dart';

import '../data/sessionData.dart';

class CreateSessionPage extends StatefulWidget {
  const CreateSessionPage({Key? key}) : super(key: key);
  @override
  _CreateSessionPageState createState() => _CreateSessionPageState();
}

class _CreateSessionPageState extends State<CreateSessionPage> {
  final TextEditingController datePickerController = TextEditingController();

  @override
  void initState() {
    datePickerController.text = "";
    super.initState();
  }

  SessionDetails sessionDetails =
      SessionDetails(sessionDate: DateTime.now(), sessionName: '');
  bool switchValue = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text(
            " Upcoming Session",
            style: TextStyle(
              fontSize: 25,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // Padding(
          //   padding: const EdgeInsets.all(100.0),
          //   child: Center(
          //     child: SvgPicture.asset(
          //       'images/nodata.svg',
          //       alignment: Alignment.topCenter,
          //     ),
          //   ),
          // ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(10),
              children: sessionData.map((sessionData) {
                return Container(
                  margin: EdgeInsets.only(bottom: 15),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.indigo],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.indigo,
                        blurRadius: 8,
                        spreadRadius: 2,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: ExpansionTile(
                    leading: const Icon(
                      Icons.event_available_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                    title: const Text(
                      'Session one',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                    trailing: Text(
                      '07:00 AM',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    tilePadding: EdgeInsets.only(top: 10, left: 10, right: 10),
                    iconColor: Colors.red,
                    collapsedIconColor: Colors.white,
                    childrenPadding:
                        EdgeInsets.only(bottom: 10, left: 10, right: 10),
                    collapsedBackgroundColor: Colors.transparent,
                    subtitle: const Text(
                      '25-02-2022',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    children: [
                      Divider(
                        height: 5,
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 24,
                                    semanticLabel: 'Number of appointments',
                                  ),
                                  Text(
                                    "25",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.alarm,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                  Text(
                                    "20 min",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Divider(
                        height: 5,
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              setState(() {
                                print('edit session');
                              });
                            },
                            splashColor: Colors.white10,
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                print('delete session');
                              });
                            },
                            splashColor: Colors.white10,
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          Switch(
                            value: switchValue,
                            onChanged: (bool value) {
                              setState(() {
                                value = !switchValue;
                              });
                            },
                            activeColor: Colors.green,
                            inactiveThumbColor: Colors.white10,
                          )
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
