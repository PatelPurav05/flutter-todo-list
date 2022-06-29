import 'package:flutter/material.dart';
import 'MyHomePage.dart';

int currIndex = 0;
String clickedDesc = "";
String clickedEntry = "";
class ShowEntry extends StatefulWidget {
  const ShowEntry({Key? key, required this.title}) : super(key: key);

  final String title;

  @override

  _ShowEntryState createState() => _ShowEntryState();
}

class _ShowEntryState extends State<ShowEntry> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Colors.teal,
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
            Container(
            height: 50,
            decoration: const ShapeDecoration(
              shape: BeveledRectangleBorder(),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.black54, Colors.tealAccent, Colors.black54],
              ),
            ),
            child: Center(child: Text(
                 '$clickedEntry',
                  style: const TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontStyle: FontStyle.italic,
                ),

            ),

            ),

        ),
              Container(
                height: 300,
                decoration: const ShapeDecoration(
                  shape: BeveledRectangleBorder(),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.black54, Colors.tealAccent, Colors.black54],
                  ),
                ),
                child: Center(child: Text(
                  'Description: $clickedDesc',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                  ),

                ),

                ),

              ),
              ElevatedButton(onPressed: (){

                setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyHomePage(title: 'To-Do List')),
                  );
                });
              },
                  child: const Text("Back")
              ),
      ],
            ),
      ),
      ),
    );
  }
}