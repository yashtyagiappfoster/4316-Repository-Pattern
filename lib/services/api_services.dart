import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiCall {
  static Future<void> login(
      String email, String password, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse('https://reqres.in/api/login'),
          body: {'email': 'eve.holt@reqres.in', 'password': 'cityslicka'});
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data['token']);
        print('Login successfully');
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Logged in Successfully'),
          ),
        );
      } else {
        throw Exception('Something went wrong');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
