import 'package:book_restorant/controller/category_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../controller/menus_controller.dart';
import 'package:get/get.dart';

import '../material/menu_bottomsheet.dart';
import '../model/menu.dart';
import 'orders_screen.dart';

class SalesTransaction extends StatefulWidget {
  const SalesTransaction({super.key});

  @override
  State<SalesTransaction> createState() => _SalesTransactionState();
}

class _SalesTransactionState extends State<SalesTransaction> {
  final MenusController menusController = Get.put(MenusController());
  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  bool _isSearchVisible = false;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
    });
  }

  void toggleSearchVisibility() {
    setState(() {
      _isSearchVisible = !_isSearchVisible;
      if (!_isSearchVisible) {
        searchController.clear();
        updateSearchQuery('');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearchVisible
            ? TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search menu...',
            border: InputBorder.none,
          ),
          onChanged: updateSearchQuery,
        )
            : Text("Restaurant", style: TextStyle(fontSize: 16)),
        actions: [
          _isSearchVisible
              ? IconButton(
            icon: Icon(Icons.close),
            onPressed: toggleSearchVisibility,
          )
              : IconButton(
            icon: Icon(Icons.search),
            onPressed: toggleSearchVisibility,
          ),
          // Cart icon with order count
          Obx(() {
            return Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OrderListScreen()),
                    );
                  },
                ),
                if (menusController.orderCount > 0)
                  Positioned(
                    right: 1,
                    top: 1,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 5,
                        minHeight: 5,
                      ),
                      child: Text(
                        '${menusController.orderCount}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            );
          }),
        ],
      ),
      body: SalesTransactionScreen(menusController, searchQuery),
    );
  }
}

class SalesTransactionScreen extends StatefulWidget {
  final MenusController menuscontroller;
  final String searchQuery;

  const SalesTransactionScreen(
      this.menuscontroller,
      this.searchQuery, {super.key}
      );

  @override
  State<SalesTransactionScreen> createState() => _SalesTransactionScreenState();
}

class _SalesTransactionScreenState extends State<SalesTransactionScreen> {
  final CategoryController controller = Get.put(CategoryController());

  void showOrderBottomSheet(Menu selectedMenu) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return MenuBottomSheet(
          menu: selectedMenu,
          onMenu: (orderedMenu) {
            widget.menuscontroller.addOrder(orderedMenu);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Category", style: TextStyle(fontSize: 15)),
          Container(
            height: 140,
            child: Obx(() {
              return controller.itemsCategory.isNotEmpty
                  ? ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.itemsCategory.length,
                itemBuilder: (context, index) {
                  var category = controller.itemsCategory[index];
                  bool isSelected = controller.selectedCategory.value == category.name;

                  return Card(
                    elevation: isSelected ? 4 : 1,
                    color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.white,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          controller.setCategory(category.name);
                        });
                      },
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                child: Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Image.network(
                                      category.imageUrl,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 80,
                                child: Text(
                                  textAlign: TextAlign.center,
                                  category.name,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    color: isSelected ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
                  : Center(child: CircularProgressIndicator());
            }),
          ),
          SizedBox(height: 10),
          Text("Menu", style: TextStyle(fontSize: 15)),
          Expanded(
            child: Center(
              child: Obx(() {
                var filteredMenus = widget.menuscontroller.itemsMenu
                    .where((menu) => menu.name.toLowerCase().contains(widget.searchQuery))
                    .toList();

                return filteredMenus.isNotEmpty
                    ? GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: filteredMenus.map((menu) {
                    return Card(
                      elevation: 1,
                      child: InkWell(
                        onTap: () {
                          showOrderBottomSheet(menu);
                        },
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  child: Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15.0),
                                      child: Image.network(
                                        menu.imageUrl,
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 80,
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    menu.name,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                )
                    : Center(child: Text('No menu items available.'));
              }),
            ),
          ),
        ],
      ),
    );
  }
}
