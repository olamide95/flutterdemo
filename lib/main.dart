import 'package:flutter/material.dart';
import 'package:flutterdemo/pages/changePassword.dart';
import 'package:flutterdemo/pages/dashboard.dart';
import 'package:flutterdemo/pages/login.dart';
import 'package:flutterdemo/pages/logout.dart';
import 'package:flutterdemo/pages/register.dart';
import 'package:flutterdemo/pages/welcome.dart';
import 'package:flutterdemo/provider/authpage.dart';
import 'package:flutterdemo/provider/userprovider.dart';
import 'package:flutterdemo/sharedprefrences.dart';
import 'package:flutterdemo/user.dart';

import 'package:provider/provider.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<User> getUserData() => UserPreferences().getUser();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: FutureBuilder(
              future: getUserData(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  default:
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    else if (snapshot.data?.userId == null)
                      return Login();
                    else
                      UserPreferences().removeUser();
                    return Welcome(user: snapshot.data);
                }
              }),
          routes: {
            '/dashboard': (context) => DashBoard(),
            '/login': (context) => Login(),
            '/register': (context) => Register(),
            '/changepass': (context) => changepass(),
            '/logout': (context) => Logout(),
          }),
    );
  }
}