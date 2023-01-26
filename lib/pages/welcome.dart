import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../provider/userprovider.dart';
import '../user.dart';

class Welcome extends StatelessWidget {
  final User user;

  Welcome({Key key,  this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context).setUser(user);

    return Scaffold(
      body: Container(
        child: Center(
          child: Text("WELCOME PAGE"),
        ),
      ),
    );
  }
}