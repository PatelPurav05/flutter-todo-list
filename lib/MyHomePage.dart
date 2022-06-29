import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'ShowEntry.dart';
import 'AddEntry.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),

      ),
      backgroundColor: Colors.teal,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 1.4,
            width: MediaQuery.of(context).size.width,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Users')
                    .doc(FirebaseAuth.instance.currentUser?.uid)
                    .collection('Entries')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView(
                    children: snapshot.data!.docs.map((document) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 6,
                          right: 6,
                          bottom: .5,
                        ),
                        child: SwipeActionCell(
                          backgroundColor: Colors.grey,
                          key: ObjectKey(document['Entry']),
                          trailingActions:<SwipeAction>[
                            SwipeAction(
                                title: "delete",
                                onTap: (CompletionHandler handler) {
                                  CollectionReference users = FirebaseFirestore
                                      .instance
                                      .collection('Users')
                                      .doc(
                                      FirebaseAuth.instance.currentUser?.uid)
                                      .collection('Entries');
                                  users
                                      .doc(document.id)
                                      .delete()
                                      .then((value) => print("Entry Removed"))
                                      .catchError((error) => print(
                                      "Failed to delete Entry: $error"));
                                },
                                color: Colors.red),
                            SwipeAction(
                                title: "Desc.",
                                onTap: (CompletionHandler handler) {
                                  clickedDesc = document["Description"];
                                  clickedEntry = document['Entry'];
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const ShowEntry(title: 'View Description')),
                                  );
                                },
                                color: Colors.green),
                          ],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              document['Entry'],
                              textScaleFactor: 1.5,
                              style: const TextStyle(
                                  color: Colors.tealAccent,
                                  fontFamily: "Times",
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }),
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.black54,
        backgroundColor: Colors.tealAccent,
        onPressed: () {
          print("The floating button is clicked.");
          // open a new screen page (page)
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEntries(title: 'Add Entry')),
          );
        },
        tooltip: 'Add New Entry',
        child: const Icon(Icons.add_task),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,// This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 4.0,
        color: Colors.blueGrey,
        child: Container(height:50),
      ),
    );
  }
}
