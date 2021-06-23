import 'package:assignment1/services/auth.dart';
import 'package:assignment1/shared/constants.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = '';
  String password = '';
  String error = '';
  String firstName = '';
  String lastName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
          backgroundColor: Colors.blue[400],
          elevation: 0.0,
          title: Text('Register Here'),
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.person),
              label: Text('Sign In'),
              onPressed: () {
                widget.toggleView();
              },
            )
          ]),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 15.0),
                  TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      }),
                  SizedBox(height: 15.0),
                  TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      obscureText: true,
                      validator: (val) => val!.length < 6
                          ? 'Enter a password 6+ chars long'
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      }),
                  SizedBox(height: 15.0),
                  TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'First Name'),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter your First Name' : null,
                      onChanged: (val) {
                        setState(() => firstName = val);
                      }),
                  SizedBox(height: 15.0),
                  TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Last Name'),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter your Last Name' : null,
                      onChanged: (val) {
                        setState(() => lastName = val);
                      }),
                  SizedBox(height: 15.0),
                  ElevatedButton(
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          var dateRegistered = DateTime.now();
                          dynamic result =
                              await _auth.registerWithEmailAndPassword(
                                  email,
                                  password,
                                  firstName,
                                  lastName,
                                  dateRegistered);
                          if (result == null) {
                            setState(
                                () => error = 'please input a valid email');
                          }
                        }
                      }),
                  SizedBox(height: 12.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  )
                ],
              ))),
    );
  }
}
