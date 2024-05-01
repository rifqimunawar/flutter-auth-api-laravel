import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_uts/screens/add_product.dart';
import 'package:mobile_uts/screens/product_detail.dart';

class ListProduct extends StatelessWidget {
  const ListProduct({
    super.key,
  });

  // final String url = 'http://127.0.0.1:8000/api/products';
  final String url = 'http://10.0.2.2:8000/api/products';

  Future getProducs() async {
    var response = await http.get(Uri.parse(url));
    print(response.body);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddProduct()));
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text('List Product'),
        ),
        body: FutureBuilder(
          future: getProducs(), // Ubah getProducs() menjadi getProducs saja
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // Ubah menjadi snapshot.data['products'].length
              return ListView.builder(
                itemCount: snapshot.data['products'].length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 120,
                    child: Card(
                      elevation: 8,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductDetail(
                                          product: snapshot.data['products']
                                              [index])));
                            },
                            child: Container(
                              height: 100,
                              padding: EdgeInsets.all(5),
                              width: 100,
                              child: Image.network(
                                  snapshot.data['products'][index]['img']),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  snapshot.data['products'][index]['name'],
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 4),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Harga: Rp ',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      TextSpan(
                                        text: snapshot.data['products'][index]
                                            ['price'],
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                  // return Text(snapshot.data['products'][index]['name']);
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
