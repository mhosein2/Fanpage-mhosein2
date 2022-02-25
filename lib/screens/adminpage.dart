import 'package:fanpage/screens/database.dart';
import 'package:fanpage/screens/homepage.dart';
import 'package:fanpage/screens/signin_screen.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  TextEditingController myController = TextEditingController();
  List<String> msgs = [];
  
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary);
    final postMessageField = TextFormField(
      controller: myController,
      style: TextStyle(
        decorationColor: Colors.white,
        color: Colors.white,
      ),
      autofocus: false,
      onSaved: (value) {},
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          hintStyle: TextStyle(color: Colors.white)),
    );

    return Scaffold(
      backgroundColor: Colors.grey,
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
       floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomePage()));
          },
          backgroundColor: Color.fromARGB(255, 255, 153, 0),
          focusColor: Colors.white,
          child: const Icon(Icons.minimize_rounded),
          hoverColor: Colors.green,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 100),
            child: ListView.builder(
              itemCount: msgs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(msgs[index]),
                );
              },
              ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                postMessageField,
                MaterialButton(
                  child: Text('POST MESSAGE'),
                  onPressed: () {
                    
                    setState(() {
                      msgs.add(myController.text);
                      sendMsg(myController.text);
                      myController.clear();
                    });

                    
                  },
                  color: Colors.blue,
                )
              ],
            ),
          )
        ],
      ),
      
    );
  }
}
