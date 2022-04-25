import 'package:flutter/material.dart';
import 'package:frontend/data/appointmentDetailsData.dart';
import 'package:frontend/model/appontmentDetails.dart';
class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({Key? key}) : super(key: key);

  @override
  _AppointmentsPageState createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  late List<AppointmentDetails> appointmentDetails;
  int? sortColumnIndex;
  bool isAscending = false;
  String? selectedSessionItem;
  TextEditingController phoneController = TextEditingController();
  TextEditingController patientNameController = TextEditingController();

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
                  'Search Patients',
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
                padding: EdgeInsets.all(5),
                height: screenHeight * 0.22,
                width: screenWidth * 0.9,

                child: Column(
                  children: [
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: phoneController,
                          style: const TextStyle(color: Colors.black87, fontSize: 17, fontWeight: FontWeight.bold),
                          decoration:  const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter Caller ID",
                              hintStyle: TextStyle(color: Colors.grey, fontSize: 17),
                              contentPadding: EdgeInsets.symmetric(vertical: 19, horizontal: 8),
                              prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                                child: Text(
                                  '(+94)',
                                  style: TextStyle(color: Colors.black87, fontSize: 17, fontWeight: FontWeight.bold),
                                ),
                              ),

                          ),
                        ),
                    TextFormField(

                      controller: patientNameController,
                      style: const TextStyle(color: Colors.black87, fontSize: 17, fontWeight: FontWeight.bold),
                      decoration:  const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Patient Name",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 17),
                        contentPadding: EdgeInsets.symmetric(vertical: 19, horizontal: 8),
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                          child: Icon(
                            Icons.people,
                          )
                        ),
                      ),
                    ),
                    FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        color: Colors.indigo,
                        onPressed: () {},
                        child: Text(
                          "SUBMIT",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize:15,
                          ),
                        ),
                      ),

                  ],
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
        )
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
