import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_uts/screens/list_product.dart';

class AddProduct extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameController =
      TextEditingController(); // tambahkan ini juga jika belum
  final _priceController =
      TextEditingController(); // tambahkan ini juga jika belum
  final _imgController =
      TextEditingController(); // tambahkan ini juga jika belum

  Future saveProduct() async {
    final response =
        await http.post(Uri.parse('http://10.0.2.2:8000/api/products'), body: {
      'name': _nameController.text,
      'price': _priceController.text,
      'img': _imgController.text,
    });
    return (response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Product'),
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
                    decoration: InputDecoration(labelText: "Nama Product"),
                  ),
                  TextFormField(
                    controller: _priceController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Harga tidak boleh kosong!!";
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: "Harga Product"),
                  ),
                  TextFormField(
                    controller: _imgController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Gambar tidak boleh kosong!!";
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: "Gambar"),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        saveProduct().then((value) {
                          // response dari saveProduct
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListProduct()),
                          );
                          print("berhasil"); // output respons ke konsol
                        });
                      }
                    },
                    child: Text("Simpan"),
                  )
                ],
              ),
            )));
  }
}
