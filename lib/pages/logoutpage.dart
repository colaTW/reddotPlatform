import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutterapp/pages/Member.dart';
import 'package:flutterapp/pages/Member_Fix.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutterapp/APIs.dart';
import 'package:flutterapp/main.dart';




class logoutpage extends StatelessWidget {
  TextEditingController login = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF666259),
        title: Text("Login"),
      ),
    );
  }
}

