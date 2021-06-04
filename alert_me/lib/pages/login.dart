import 'package:alert_me/pages/menu.dart';
import 'package:alert_me/pages/singup.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  final email = TextEditingController();
  final password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  signIn() {
    var defoult = Firebase.initializeApp();
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email.text, password: password.text)
        .then((value) {
      if (value.user.uid != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => menu()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

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
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Align(
                    alignment: Alignment(0, -0.8),
                    child: Image.asset(
                      "images/login.png",
                      height: 200,
                      width: 300,
                    ), //main image
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment(0, -0.8),
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 28),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: TextFormField(
                    cursorColor: Theme.of(context).canvasColor,
                    maxLength: 50,
                    decoration: InputDecoration(
                      labelText: 'Enter Email to login',
                      labelStyle: TextStyle(
                        color: Colors.green.shade700,
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

                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: TextFormField(
                    cursorColor: Theme.of(context).canvasColor,
                    maxLength: 12,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Enter Password to login',
                      labelStyle: TextStyle(
                        color: Colors.green.shade700,
                      ),
                    ),
                    controller: password,
                    validator: (val) =>
                        val.length < 08 ? 'Wrong Password' : null,
                    onSaved: (val) => _pass = val,
                  ),
                ),
                //Buttton
                Container(
                  height: 50.0,
                  // margin: EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        signIn();
                      }
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        colors: [Color(0xff099A41), Color(0xff77f745)],
                        begin: Alignment.centerLeft,
                        end: Alignment.bottomRight,
                      )),
                      // borderRadius: BorderRadius.circular(26.0)),
                      child: Container(
                        constraints:
                            BoxConstraints(maxWidth: 200.0, minHeight: 80.0),
                        alignment: Alignment.center,
                        child: Text(
                          "Sing In",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'If you are not a member ?',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => singup()));
                  },
                  child: Text("SingUp",
                      style: TextStyle(fontSize: 18, color: Colors.green)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
