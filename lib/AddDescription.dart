import 'package:app_bootcamp/AddEntry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'MyHomePage.dart';

String currEntry = "";

class AddDescription extends StatefulWidget {
  const AddDescription({Key? key, required this.title}) : super(key: key);

  final String title;


  @override

  _AddDescriptionState createState() => _AddDescriptionState();
}

class _AddDescriptionState extends State<AddDescription> {

  TextEditingController textController = TextEditingController();
  String newdisplayText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Colors.teal,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            TextField(
              controller: textController,
              maxLines: 5,
            ),

            ElevatedButton(onPressed: (){

                setState(() {
                newdisplayText = textController.text;
                CollectionReference users = FirebaseFirestore.instance
                    .collection('Users')
                    .doc(FirebaseAuth.instance.currentUser?.uid)
                    .collection('Entries');
                users
                    .add({'Entry': currEntry, 'Description': newdisplayText})
                    .then((value) => print("User Document Added"))
                    .catchError((error) =>
                    print("Failed to add user: $error"));
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage(title: 'To-Do List')),
                );
              });
            },
                child: const Text("Enter")
            ),
            ElevatedButton(onPressed: (){
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddEntries(title: 'Add Entry')),
                );
              });
            },
                child: const Text("Cancel Entry")),
          ],
        ),
      ),
    );
  }
}