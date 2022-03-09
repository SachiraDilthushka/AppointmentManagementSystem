import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  bool circular = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Transform(
            transform: Matrix4.translationValues(20.0, 13.0, 0.0),
            child: Text(
              'Reset Password',
              style: GoogleFonts.ubuntu(fontSize: 28, color: Colors.white),
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
          child: Container(
            alignment: Alignment.center,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'Receive an email to reset your password',
                    style: TextStyle(
                        fontSize: 28,

                        color: Colors.black54,),
                    textAlign: TextAlign.center,
                  ),

                  Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                        ),
                        controller: _emailController,
                        // onChanged: (value) {
                        //   user.email = value;
                        // },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter your email..';
                          } else if (RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return null;
                          } else {
                            return 'Enter valid email';
                          }
                        },
                        decoration: const InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                                fontSize: 24, color: Colors.grey),
                            hintText: 'example@gmail.com',
                            border: UnderlineInputBorder(),
                            icon: Icon(Icons.email_outlined)),
                        keyboardType: TextInputType.emailAddress,
                      )),


                  Padding(
                    padding: EdgeInsets.all(16.0),
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
                          "Reset Password",
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
        ) ,
      ),
    );
  }
}
