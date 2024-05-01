import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  final Map product;

  ProductDetail({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Product Detail'),
        ),
        body: Column(children: [
          Container(
            child: Image.network(product['img']),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  product['name'],
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10), // Spasi baru
                Text(
                  "Harga: Rp " + product['price'],
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          )
        ]));
  }
}
