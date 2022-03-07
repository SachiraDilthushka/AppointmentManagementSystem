import 'package:flutter/material.dart';
import 'package:frontend/providers/AuthServices.dart';
import 'package:frontend/providers/google_sign_in.dart';
import 'package:frontend/screens/homePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:frontend/screens/signup.dart';
import 'package:provider/provider.dart';
void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget currentPage = Signup();
  AuthClass authClass = AuthClass();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }
  void checkLogin() async{
    String? token = await authClass.getToken();
   if (token!=null){
     setState(() {
       currentPage = HomePage();
     });
   }
  }
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context)=>GoogleSignInProvider(),
    child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:currentPage,

      ),
  );
}
