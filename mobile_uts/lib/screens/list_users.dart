import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_uts/screens/add_product.dart';
import 'package:mobile_uts/screens/edit_product.dart';
import 'package:mobile_uts/screens/product_detail.dart';

class ListUser extends StatefulWidget {
  const ListUser({
    super.key,
  });

  @override
  State<ListUser> createState() => _ListUserState();
}

class _ListUserState extends State<ListUser> {
  // final String url = 'http://127.0.0.1:8000/api/users';
  final String url = 'http://10.0.2.2:8000/api/users';

  Future getUsers() async {
    var response = await http.get(Uri.parse(url));
    print(response.body);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('List Users'),
        ),
        body: FutureBuilder(
          future: getUsers(), // Ubah getUsers() menjadi getUsers saja
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // Ubah menjadi snapshot.data['users'].length
              return ListView.builder(
                itemCount: snapshot.data['users'].length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 100,
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              // Expanded widget harus diletakkan di dalam Column atau Flex
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    snapshot.data['users'][index]['name'],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 4),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Email :',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        TextSpan(
                                          text: snapshot.data['users'][index]
                                              ['email'],
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              // Tambahkan kondisi untuk menangani error
              return Text("Error: ${snapshot.error}");
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
