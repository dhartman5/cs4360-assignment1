import 'package:assignment1/models/user.dart';
import 'package:assignment1/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    // return either home or authenticate widget
    // ignore: unnecessary_null_comparison
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
