import 'package:flutter/material.dart';
import 'package:wealth_bridge_impex/widgets/custom_button.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({super.key});

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  // Example cart items
  final List<Map<String, dynamic>> _cartItems = [
    {
      'slab': '100 KG +',
      'price': 1678.85,
      'qty': 100,
    },
    {
      'slab': '50 - 100 KG',
      'price': 1655.25,
      'qty': 50,
    },
  ];

  // Increment quantity
  void _incrementQty(int index) {
    setState(() {
      _cartItems[index]['qty']++;
    });
  }

  // Decrement quantity
  void _decrementQty(int index) {
    if (_cartItems[index]['qty'] > 1) {
      setState(() {
        _cartItems[index]['qty']--;
      });
    }
  }

  // Remove item
  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
  }

  // Calculate totals
  int get totalQty =>
      _cartItems.fold(0, (sum, item) => sum + item['qty'] as int);

  double get grandTotal => _cartItems.fold(
      0.0, (sum, item) => sum + item['qty'] * item['price']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: _cartItems.isEmpty
                ? const Center(child: Text('Your cart is empty'))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _cartItems.length,
                    itemBuilder: (context, index) {
                      final item = _cartItems[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item['slab'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                  onPressed: () => _removeItem(index),
                                  icon: const Icon(Icons.close),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text('Price: ₹ ${item['price'].toStringAsFixed(2)} / KG'),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () => _decrementQty(index),
                                  icon: const Icon(Icons.remove),
                                ),
                                Text(item['qty'].toString()),
                                IconButton(
                                  onPressed: () => _incrementQty(index),
                                  icon: const Icon(Icons.add),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text('Amount: ₹ ${(item['qty'] * item['price']).toStringAsFixed(2)}'),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Total Quantity: $totalQty KG',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text('Grand Total: ₹ ${grandTotal.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 12),
                CustomButton(
                  text: 'Proceed to Checkout',
                  onPressed: () {
                    // Navigate to checkout
                  },
                ),
              ],
            ),
          )
        ],
      ),
      backgroundColor: const Color(0xffF5F6FA),
    );
  }
}
