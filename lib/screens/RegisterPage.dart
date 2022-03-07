import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'homePage.dart';
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool circular = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _BRNumberController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Transform(
          transform: Matrix4.translationValues(20.0, 13.0, 0.0),
          child: Text(
            'Register',
            style: GoogleFonts.ubuntu(fontSize: 32, color: Colors.white),
          ),
        ),
        titleSpacing: 25,
        elevation: 15,
        backgroundColor: Colors.indigo,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(2000),
                bottomRight: Radius.circular(0))),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: SizedBox(),
        ),
        flexibleSpace: ClipRRect(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/SLT-2.png'),
                    alignment: Alignment.bottomRight)),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                          right: 60.0, left: 60.0, top: 10),
                      child: Text("Please Enter your details", style:TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ) ,),
                    ),
                    const SizedBox(
                      height: 25,
                    ),

                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black87,
                          ),
                          controller: _nameController,
                          // onChanged: (value) {
                          //   user.email = value;
                          // },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter your Name..';
                            }  else {
                              return 'Enter valid Name';
                            }
                          },
                          decoration: const InputDecoration(
                              labelText: 'Name',
                              labelStyle:
                              TextStyle(fontSize: 24, color: Colors.grey),

                              helperText: 'Enter your Name',
                              border: UnderlineInputBorder(),
                              ),
                          keyboardType: TextInputType.text,
                        )),
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black87,
                          ),
                          controller: _BRNumberController,
                          // onChanged: (value) {
                          //   user.email = value;
                          // },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter your SLMC or BR number..';

                            } else {
                              return 'Enter valid Number';
                            }
                          },
                          decoration: const InputDecoration(
                              labelText: 'SLMC/Business Registration Number',
                              labelStyle:
                              TextStyle(fontSize: 24, color: Colors.grey),
                              helperText: 'Enter your SLMC/BR number ',
                              border: UnderlineInputBorder(),
                              ),
                          keyboardType: TextInputType.text,
                        )),
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black87,
                          ),
                          controller: _contactNumberController,
                          // onChanged: (value) {
                          //   user.email = value;
                          // },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter your Contact Number..';
                            } else if (RegExp(
                                r"^(?:7|0|(?:\+94))[0-9]{9,10}$")
                                .hasMatch(value)) {
                              return null;
                            } else {
                              return 'Enter valid Contact Number';
                            }
                          },
                          decoration: const InputDecoration(
                              labelText: 'Published Contact Number',
                              labelStyle:
                              TextStyle(fontSize: 24, color: Colors.grey),
                              helperText: 'Enter your Contact Number',
                              border: UnderlineInputBorder(),
                              ),
                          keyboardType: TextInputType.text,
                        )),
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black87,
                          ),
                          controller: _addressController,
                          // onChanged: (value) {
                          //   user.password = value;
                          // },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter your address..';
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                              labelText: 'Address',
                              labelStyle: TextStyle(
                                  fontSize: 24, color: Colors.grey),
                              helperText: 'Enter your Address',


                              ),
                          keyboardType: TextInputType.text,

                        )),
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black87,
                          ),
                          controller: _locationController,
                          // onChanged: (value) {
                          //   user.password = value;
                          // },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter your Location..';
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: 'Location',
                            labelStyle: TextStyle(
                                fontSize: 24, color: Colors.grey),
                            helperText: 'Enter your Location',


                          ),
                          keyboardType: TextInputType.text,

                        )),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        height: 50,
                        width: 400,
                        // ignore: deprecated_member_use
                        child: FlatButton(
                          color: Colors.indigo,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              // save();
                            } else {
                              print("Not ok");
                            }
                            setState(() {
                              circular = true;
                            });
                            try {
                              setState(() {
                                circular = false;
                              });
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => const HomePage()),
                                      (route) => false);
                            } catch (e) {
                              final snackBar =
                              SnackBar(content: Text(e.toString()));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              print(e);
                              setState(() {
                                circular = false;
                              });
                            }
                          },
                          child: circular
                              ? const CircularProgressIndicator()
                              : const Text(
                            "SUBMIT",
                            style: TextStyle(
                                color: Colors.white, fontSize: 25),
                          ),
                        ),
                      ),
                    ),



                  ],
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }
}
