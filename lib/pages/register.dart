import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../provider/authpage.dart';
import '../provider/userprovider.dart';
import '../user.dart';
import '../widgetclass.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = new GlobalKey<FormState>();

  String _firstname,_lastname,_phone,_email, _password;

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    final firstnameField = TextFormField(
      autofocus: false,

      onSaved: (value) => _firstname = value,
      decoration: buildInputDecoration("Confirm password", Icons.email),
    );

    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      validator: (value) => value.isEmpty ? "Please enter password" : null,
      onSaved: (value) => _password = value,
      decoration: buildInputDecoration("Confirm password", Icons.lock),
    );

    final lastname = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Your password is required" : null,
      onSaved: (value) => _lastname= value,
      obscureText: true,
      decoration: buildInputDecoration("Confirm password", Icons.lock),
    );
    final emailField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Your password is required" : null,
      onSaved: (value) => _email= value,
      obscureText: true,
      decoration: buildInputDecoration("Confirm password", Icons.lock),
    );
    final phoneField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Your password is required" : null,
      onSaved: (value) => _phone= value,
      obscureText: true,
      decoration: buildInputDecoration("Confirm password", Icons.lock),
    );


    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Registering ... Please wait")
      ],
    );

    var doRegister = () {
      final form = formKey.currentState;
      if (form.validate()) {
        form.save();
        auth.register(_firstname,_lastname,_phone,_email, _password,).then((response) {
          if (response['status']) {
            User user = response['data'];
            Provider.of<UserProvider>(context, listen: false).setUser(user);
            Navigator.pushReplacementNamed(context, '/dashboard');
          } else {
            Flushbar(
              title: "Registration Failed",
              message: response.toString(),
              duration: Duration(seconds: 10),
            ).show(context);
          }
        });
      } else {
        Flushbar(
          title: "Invalid form",
          message: "Please Complete the form properly",
          duration: Duration(seconds: 10),
        ).show(context);
      }

    };

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
                label("firstname"),
                SizedBox(height: 5.0),
                firstnameField,
                SizedBox(height: 15.0),
                label("lastname"),
                SizedBox(height: 5.0),
                lastname,
                SizedBox(height: 15.0),
                label("email"),
                SizedBox(height: 5.0),
                emailField,
                SizedBox(height: 15.0),
                label("phone"),
                SizedBox(height: 5.0),
                phoneField,
                SizedBox(height: 15.0),
                label("Password"),
                SizedBox(height: 10.0),
                passwordField,


                SizedBox(height: 20.0),
                auth.loggedInStatus == Status.Authenticating
                    ? loading
                    : longButtons("Login", doRegister),
              ],
            ),
          ),
        ),
      ),
    );
  }
}