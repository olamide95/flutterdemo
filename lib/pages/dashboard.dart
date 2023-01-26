import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../provider/userprovider.dart';
import '../user.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {

    User user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: Text("DASHBOARD PAGE"),
        elevation: 0.1,
      ),
      body: Column(
        children: [
          SizedBox(height: 100,),
          const CircleAvatar(
            child: Icon(Icons.camera_alt_outlined),
          ),
          Text(user.firstname),
          Text(user.lastname),
          Text(user.email),
          Text(user.phone),
          SizedBox(height: 100),
          TextButton(onPressed: (){ Navigator.pushReplacementNamed(context, '/logout');}, child: Text("Logout"), ),
          TextButton(onPressed: (){ Navigator.pushReplacementNamed(context, '/changepass');}, child: Text("ChangePassword"), )
        ],
      ),
    );
  }
}