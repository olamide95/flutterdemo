import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/authpage.dart';
import '../provider/userprovider.dart';
import '../user.dart';
import '../widgetclass.dart';

class changepass extends StatefulWidget {
  @override
  _changepassState createState() => _changepassState();
}

class _changepassState extends State<changepass> {
  final formKey = new GlobalKey<FormState>();

  String _newpassword, _password,_userId;

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    final PasswordField = TextFormField(
      autofocus: false,
      onSaved: (value) => _password = value,
      decoration: buildInputDecoration("Confirm password", Icons.email),
    );

    final newpasswordField = TextFormField(
      autofocus: false,
      obscureText: true,
      validator: (value) => value.isEmpty ? "Please enter password" : null,
      onSaved: (value) => _newpassword = value,
      decoration: buildInputDecoration("Confirm password", Icons.lock),
    );
    final userIdField = TextFormField(
      autofocus: false,
      obscureText: true,
      validator: (value) => value.isEmpty ? "Please enter password" : null,
      onSaved: (value) => _userId = value,
      decoration: buildInputDecoration("Confirm password", Icons.lock),
    );

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Authenticating ... Please wait")
      ],
    );

    final forgotLabel = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TextButton(
          child: Text("Forgot password?",
              style: TextStyle(fontWeight: FontWeight.w300)),
          onPressed: () {
//            Navigator.pushReplacementNamed(context, '/reset-password');
          },
        ),
        TextButton(
          child: Text("Sign up", style: TextStyle(fontWeight: FontWeight.w300)),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/register');
          },
        ),
      ],
    );

    changepassword() {
      final form = formKey.currentState;

      {
        form?.save();

        final Future<Map<String, dynamic>> successfulMessage =
        auth.changepassword( _password,_newpassword,_userId);

        successfulMessage.then((response) {
          if (response['status']) {
            User user = response['user'];
            Provider.of<UserProvider>(context, listen: false).setUser(user);
            Navigator.pushReplacementNamed(context, '/dashboard');
          } else {
            Flushbar(
              title: "Failed Login",
              message: response['message']['message'].toString(),
              duration: Duration(seconds: 3),
            ).show(context);
          }
        });
      }
    }

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(40.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.0),
                label("password"),
                SizedBox(height: 5.0),
                PasswordField,
                SizedBox(height: 20.0),
                label("newPassword"),
                SizedBox(height: 5.0),
                newpasswordField,
                SizedBox(height: 20.0),
                label("userId"),
                SizedBox(height: 5.0),
                userIdField,
                SizedBox(height: 20.0),
                auth.changepassword == true
                    ? loading
                    : longButtons("ChangePassword", changepassword()),
                SizedBox(height: 5.0),

              ],
            ),
          ),
        ),
      ),
    );
  }
}