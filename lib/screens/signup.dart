import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/providers/AuthServices.dart';
import 'package:frontend/screens/RegisterPage.dart';
import 'package:frontend/screens/homePage.dart';
import 'package:frontend/screens/phoneAuthScreen.dart';
import 'package:frontend/screens/signin.dart';
import 'package:frontend/providers/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../providers/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class Signup extends StatefulWidget {
  Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  // Future save() async {
  //   var res = await http.post(Uri.parse("http://192.168.8.195:5000/signup"),
  //       headers: <String, String>{
  //         'Context-Type': 'application/json;chrSet=UTF-8'
  //       },
  //       body: <String, String>{
  //         'email': user.email,
  //         'password': user.password,
  //       });
  //   print(res.body);
  //   Navigator.push(
  //       context, new MaterialPageRoute(builder: (context) => Signin()));
  // }
  bool _secureText = true;
  // User user = User('', '');
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  bool circular = false;
  AuthClass authClass = AuthClass();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: ClipRect(
        child: Scaffold(
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
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 60.0, left: 60.0, top: 10),
                            child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  elevation: 5,
                                  primary: Colors.white,
                                  onPrimary: Colors.black,
                                  minimumSize: const Size(double.infinity, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) =>
                                              const PhoneAuthPage()));
                                },
                                icon: const FaIcon(
                                  FontAwesomeIcons.phone,
                                  color: Colors.blue,
                                ),
                                label: const Text('Sign up with Mobile')),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text(
                            'OR',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
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
                              padding: const EdgeInsets.all(16.0),
                              child: TextFormField(
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black87,
                                ),
                                controller: _pwdController,
                                // onChanged: (value) {
                                //   user.password = value;
                                // },
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
                                    firebase_auth.UserCredential
                                        userCredential = await firebaseAuth
                                            .createUserWithEmailAndPassword(
                                                email: _emailController.text.trim(),
                                                password: _pwdController.text.trim());
                                    print(userCredential.user?.email);
                                    setState(() {
                                      circular = false;
                                    });
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                                RegisterPage()),
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
                                        "SIGN UP",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 25),
                                      ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 60.0, left: 60.0),
                            child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  onPrimary: Colors.black,
                                  minimumSize: Size(double.infinity, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                ),
                                onPressed: () async {
                                  // final provider =
                                  //     Provider.of<GoogleSignInProvider>(context,
                                  //         listen: false);
                                  // provider.googleLogin();

                                  await authClass.googleSignIn(context);
                                },
                                icon: const FaIcon(
                                  FontAwesomeIcons.google,
                                  color: Colors.red,
                                ),
                                label: Text('Login with Google')),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 60.0, left: 60.0, top: 10),
                            child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  onPrimary: Colors.black,
                                  minimumSize: Size(double.infinity, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                ),
                                onPressed: () {},
                                icon: const FaIcon(
                                  FontAwesomeIcons.facebook,
                                  color: Colors.blue,
                                ),
                                label: Text('Login with Facebook')),
                          ),
                          Padding(
                              padding: EdgeInsets.fromLTRB(65, 20, 0, 0),
                              child: Row(children: [
                                const Text(
                                  "Already have Account ? ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) => Signin()),
                                        (route) => false);
                                  },
                                  child: const Text(
                                    "Signin  ",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ]))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
