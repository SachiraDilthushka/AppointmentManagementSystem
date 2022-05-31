import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/data/appointmentDetailsData.dart';
import 'package:frontend/model/appontmentDetails.dart';
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

  late List<AppointmentDetails> appointmentDetails;
  int? sortColumnIndex;
  bool isAscending = false;
  String? selectedSessionItem;

  @override
  void initState() {
    super.initState();
    this.appointmentDetails = List.of(allAppointments);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
              margin: const EdgeInsets.all(10),
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Date',
                            style: TextStyle(fontSize: 20),
                          ),
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
                              child: const Text(
                                "CANCEL",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
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
                      ],
                    ),
                  SizedBox(
                    height: 20,
                  )
                  ],

                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: buildAppointmentDetailsTable(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildAppointmentDetailsTable() {
    final columns = [
      ' Appointment No',
      'Caller ID',
      'Status',
      'Patient Name',
    ];
    return DataTable(
      horizontalMargin: 10,
      sortColumnIndex: sortColumnIndex,
      sortAscending: isAscending,
      columnSpacing: 2,
      columns: getColumns(columns),
      rows: getRows(appointmentDetails),
    );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map(
        (String column) => DataColumn(
          onSort: onSort,
          label: Text(column),
        ),
      )
      .toList();

  List<DataRow> getRows(List<AppointmentDetails> appointmentDetails) =>
      appointmentDetails.map((AppointmentDetails appointmentDetail) {
        final cells = [
          appointmentDetail.appointmentId,
          appointmentDetail.callerId,
          appointmentDetail.status,
          appointmentDetail.patientName
        ];
        return DataRow(
            onSelectChanged: (isSelected) => setState(() {}),
            cells: [
              DataCell(
                Text(appointmentDetail.appointmentId),
              ),
              DataCell(Text(appointmentDetail.callerId)),
              DataCell(
                Switch(
                 value:appointmentDetail.status ,
                 onChanged: (bool value){
                  setState(() {
                    value = !appointmentDetail.status;
                  });
                 },
                ),
                // Text(appointmentDetail.status.toString()),
              ),
              DataCell(
                Text(appointmentDetail.patientName),
              ),
            ]);
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text('$data'))).toList();

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      appointmentDetails.sort((user1, user2) =>
          conpareString(ascending, user1.appointmentId, user2.appointmentId));
    } else if (columnIndex == 3) {
      appointmentDetails.sort((user1, user2) =>
          conpareString(ascending, user1.patientName, user2.patientName));
    }
    setState(() {
      this.sortColumnIndex = columnIndex;
      this.isAscending = ascending;
    });
  }

  int conpareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);
}
