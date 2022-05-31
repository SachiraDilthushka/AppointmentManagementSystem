import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/model/Session.dart';
import 'package:frontend/providers/AuthServices.dart';
import 'package:frontend/screens/SearchPatients.dart';
import 'package:frontend/screens/createSessionPage.dart';
import 'package:frontend/screens/dashboardScreen/dashboard.dart';
import 'package:frontend/screens/CreateAppontment.dart';
import 'package:frontend/screens/sessionsPage.dart';
import 'package:frontend/screens/signin.dart';
import 'package:frontend/widgets/sideDrawer.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:frontend/data/database.dart';
import '../providers/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController datePickerController = TextEditingController();
  final TextEditingController timePickerController = TextEditingController();
  late TextEditingController sessionNameController = TextEditingController();
  final TextEditingController NoOfAppointmentController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController isPublishedController = TextEditingController();
  String sessionName = '';
  var numberPickerCurrentValue = 10;
  late DateTime date;
  TimeOfDay? time = TimeOfDay.now();


  setSessionData(){
    dref.child("Session").set({
      'sessionName': "Session 1",
      'isPublished': true,
      'NoOfAppointment':15,
      'duration':30,
      'date': "09/06/2022",
      'time':"7.30 pm"
    });
  }


  @override
  void initState() {
    datePickerController.text = "";
    sessionNameController =TextEditingController();
    super.initState();
  }
  @override
  void dispose(){
    sessionNameController.dispose();
    super.dispose();
  }
  AuthClass authClass = AuthClass();

  late User user;
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 2;
  final screens = [
    SessionsPage(),
    ProfilePage(),
    CreateSessionPage(),
    AppointmentsPage(),
    Dashboard(),
  ];
  int currentTab = 0;
  final List<Widget> screens2 = [
    SessionsPage(),
    ProfilePage(),
    AppointmentsPage(),
    Dashboard(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = SessionsPage();
  @override
  Widget build(BuildContext context) {
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
        body: PageStorage(
          child: currentScreen,
          bucket: bucket,
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              final sessionName = await openSessionCreateDialog();
              if(sessionName== null ||sessionName.isEmpty) return;
              setState(() =>
                this.sessionName = sessionName
              );
            }
            // => showModalBottomSheet(
            //     elevation: 20,
            //     //isScrollControlled: true,
            //     backgroundColor: Colors.transparent,
            //     context: context,
            //     builder: (context) => buildSheet(
            //         context, datePickerController, timePickerController)),
            ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          elevation: 15,
          shape: const CircularNotchedRectangle(),
          notchMargin: 12,
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            height: 65,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            currentScreen = SessionsPage();
                            currentTab = 0;
                          });
                        },
                        minWidth: 40,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.home,
                              color:
                                  currentTab == 0 ? Colors.indigo : Colors.grey,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            currentScreen = ProfilePage();
                            currentTab = 1;
                          });
                        },
                        minWidth: 40,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.menu_rounded,
                              color:
                                  currentTab == 1 ? Colors.indigo : Colors.grey,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            currentScreen = AppointmentsPage();
                            currentTab = 2;
                          });
                        },
                        minWidth: 40,
                        child: Icon(
                          Icons.search,
                          color: currentTab == 2 ? Colors.indigo : Colors.grey,
                          size: 30,
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            currentScreen = Dashboard();
                            currentTab = 3;
                          });
                        },
                        minWidth: 40,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.bar_chart,
                              color:
                                  currentTab == 3 ? Colors.indigo : Colors.grey,
                              size: 30,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  Future<String?> openSessionCreateDialog() => showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        elevation: 10,
        actionsAlignment: MainAxisAlignment.start,
         scrollable:true ,
            title: Text('Create Session'),
            content: Container(

              height: 450,
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
                  controller: sessionNameController,
                  autofocus: true,
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                  scrollPadding: EdgeInsets.all(10),
                  decoration: const InputDecoration(
                    labelText: 'Session Name',
                    labelStyle: TextStyle(fontSize: 20),
                    floatingLabelStyle: TextStyle(
                      fontSize: 24,
                    ),
                    prefixIcon: Icon(
                      Icons.edit,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    readOnly: true,
                    controller: datePickerController,
                    decoration: const InputDecoration(
                        floatingLabelStyle: TextStyle(
                          fontSize: 24,
                        ),
                        labelText: 'Date',
                        prefixIcon: Icon(
                          Icons.calendar_today,
                          color: Colors.grey,
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
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    readOnly: true,
                    controller: timePickerController,
                    decoration: const InputDecoration(
                      floatingLabelStyle: TextStyle(
                        fontSize: 24,
                      ),
                      labelText: 'Start Time',
                      prefixIcon: Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey,
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
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 4,
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
                                      textStyle: TextStyle(
                                          fontSize: 25, color: Colors.grey),
                                      selectedTextStyle: TextStyle(
                                          fontSize: 30,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold),
                                      itemWidth: 35,
                                      itemHeight: 35,
                                      axis: Axis.vertical,
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
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 4,
                                  spreadRadius: 2,

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
                                      textStyle: TextStyle(
                                          fontSize: 25, color: Colors.grey),
                                      selectedTextStyle: TextStyle(
                                          fontSize: 30,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold),
                                      itemWidth: 35,
                                      itemHeight: 35,
                                      axis: Axis.vertical,
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

              ],
            )),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(onPressed: sessionCancelButton, child: Text('CANCEL',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                  TextButton(onPressed:  sessionSubmitButton, child: Text('SUBMIT',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),),
            ],
          )
        ],
          ));
 void sessionSubmitButton(){
   //setSessionData();
   final session = Session(
       sessionName: sessionNameController.text,
       isPublished: bool.hasEnvironment(isPublishedController.text),
       NoOfAppointment:  int.parse(NoOfAppointmentController.text),
       duration: int.parse(durationController.text),
       date: DateTime.parse(datePickerController.text),
       time: DateTime.parse(timePickerController.text),

   );
   createSession(session);
   Navigator.of(context).pop(sessionNameController.text);
 }
  void sessionCancelButton(){
    Navigator.of(context).pop();
  }

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
  Future createSession(Session session) async {
   final docSession = FirebaseFirestore.instance.collection('session').doc();
   session.id = docSession.id;

   final json = session.toJson();
   await docSession.set(json);
  }
  
}


