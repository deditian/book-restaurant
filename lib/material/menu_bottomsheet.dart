import 'package:flutter/material.dart';

import '../model/menu.dart';

class MenuBottomSheet extends StatefulWidget {
  final Menu menu;
  final Function(Menu) onMenu;
  final int initialCount;

  const MenuBottomSheet({
    Key? key,
    required this.menu,
    required this.onMenu,
    this.initialCount = 1,
  }) : super(key: key);

  @override
  State<MenuBottomSheet> createState() => _MenuBottomSheetState();
}

class _MenuBottomSheetState extends State<MenuBottomSheet> {
  int count = 1;

  @override
  void initState() {
    super.initState();
    count = widget.initialCount;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.white,
      height: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.menu.imageUrl,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.menu.name,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      widget.menu.description,
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Harga: ${widget.menu.price.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Rating: ${widget.menu.rating} (${widget.menu.countRating} ratings)',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  setState(() {
                    if (count > 1) {
                      count--;
                    }
                  });
                },
              ),
              Text(
                '$count',
                style: TextStyle(fontSize: 20),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    count++;
                  });
                },
              ),
            ],
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Batal'),
                style: ElevatedButton.styleFrom(foregroundColor: Colors.red),
              ),
              ElevatedButton(
                onPressed: () {
                  Menu menu = Menu(
                    id: widget.menu.id,
                    name: widget.menu.name,
                    imageUrl: widget.menu.imageUrl,
                    qty: count,
                    description: widget.menu.description,
                    // dateOrder: DateTime.now().toString().substring(0, 16),
                    category:  widget.menu.category,
                    price: widget.menu.price,
                    rating: widget.menu.rating,
                    countRating: widget.menu.countRating,
                  );

                  widget.onMenu(menu);
                  Navigator.pop(context);
                },
                child: Text('Order'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
