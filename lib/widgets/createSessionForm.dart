import 'package:flutter/material.dart';

class CreateSessionForm extends StatefulWidget {
  const CreateSessionForm({Key? key}) : super(key: key);

  @override
  _CreateSessionFormState createState() => _CreateSessionFormState();
}

class _CreateSessionFormState extends State<CreateSessionForm> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text('Create Session'),
      content: Padding(
        padding: EdgeInsets.all(8.0),
        child: Form(child: Column(
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Date',
                icon: Icon(Icons.account_box),
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                icon: Icon(Icons.email),
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Message',
                icon: Icon(Icons.message ),
              ),
            ),
          ],
        ),),
      ),
      actions: [
        RaisedButton(
            child: Text("Create"),
            onPressed: () {
              // your code
            })
      ],

    );
  }
}
