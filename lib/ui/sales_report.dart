import 'package:flutter/cupertino.dart';

class SalesReport extends StatefulWidget {
  const SalesReport({super.key});

  @override
  State<SalesReport> createState() => _SalesReportState();
}

class _SalesReportState extends State<SalesReport> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Screen assa',
        style: TextStyle(fontSize: 30),
      ),
    );
  }
}
