import 'package:alert_me/pages/login.dart';
import 'package:alert_me/pages/menu.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class singup extends StatefulWidget {
  @override
  _singupState createState() => _singupState();
}

class _singupState extends State<singup> {
  final email = TextEditingController();
  final phno = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  singUp() {
    var defoult = Firebase.initializeApp();
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: email.text, password: password.text)
        .then((value) {
      FirebaseFirestore.instance.collection("users").doc(value.user.uid).set({
        "name": name.text,
        "email": email.text,
        "phno": phno.text,
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) => login()));
    });
  }

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

  //variables
  String _name;
  String _phno;
  String _email;
  String _pass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Image.asset(
            "images/titile1.png",
            height: 150.0,
            width: 151.0,
          )),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                // Padding(
                //   padding: EdgeInsets.all(10),
                //   child: Align(
                //     alignment: Alignment(0, -0.8),
                //     child: Image.asset("images/reg.png"), //main image
                //   ),
                // ),

                Padding(
                  padding: EdgeInsets.all(24),
                  child: Align(
                    alignment: Alignment(0, -0.8),
                    child: Text(
                      "Create Your Account",
                      style: TextStyle(fontSize: 28),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: TextFormField(
                    maxLength: 50,
                    decoration: InputDecoration(
                      labelText: 'Enter Your Name',
                      labelStyle: TextStyle(
                        color: Colors.blue.shade900,
                      ),
                    ),
                    controller: name,
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Name cannot be empty ';
                      }
                      return null;
                    },
                    onSaved: (val) {
                      _name = val;
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: TextFormField(
                    maxLength: 10,
                    decoration: InputDecoration(
                      labelText: 'Enter Phone number',
                      labelStyle: TextStyle(
                        color: Colors.blue.shade900,
                      ),
                    ),
                    controller: phno,
                    validator: (val) =>
                        val.length < 10 ? 'Incorrect phone number' : null,
                    onSaved: (val) => _pass = val,
                  ),
                ),

                //Email
                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: TextFormField(
                    maxLength: 50,
                    decoration: InputDecoration(
                      labelText: 'Enter your E-mail',
                      labelStyle: TextStyle(
                        color: Colors.blue.shade900,
                      ),
                    ),
                    controller: email,
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Email cannot be empty';
                      }
                      return null;
                    },
                    onSaved: (val) {
                      _email = val;
                    },
                  ),
                ),
                //Password
                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: TextFormField(
                    cursorColor: Theme.of(context).canvasColor,
                    maxLength: 12,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Enter Password',
                      labelStyle: TextStyle(
                        color: Colors.blue.shade900,
                      ),
                    ),
                    controller: password,
                    validator: (val) =>
                        val.length < 08 ? 'Password too short' : null,
                    onSaved: (val) => _pass = val,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      singUp();
                    }
                  },
                  child: Text('Sing Up'),
                )
              ],
            ),
          ),
          // padding: EdgeInsets.all(20),
        ),
      ),
    );
  }
}
