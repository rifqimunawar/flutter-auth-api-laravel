import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_uts/screens/login.dart';

class Register extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameController =
      TextEditingController(); // tambahkan ini juga jika belum
  final _emailController =
      TextEditingController(); // tambahkan ini juga jika belum
  final _passwordController =
      TextEditingController(); // tambahkan ini juga jika belum

  Future registerHandle() async {
    final response =
        await http.post(Uri.parse('http://10.0.2.2:8000/api/register'), body: {
      'name': _nameController.text,
      'email': _emailController.text,
      'password': _passwordController.text,
    });
    return (response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Register User'),
        ),
        body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Nama tidak boleh kosong!!";
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: "Nama Lengkap"),
                  ),
                  TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Eamil tidak boleh kosong!!";
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: "Eamil Anda"),
                  ),
                  TextFormField(
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password tidak boleh kosong!!";
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: "Password"),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Silahkan Login"),
                            duration:
                                Duration(seconds: 1), // Atur durasi snackbar
                          ),
                        );
                        registerHandle().then((value) {
                          // response dari registerHandle
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        });
                      }
                    },
                    child: Text("Register"),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    child: Text("Login"),
                  )
                ],
              ),
            )));
  }
}
