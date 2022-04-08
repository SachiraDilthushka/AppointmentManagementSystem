import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/providers/AuthServices.dart';
import 'package:frontend/screens/signin.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  AuthClass authClass = AuthClass();
  final auth = FirebaseAuth.instance;
  late User user;
  @override
  void initState() {
    user = auth.currentUser!;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Colors.indigo,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 150,
                    margin: const EdgeInsets.only(top: 30),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://avatars.githubusercontent.com/u/37095846?v=4'),
                      ),
                    ),
                  ),
                  const Text(
                    'Sachira Dilthushka',
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                   Text(
                    '${user.email}',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(
              Icons.person,
              color: Colors.indigo,
              size: 30,
            ),
            title: const Text(
              'Profile',
              style: TextStyle(fontSize: 20),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(
              Icons.settings,
              color: Colors.indigo,
              size: 30,
            ),
            title: const Text(
              'Settings',
              style: TextStyle(fontSize: 20),
            ),
          ),
          ListTile(
            onTap: () async {
              await authClass.logout();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (builder) => Signin()),
                  (route) => false);
            },
            leading: const Icon(
              Icons.logout,
              color: Colors.indigo,
              size: 30,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(fontSize: 20),
            ),
          ),

           Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width*0.5,
              height: MediaQuery.of(context).size.height*0.2,
           //   margin: const EdgeInsets.only(top: 100, left: 40, right: 40, bottom: 200),
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(image: AssetImage('images/slt-3.png')),
              ),
            ),

        ],
      ),
    );
  }
}
