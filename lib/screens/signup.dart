import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'confirmation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/helper/error_line.dart';

class SignUp extends StatefulWidget {
  static const String id = 'signup';
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String name = '';
  bool val = true;
  List<String> errors = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Widget buildForm(String text, IconData icon, int values) {
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
            keyboardType: (values == 1 || values == 2)
                ? TextInputType.emailAddress
                : TextInputType.visiblePassword,
            onSaved: (value) {
              if (values == 0) {
                setState(() {
                  password = value;
                });
              }
              if (values == 1) {
                setState(() {
                  name = value;
                });
              }
              if (values == 2) {
                setState(() {
                  email = value;
                });
              }
            },
            onChanged: (value) {
              if (value.isNotEmpty && errors.contains('Cannot be Empty')) {
                setState(() {
                  errors.remove('Cannot be Empty');
                });
              }
              if (values == 0) {
                if (value.length >= 6 &&
                    errors
                        .contains('Password should be at least 6 characters')) {
                  setState(() {
                    errors.remove('Password should be at least 6 characters');
                  });
                }
              }
              if (values == 1) {
                if (value.length >= 3 &&
                    errors
                        .contains("Name Should have at least 3 characters.")) {
                  setState(() {
                    errors.remove("Name Should have at least 3 characters.");
                  });
                }
              }
              if (values == 2) {
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
              if (values == 0) {
                if (value.length < 6 &&
                    !errors
                        .contains('Password should be at least 6 characters')) {
                  setState(() {
                    errors.add('Password should be at least 6 characters');
                  });
                  return null;
                }
              }
              if (values == 2) {
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
              if (values == 1) {
                if (value.length < 3 &&
                    !errors
                        .contains('Name Should have at least 3 characters.')) {
                  setState(() {
                    errors.add('Name Should have at least 3 characters.');
                  });
                }
                return null;
              }
              return null;
            },
            obscureText: (values == 0 && val == true) ? true : false,
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: Theme.of(context).primaryColor,
              ),
              hintText: text,
              suffixIcon: values == 0
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
                    'SignUp',
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
                  'Register Account',
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  buildForm('Name', Icons.person, 1),
                  buildForm('Email', Icons.email, 2),
                  buildForm('Password', Icons.lock, 0),
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
                                  await _auth.createUserWithEmailAndPassword(
                                      email: email, password: password);
                              final user = res.user;
                              if (user != null) {
                                Navigator.pushNamed(context, Confirmation.id);
                              }
                            } catch (e) {
                              print(e);
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
                            'SignUp',
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
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 20, left: 20.0, right: 20.0),
              child: Expanded(
                  child: Text(
                'By clicking you confirm that you agree '
                'with our Terms and Conditions',
                textAlign: TextAlign.center,
              )),
            ),
          ],
        ),
      ),
    );
  }
}
