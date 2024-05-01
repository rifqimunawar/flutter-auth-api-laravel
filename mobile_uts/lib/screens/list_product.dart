import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_uts/screens/add_product.dart';
import 'package:mobile_uts/screens/edit_product.dart';
import 'package:mobile_uts/screens/product_detail.dart';

class ListProduct extends StatefulWidget {
  const ListProduct({
    super.key,
  });

  @override
  State<ListProduct> createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  // final String url = 'http://127.0.0.1:8000/api/products';
  final String url = 'http://10.0.2.2:8000/api/products';

  Future getProducs() async {
    var response = await http.get(Uri.parse(url));
    print(response.body);
    return json.decode(response.body);
  }

  Future<void> deleteProduct(String id) async {
    String url = 'http://10.0.2.2:8000/api/product/' + id;

    var response = await http.delete(Uri.parse(url));
    print(response.body);
    print("Produk dengan ID $id berhasil dihapus");
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditProduct(
                                            product: snapshot.data['products']
                                                [index]),
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.edit,
                                  ),
                                ),
                                SizedBox(
                                    height:
                                        5), // Tambahkan sedikit ruang di antara ikon
                                GestureDetector(
                                  onTap: () {
                                    String productId = snapshot.data['products']
                                            [index]['id']
                                        .toString();
                                    deleteProduct(productId).then((value) {
                                      setState(() {});
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text("Menghapus Produk..."),
                                          duration: Duration(seconds: 1),
                                        ),
                                      );
                                    });
                                  },
                                  child: Icon(
                                    Icons.delete,
                                  ),
                                ),
                              ],
                            ),
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
