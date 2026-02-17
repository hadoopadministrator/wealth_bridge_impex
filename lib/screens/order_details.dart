import 'package:flutter/material.dart';
import 'package:wealth_bridge_impex/services/api_service.dart';
import 'package:wealth_bridge_impex/utils/app_colors.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  bool isLoading = true;
  Map<String, dynamic>? order;
  String? error;
  int? orderId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    orderId = args?['orderId'];
    if (orderId != null) fetchOrderDetails();
  }

  Future<void> fetchOrderDetails() async {
    if (orderId == null) return;
    try {
      final result = await ApiService().getOrderById(orderId: orderId!);
      if (result['success'] == true) {
        setState(() {
          order = result['data'];
          isLoading = false;
        });
      } else {
        setState(() {
          error = result['message'] ?? 'Failed to fetch order details';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Something went wrong';
        isLoading = false;
      });
    }
  }

  Widget sectionCard({required String title, required List<Widget> children}) {
    return Card(
      color: AppColors.white,
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget buildRow(
    String label,
    String value, {
    Color? valueColor,
    bool isMultiline = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: isMultiline
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: valueColor ?? AppColors.black,
                fontWeight: valueColor != null ? FontWeight.bold : null,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        iconTheme: const IconThemeData(color: AppColors.black),
        title: const Text(
          "Order Details",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : error != null
            ? Center(
                child: Text(
                  error!,
                  style: const TextStyle(fontSize: 16, color: Colors.red),
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView(
                  children: [
                    // Order Info Section
                    sectionCard(
                      title: "Order Info",
                      children: [
                        buildRow("Slab", order?["Slab"] ?? ""),
                        buildRow("Type", order?["Type"] ?? ""),
                        buildRow("Quantity", order?["Qty"]?.toString() ?? ""),
                        buildRow(
                          "Price per KG",
                          "₹${order?["PricePerKg"]?.toStringAsFixed(2) ?? "0"}",
                        ),
                        buildRow(
                          "Total",
                          "₹${order?["Total"]?.toStringAsFixed(2) ?? "0"}",
                          valueColor: AppColors.orangeDark,
                        ),
                      ],
                    ),

                    // Payment Info Section
                    sectionCard(
                      title: "Payment Info",
                      children: [
                        buildRow(
                          "GST",
                          "₹${order?["Gst"]?.toStringAsFixed(2) ?? "0"}",
                        ),
                        buildRow(
                          "Courier",
                          "₹${order?["Courier"]?.toStringAsFixed(2) ?? "0"}",
                        ),
                        buildRow(
                          "Payment Status",
                          order?["PaymentStatus"] ?? "",
                          valueColor: order?["PaymentStatus"] == "Paid"
                              ? Colors.green
                              : Colors.red,
                        ),
                        buildRow(
                          "Razorpay ID",
                          order?["RazorpayPaymentId"] ?? "",
                          isMultiline: true,
                        ),
                      ],
                    ),

                    // Delivery Info Section
                    sectionCard(
                      title: "Delivery Info",
                      children: [
                        buildRow(
                          "Delivery Option",
                          order?["DeliveryOption"] ?? "",
                        ),
                        buildRow(
                          "Address",
                          order?["Address"] ?? "",
                          isMultiline: true,
                        ),
                        buildRow("Order Date", order?["OrderDateTime"] ?? ""),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
