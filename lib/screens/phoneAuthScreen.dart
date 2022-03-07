import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/providers/AuthServices.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({Key? key}) : super(key: key);

  @override
  _PhoneAuthPageState createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  int start = 30;
  bool wait = false;
  String buttonName = 'Send';
  TextEditingController phoneController = TextEditingController();
  AuthClass authClass = AuthClass();
  String verificationIdFinal = "";
  String smsCode = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Transform(
          transform: Matrix4.translationValues(20.0, 13.0, 0.0),
          child: Text(
            'Sign Up',
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              textField(),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 40,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                    const Text(
                      'Enter 6 Digit OTP',
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              otpField(),
              const SizedBox(
                height: 20,
              ),
              RichText(

                  text:  TextSpan(
                children: [
                  const TextSpan(
                    text: "Send OTP again in ",
                    style: TextStyle(fontSize: 17, color: Colors.blueGrey),
                  ),
                  TextSpan(
                    text: "00:$start",
                    style: const TextStyle(fontSize: 17, color: Colors.indigo, fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(
                    text: " sec",
                    style: TextStyle(fontSize: 17, color: Colors.blueGrey, fontWeight: FontWeight.bold),
                  )
                ],
              )),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: (){
                  authClass.signInWithPhoneNumber(verificationIdFinal, smsCode, context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 100,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(30)

                  ),
                  child: const Center(
                    child: Text(
                      "Lets Go",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer _timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          wait =false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  Widget textField() {
    return Material(
      elevation: 7,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextFormField(
          keyboardType: TextInputType.phone,
          controller: phoneController,
          style: const TextStyle(color: Colors.black87, fontSize: 17, fontWeight: FontWeight.bold),
          decoration:  InputDecoration(

              border: InputBorder.none,
              hintText: "Enter your phone number",
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 17),
              contentPadding: const EdgeInsets.symmetric(vertical: 19, horizontal: 8),
              prefixIcon: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                child: Text(
                  '(+94)',
                  style: TextStyle(color: Colors.black87, fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
              suffixIcon: InkWell(
                onTap: wait?null: ()async{
                  startTimer();
                  setState(() {
                    start = 30;
                    wait =true;
                    buttonName= "Resend";
                  });
                  await authClass.verifyPhoneNumber("+94 ${phoneController.text}", context, setData);
                  
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                  child: Text(
                    buttonName,
                    style: TextStyle(
                      color: wait? Colors.grey: Colors.indigo,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }

  Widget otpField() {
    return OTPTextField(
      length: 6,
      width: MediaQuery.of(context).size.width - 34,
      fieldWidth: 50,
      otpFieldStyle: OtpFieldStyle(
          backgroundColor: Colors.white, borderColor: Colors.grey),
      style: const TextStyle(
          fontSize: 25, color: Colors.black87, fontWeight: FontWeight.bold),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.box,
      onCompleted: (pin) {
        print("Completed: " + pin);
      setState(() {
        smsCode=pin;
      });
      },
    );
  }
  void setData(verificationId){
   setState(() {
     verificationIdFinal=verificationId;
   });
   startTimer();
  }

}
