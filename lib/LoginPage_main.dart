
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'MyHomePage.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blueGrey,
      ),
      home: LoginPage(),
    );
  }
}
class LoginPage extends StatefulWidget{
  @override
  _LoginPage createState() => _LoginPage();
}
class _LoginPage extends State<LoginPage>{
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  _LoginPage();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text ("Authorization"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              obscureText: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username'
              ),
            ),
            TextField(
              controller: passwordController,
              obscureText: false,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password'
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: usernameController.text, password: passwordController.text)
                  .then((value){
                    print("Succesfully Logged In");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyHomePage(title: 'To-Do List')),
                    );
                  }).catchError((error){
                    print("Failed to login.");
                    print(error);
                  });

            },
                child: const Text("Login"),
            ),
            ElevatedButton(
                onPressed: () {
                  Future<UserCredential> ucFuture = FirebaseAuth.instance.createUserWithEmailAndPassword(email: usernameController.text, password: passwordController.text);
                  ucFuture.then((value){
                    print ("Succesfully signed up the user!");
                    userSetup(usernameController.text);
                  });
                  ucFuture.catchError((error){
                    print ("Failed to sign up the user");
                    print(error);
                  });
                },
                child: const Text("Create Account"),
            ),
          ]
        )
      )
    );
  }
  Future<void> userSetup(String displayName) async {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    users.doc(uid);
    return;
  }
}

