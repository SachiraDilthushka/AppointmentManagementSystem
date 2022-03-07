import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/providers/AuthServices.dart';
import 'package:frontend/screens/appointmentsPage.dart';
import 'package:frontend/screens/createSessionPage.dart';
import 'package:frontend/screens/dashboard.dart';
import 'package:frontend/screens/profilePage.dart';
import 'package:frontend/screens/sessionsPage.dart';
import 'package:frontend/screens/signin.dart';
import 'package:frontend/widgets/sideDrawer.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController datePickerController = TextEditingController();
  final TextEditingController timePickerController = TextEditingController();
  var numberPickerCurrentValue = 10;
  late DateTime date;
  TimeOfDay? time = TimeOfDay.now();
  @override
  void initState() {
    datePickerController.text = "";
    super.initState();
  }

  AuthClass authClass = AuthClass();
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 2;
  final screens = [
    SessionsPage(),
    ProfilePage(),
    CreateSessionPage(),
    AppointmentsPage(),
    Dashboard(),
  ];
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final items = <Widget>[
      const Icon(
        Icons.home,
        size: 30,
        color: Colors.white,
      ),
      const Icon(
        Icons.menu,
        size: 30,
        color: Colors.white,
      ),
      const Icon(
        Icons.event_available,
        size: 30,
        color: Colors.white,
      ),
      const Icon(
        Icons.search,
        size: 30,
        color: Colors.white,
      ),
      const Icon(
        Icons.addchart,
        size: 30,
        color: Colors.white,
      ),
    ];

    return SafeArea(
      top: false,
      bottom: false,
      left: true,
      right: true,
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.white,
        drawer: const SideDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          flexibleSpace: ClipRRect(
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.indigo],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  image: DecorationImage(
                      image: AssetImage('images/SLT-2.png'),
                      alignment: Alignment.bottomRight)),
            ),
          ),
        ),
        body: screens[index],
        floatingActionButton:
            index == 2 ? buildMessageButton() : const SizedBox(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        bottomNavigationBar: CurvedNavigationBar(
          key: navigationKey,
          color: Colors.indigo,
          backgroundColor: Colors.transparent,
          height: 60,
          index: index,
          items: items,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 500),
          onTap: (index) => setState(() {
            this.index = index;
          }),
        ),
      ),
    );
  }
  Widget buildMessageButton() => FloatingActionButton.extended(
      icon: const Icon(Icons.add),
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
      onPressed: () => showModalBottomSheet(
          elevation: 20,
          //isScrollControlled: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) =>
              buildSheet(context, datePickerController, timePickerController)),
      label: const Text('Create Session'));

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year - 1),
        lastDate: DateTime(DateTime.now().year + 10));
    if (newDate == null) return;
    setState(() {
      date = newDate;
    });
  }
}

Widget buildSheet(context, datePickerController, timePickerController) =>
    Container(
      decoration: const BoxDecoration(
        // borderRadius: BorderRadius.vertical(
        //   top: Radius.circular(40),
        // ),
        gradient: LinearGradient(
          colors: [Colors.indigo, Colors.blueAccent],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        // color: Colors.indigo,
      ),
      padding: EdgeInsets.all(20),
      child: ListView(
        children: [
          Center(
            child: Text(
              "Create Session",
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            style: TextStyle(color: Colors.white, fontSize: 20),
            scrollPadding: EdgeInsets.all(10),
            decoration: const InputDecoration(
              labelText: 'Session Name',
              labelStyle: TextStyle(fontSize: 20),
              floatingLabelStyle: TextStyle(
                fontSize: 24,
              ),
              prefixIcon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              readOnly: true,
              controller: datePickerController,
              decoration: const InputDecoration(
                  floatingLabelStyle: TextStyle(
                    fontSize: 24,
                  ),
                  labelText: 'Enter Date',
                  prefixIcon: Icon(
                    Icons.calendar_today,
                    color: Colors.white,
                  )),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2101));
                if (pickedDate != null) {
                  print(
                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  datePickerController.text = formattedDate;
                  print(formattedDate);
                } else {
                  print("Date is not selected");
                }
              }),
          TextFormField(
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              readOnly: true,
              controller: timePickerController,
              decoration: const InputDecoration(
                floatingLabelStyle: TextStyle(
                  fontSize: 24,
                ),
                labelText: 'Enter Time',
                prefixIcon: Icon(
                  Icons.access_time_rounded,
                  color: Colors.white,
                ),
              ),
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedTime != null) {
                  print(
                      pickedTime); //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedTime =
                      '${pickedTime.hour.toString()} : ${pickedTime.minute.toString()} ${pickedTime.period.name}';
                  timePickerController.text = formattedTime;
                  print(formattedTime);
                } else {
                  print("Date is not selected");
                }
              }),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.indigo,
                            blurRadius: 8,
                            spreadRadius: 2,
                            offset: Offset(1, 1),
                          ),
                        ]),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Appointments',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.black54),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            NumberPicker(
                                textStyle:
                                    TextStyle(fontSize: 25, color: Colors.grey),
                                selectedTextStyle: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                itemWidth: 35,
                                itemHeight: 60,
                                axis: Axis.horizontal,
                                minValue: 1,
                                maxValue: 200,
                                value: 10,
                                onChanged: (value) {}),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.indigo,
                            blurRadius: 8,
                            spreadRadius: 2,
                            offset: Offset(1, 1),
                          ),
                        ]),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Duration(min) ',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.black54),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            NumberPicker(
                                textStyle:
                                    TextStyle(fontSize: 25, color: Colors.grey),
                                selectedTextStyle: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                itemWidth: 35,
                                itemHeight: 60,
                                axis: Axis.horizontal,
                                minValue: 1,
                                maxValue: 200,
                                value: 10,
                                onChanged: (value) {}),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                ' CREATE',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
