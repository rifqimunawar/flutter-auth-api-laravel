import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_uts/screens/homepage.dart';
import 'package:mobile_uts/screens/register.dart';

class Login extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future loginHandle(BuildContext context) async {
    final response =
        await http.post(Uri.parse('http://10.0.2.2:8000/api/login'), body: {
      'email': _emailController.text,
      'password': _passwordController.text,
    });
    print(response.body);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login User'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email tidak boleh kosong!!";
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: "Email"),
              ),
              TextFormField(
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password tidak boleh kosong!!";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Password",
                  // suffixIcon: Icon(
                  //     Icons.visibility_off),
                ),
                obscureText: true,
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    loginHandle(context).then((response) {
                      if (response.statusCode == 200) {
                        var responseData = json.decode(response.body);
                        if (responseData['status'] == 'success') {
                          var dataName = responseData['data']['name'];
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  HomePage(dataName: dataName),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Login successful"),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Email atau password salah"),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Email atau password salah"),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Email atau password salah"),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                },
                child: Text("Login"),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Register()),
                  );
                },
                child: Text("Register"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
