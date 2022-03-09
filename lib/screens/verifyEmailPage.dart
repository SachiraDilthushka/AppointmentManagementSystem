import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/RegisterPage.dart';
import 'package:google_fonts/google_fonts.dart';


class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool circular = false;
  final auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;





  @override
  void initState() {
     user = auth.currentUser!;
     user.sendEmailVerification();
     timer = Timer.periodic(Duration(seconds: 5),(timer){
  checkEmailVerified();
      });
    super.initState();
  }
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

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
              'Verify Email',
              style: GoogleFonts.ubuntu(fontSize: 30, color: Colors.white),
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

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'A verification email has been sent to ${user.email}  please check your inbox',
                      style: const TextStyle(
                        fontSize: 25,
                        color: Colors.black54,),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
                          "Resend Email",
                          style: TextStyle(
                              color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Container(
                      height: 50,
                      width: 400,
                      // ignore: deprecated_member_use
                      child: FlatButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        onPressed: () async {

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
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                              color: Colors.indigo, fontSize: 25),
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
  Future<void> checkEmailVerified() async{
    user = auth.currentUser!;
    await user.reload();
    if(user.emailVerified){
      timer.cancel();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => RegisterPage()));
    }
  }

}
