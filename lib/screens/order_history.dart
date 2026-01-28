import 'package:flutter/material.dart';
import 'package:wealth_bridge_impex/screens/live_price_screen.dart';
import 'package:wealth_bridge_impex/widgets/order_card.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  final List<Map<String, String>> orders = [
    {
      "date": "21/01/26",
      "slab": "0.25 kg",
      "type": "Buy",
      "quantity": "3",
      "total": "₹16,680",
      "status": "Paid",
    },
    {
      "date": "22/01/26",
      "slab": "0.50 kg",
      "type": "Buy",
      "quantity": "2",
      "total": "₹27,900",
      "status": "Paid",
    },
    {
      "date": "23/01/26",
      "slab": "1.00 kg",
      "type": "Sell",
      "quantity": "1",
      "total": "₹14,350",
      "status": "Pending",
    },
    {
      "date": "24/01/26",
      "slab": "0.25 kg",
      "type": "Buy",
      "quantity": "5",
      "total": "₹27,800",
      "status": "Paid",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const LivePriceScreen(),
              ),
              (route) => false,
            );
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Order History",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return OrderCard(
              date: order["date"]!,
              slab: order["slab"]!,
              type: order["type"]!,
              quantity: order["quantity"]!,
              total: order["total"]!,
              status: order["status"]!,
            );
          },
        ),
      ),
    );
  }
}
