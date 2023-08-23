import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: const Text('Cart', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.grey.shade100,
      ),
    ));
  }
}
