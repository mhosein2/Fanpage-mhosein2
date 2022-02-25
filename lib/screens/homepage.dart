import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpage/screens/adminpage.dart';

import 'package:fanpage/screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fanpage/screens/signup_screen.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  String currRole = 'loading';

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary);

//Checking the User's Role
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = FirebaseAuth.instance.currentUser;
    var uid = user?.uid;
    Future<String> getRole() async {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      QuerySnapshot querySnapshot =
          await users.where('uid', isEqualTo: uid).get();
      final String role =
          await querySnapshot.docs.map((doc) => doc.data()).toString();
      var user = setState(() => currRole = role);
      return currRole;
    }

    getRole();
    //Janky temporary way of checking for admin using index
    if (currRole[43] == 'a') {
      return Scaffold(
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('msgs').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView(
              children: snapshot.data!.docs.map((document) {
                return Center(
                  child: Container(
                    margin: EdgeInsets.all(5),
                    padding: const EdgeInsets.all(12),
                    decoration: ShapeDecoration(
                        color: Color.fromARGB(255, 85, 176, 250),
                        shape: Border.all(
                          color: Colors.black,
                          width: 3.0)),
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: MediaQuery.of(context).size.height / 10,
                    child: Text('MHosein2(admin): ' + document['message'],
                    style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                );
              }).toList(),
            );
          },
        ),
        //FloatingActionButton to add messages
        backgroundColor: Color.fromARGB(255, 224, 214, 214),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AdminScreen()));
          },
          backgroundColor: Color.fromARGB(255, 255, 153, 0),
          focusColor: Colors.white,
          child: const Icon(Icons.add),
          hoverColor: Colors.green,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,

        // AppBar and Logout Button
        appBar: AppBar(
          title: Text("Fanpage"),
          actions: <Widget>[
            TextButton(
              style: style,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignInScreen()));
              },
              child: const Text("Logout"),
            )
          ],
        ),
      );
    } else {
      return Scaffold(
       body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('msgs').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView(
              children: snapshot.data!.docs.map((document) {
                return Center(
                  child: Container(
                    margin: EdgeInsets.all(5),
                    padding: const EdgeInsets.all(12),
                    decoration: ShapeDecoration(
                        color: Color.fromARGB(255, 85, 176, 250),
                        shape: Border.all(
                          color: Colors.black,
                          width: 3.0)),
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: MediaQuery.of(context).size.height / 10,
                    child: Text('MHosein2(admin): ' + document['message'],
                    style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                );
              }).toList(),
            );
          },
        ),
        //THIS BEGINS THE POST MESSAGE SECTION
        backgroundColor: Color.fromARGB(255, 224, 214, 214),

        // AppBar and Logout Button
        appBar: AppBar(
          title: Text("Fanpage"),
          actions: <Widget>[
            TextButton(
              style: style,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignInScreen()));
              },
              child: const Text("Logout"),
            )
          ],
        ),
      );
    }
    // THIS ENDS THE POST MESSAGE SECTION
  }
}
