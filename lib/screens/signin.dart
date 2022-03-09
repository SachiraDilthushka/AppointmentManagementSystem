import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/providers/google_sign_in.dart';
import 'package:frontend/screens/homePage.dart';
import 'package:frontend/screens/resetPasswordPage.dart';
import 'package:frontend/screens/signup.dart';
import 'package:frontend/providers/user.dart';
import 'package:frontend/screens/verifyEmailPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../providers/AuthServices.dart';
import 'dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class Signin extends StatefulWidget {
  Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formKey = GlobalKey<FormState>();
  // Future save() async {
  //   var res = await http.post(Uri.parse("http://192.168.8.195:5000/signin"),
  //       headers: <String, String>{
  //         'Context-Type': 'application/json;chrSet=UTF-8'
  //       },
  //       body: <String, String>{
  //         'email': user.email,
  //         'password': user.password,
  //       });
  //   print(res.body);
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => const Dashboard()));
  // }

  // User user = User('', '');
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  bool _secureText = true;
  bool circular = false;
  AuthClass authClass = AuthClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          const Positioned(
              top: 0,
              child: Image(
                image: AssetImage(
                  'images/slt.png',
                ),
                height: 325,
              )),
          Container(
            alignment: Alignment.center,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 300,
                  ),
                  Text(
                    "Login to your account to continue",
                    style: GoogleFonts.ubuntu(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        // controller: TextEditingController(text: user.email),
                        // onChanged: (value) {
                        //   user.email = value;
                        // },
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                        ),
                        controller: _emailController,
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
                            labelStyle:
                                TextStyle(fontSize: 24, color: Colors.grey),
                            hintText: 'example@gmail.com',
                            border: UnderlineInputBorder(),
                            icon: Icon(Icons.email_outlined)),
                        keyboardType: TextInputType.emailAddress,
                      )),
                  Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        //controller: TextEditingController(text: user.password),
                        // onChanged: (value) {
                        //   user.password = value;
                        // },
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                        ),
                        controller: _pwdController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter your password..';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: const TextStyle(
                                fontSize: 24, color: Colors.grey),
                            hintText: '*********',
                            icon: const Icon(Icons.security_outlined),
                            suffixIcon: IconButton(
                              icon: Icon(_secureText
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined),
                              onPressed: () {
                                setState(() {
                                  _secureText = !_secureText;
                                });
                              },
                            )),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _secureText,
                      )),
                  Container(
                    alignment: const Alignment(1, 0),
                    padding:
                        const EdgeInsets.only(top: 0, left: 20.0, right: 15),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResetPasswordPage()));
                      },
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
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
                            firebase_auth.UserCredential userCredential =
                                await firebaseAuth.signInWithEmailAndPassword(
                                    email: _emailController.text,
                                    password: _pwdController.text);
                            print(userCredential.user?.email);
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
                                "LOGIN",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                              ),
                      ),
                    ),
                  ),
                  // const SizedBox(
                  //   height: 100,
                  // ),

                  Padding(
                    padding: const EdgeInsets.only(right: 60.0, left: 60.0),
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.black,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                        ),
                        onPressed: () async {
                          // final provider = Provider.of<GoogleSignInProvider>(
                          //     context,
                          //     listen: false);
                          // provider.googleLogin();

                          await authClass.googleSignIn(context);
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.google,
                          color: Colors.red,
                        ),
                        label: const Text('Login with Google')),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 60.0, left: 60.0, top: 10),
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.black,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VerifyEmailPage()));


                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.facebook,
                          color: Colors.blue,
                        ),
                        label: const Text('Login with Facebook')),
                  ),

                  Center(
                    child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(16),
                        child: Row(children: [
                          const Text(
                            "You Don't have an account? ",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Signup()));
                            },
                            child: const Text(
                              "Register Now ",
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ])),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
