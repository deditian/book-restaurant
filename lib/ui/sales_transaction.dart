import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SalesTransaction extends StatefulWidget {
  const SalesTransaction({super.key});

  @override
  State<SalesTransaction> createState() => _SalesTransactionState();
}

class _SalesTransactionState extends State<SalesTransaction> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Screen A',
        style: TextStyle(fontSize: 30),
      ),
    );
  }
}
