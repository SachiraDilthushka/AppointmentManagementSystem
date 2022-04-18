import 'package:flutter/material.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _numberController = TextEditingController();

  String _session = "Session 1";
  List<String> locationOptions = [
    "Session 1",
    "Session 2",
    "Session 3",
    "Session 4",
  ];

  String _contactNo = "num 1";
  List<String> reserveSlotOptions = [
    "num 1",
    "num 2",
    "num 3",
    "num 4",
  ];

  void sessionCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _session = selectedValue;
      });
    }
  }

  void contactnoCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _contactNo = selectedValue;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 2,
                  bottom: 2,
                ),
                child: Text(
                  "Create Appoinment",
                  style: TextStyle(
                    fontSize: 25,
                    color: Color(0xFF0D47A1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 2,
                  bottom: 2,
                ),
                child: Text(
                  "Date:",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 2,
                    bottom: 2,
                  ),
                  child: TextFormField(
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                    controller: _numberController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Date';
                      }
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(color: Colors.black, width: 0.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  )),
              const SizedBox(
                height: 15,
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 2,
                  bottom: 2,
                ),
                child: Text(
                  "Session:",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 2,
                  bottom: 2,
                ),
                child: DropdownButtonFormField(
                  items: locationOptions
                      .map<DropdownMenuItem<String>>((String mascot) {
                    return DropdownMenuItem<String>(
                        child: Text(mascot), value: mascot);
                  }).toList(),
                  value: _session,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black, width: 0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: sessionCallback,
                  isExpanded: true,
                  isDense: true,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 2,
                  bottom: 2,
                ),
                child: Text(
                  "Patient Contact Number:",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 2,
                  bottom: 2,
                ),
                child: DropdownButtonFormField(
                  items: reserveSlotOptions
                      .map<DropdownMenuItem<String>>((String mascot) {
                    return DropdownMenuItem<String>(
                        child: Text(mascot), value: mascot);
                  }).toList(),
                  hint: const Center(
                      child: Text(
                        'Select the session',
                        style: TextStyle(color: Colors.black),
                      )),
                  value: _contactNo,
                  onChanged: contactnoCallback,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black, width: 0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  isExpanded: true,
                  isDense: true,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 300,
                  right: 5,
                  top: 2,
                  bottom: 2,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  child: const Text('Submit'),
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF0D47A1),
                      textStyle: const TextStyle(fontSize: 15)),
                ),
              ),
            ],
          ),
        )
    );
  }
}
