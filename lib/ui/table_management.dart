import 'package:flutter/cupertino.dart';

class TableManagement extends StatefulWidget {
  const TableManagement({super.key});

  @override
  State<TableManagement> createState() => _TableManagementState();
}

class _TableManagementState extends State<TableManagement> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Screen as',
        style: TextStyle(fontSize: 30),
      ),
    );
  }
}
