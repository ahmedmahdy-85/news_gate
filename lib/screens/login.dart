import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'signup.dart';
import 'package:news_app/helper/error_line.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/screens/main_screens/home.dart';

class Login extends StatefulWidget {
  static const String id = 'login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool val = true;
  List<String> errors = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Widget buildForm(String text, IconData icon, bool pass) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10, left: 30, right: 30),
      child: Container(
        height: 60.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(
              color: Theme.of(context).accentColor,
              width: 2.0,
            )),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            keyboardType: pass == false
                ? TextInputType.emailAddress
                : TextInputType.visiblePassword,
            onSaved: (value) {
              if (pass == false) {
                setState(() {
                  email = value;
                });
              }
              if (pass == true) {
                setState(() {
                  password = value;
                });
              }
            },
            onChanged: (value) {
              if (value.isNotEmpty && errors.contains('Cannot be Empty')) {
                setState(() {
                  errors.remove('Cannot be Empty');
                });
              }
              if (pass == true) {
                if (value.length >= 6 &&
                    errors
                        .contains('Password should be at least 6 characters')) {
                  setState(() {
                    errors.remove('Password should be at least 6 characters');
                  });
                }
              }
              if (pass == false) {
                if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value) &&
                    errors.contains("Invalid Email Id.")) {
                  setState(() {
                    errors.remove("Invalid Email Id.");
                  });
                }
              }
            },
            validator: (value) {
              if (value.isEmpty && !errors.contains('Cannot be Empty')) {
                setState(() {
                  errors.add('Cannot be Empty');
                });
                return null;
              }
              if (pass == true) {
                if (value.length < 6 &&
                    !errors
                        .contains('Password should be at least 6 characters')) {
                  setState(() {
                    errors.add('Password should be at least 6 characters');
                  });
                  return null;
                }
              }
              if (pass == false) {
                if (!(RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) &&
                    !errors.contains("Invalid Email Id.")) {
                  setState(() {
                    errors.add("Invalid Email Id.");
                  });
                  return null;
                }
              }
              return null;
            },
            obscureText: (pass == true && val == true) ? true : false,
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: Theme.of(context).primaryColor,
              ),
              hintText: text,
              suffixIcon: pass == true
                  ? IconButton(
                      icon: (val == true)
                          ? Icon(
                              LineAwesomeIcons.eye,
                              color: Theme.of(context).primaryColor,
                            )
                          : Icon(
                              LineAwesomeIcons.eye_slash,
                              color: Theme.of(context).primaryColor,
                            ),
                      onPressed: () {
                        setState(() {
                          val = !val;
                        });
                      },
                    )
                  : Icon(null),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }

  _showDialog(String title, String message) {
    showDialog(
        barrierColor: Theme.of(context).primaryColor,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text(title),
            content: Text(message),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK')),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.grey[700],
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    'LogIn',
                    style: TextStyle(
                        color: Colors.grey, fontSize: 25.0, letterSpacing: .5),
                  ),
                ),
                Spacer(
                  flex: 2,
                ),
              ],
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Text(
                  'Welcome Back',
                  style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  buildForm('Email', Icons.email, false),
                  buildForm('Password', Icons.lock, true),
                  ErrorLine(errors: errors),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 70,
                      child: MaterialButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate() &&
                              errors.isEmpty) {
                            _formKey.currentState.save();
                            try {
                              final res =
                                  await _auth.signInWithEmailAndPassword(
                                      email: email, password: password);
                              final user = res.user;
                              if (user != null) {
                                Navigator.pushNamed(context, Home.id);
                              }
                            } catch (e) {
                              _showDialog('No Account', 'Please SignUp');
                            }
                          }
                        },
                        color: Theme.of(context).accentColor,
                        elevation: 20.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 40,
                left: 20.0,
                right: 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an Account ?",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignUp.id);
                    },
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        'Create Account',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Home.id);
              },
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Container(
                  padding: EdgeInsets.only(top: 10, left: 30.0, right: 30.0),
                  child: Text(
                    'Continue Without Registering',
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 6,
                        fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
