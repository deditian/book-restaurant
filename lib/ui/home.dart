import 'package:book_restorant/ui/product_settings.dart';
import 'package:book_restorant/ui/sales_report.dart';
import 'package:book_restorant/ui/sales_transaction.dart';
import 'package:book_restorant/ui/table_management.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  int? toTab;
  HomePage({super.key, this.toTab});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  void initState() {
    super.initState();
    if(widget.toTab !=null) {
      _onItemTapped(widget.toTab!);
    }
  }

  _onItemPage() {
    switch(_selectedIndex) {
      case 3:
        return SalesReport();
      case 2:
        return ProductSettings();
      case 1:
        return TableManagement();
      default:
        return const SalesTransaction();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _onItemPage(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon:  Icon(Icons.table_bar, ),
              label: "Table",
            ),
            BottomNavigationBarItem(
              icon:  Icon(Icons.settings, ),
              label: "Product",
            ),
            BottomNavigationBarItem(
              icon:  Icon(Icons.report, ),
              label: "Sales",
            ),
          ],

        )
    );
  }
}