import 'package:app_bootcamp/AddDescription.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'MyHomePage.dart';

String uid = FirebaseAuth.instance.currentUser!.uid.toString();
class AddEntries extends StatefulWidget {
  const AddEntries({Key? key, required this.title}) : super(key: key);

  final String title;

  @override

  _AddEntriesState createState() => _AddEntriesState();
}

class _AddEntriesState extends State<AddEntries> {

  TextEditingController textController = TextEditingController();
  String displayText = "";

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
          maxLines: 1,
        ),

        ElevatedButton(onPressed: (){

          setState(() {
            displayText = textController.text;
            CollectionReference users = FirebaseFirestore.instance
                .collection('Users')
                .doc(FirebaseAuth.instance.currentUser?.uid)
                .collection('Entries');
            users
                .add({'Entry': displayText, 'Description': ""})
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
              displayText = textController.text;
              currEntry = displayText;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddDescription(title: 'To-Do List')),
              );
            });
          },
              child: const Text("Add Description")),
          ElevatedButton(onPressed: (){
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage(title: 'To-Do List')),
              );
            });
          },
              child: const Text("Back")),
        ],
      ),
        ),
      );
  }
}