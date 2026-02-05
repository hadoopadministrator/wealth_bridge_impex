import 'package:flutter/material.dart';
import 'package:wealth_bridge_impex/routes/app_routes.dart';
import 'package:wealth_bridge_impex/services/api_service.dart';
import 'package:wealth_bridge_impex/utils/app_colors.dart';
import 'package:wealth_bridge_impex/utils/input_decoration.dart';
import 'package:wealth_bridge_impex/widgets/custom_button.dart';
import 'package:wealth_bridge_impex/widgets/drawer_widget.dart';

class LiveRatesScreen extends StatefulWidget {
  const LiveRatesScreen({super.key});

  @override
  State<LiveRatesScreen> createState() => _LiveRatesScreenState();
}

class _LiveRatesScreenState extends State<LiveRatesScreen> {
  final TextEditingController _qtyController = TextEditingController(text: '1');
  int _quantity = 1000;
  Map<String, dynamic>? _copperRate;
  bool _isLoading = true;
  final apiService = ApiService();

  Future<void> _fetchLiveRates() async {
    setState(() => _isLoading = true);

    final result = await apiService.getLiveCopperRate();

    if (result['success'] == true) {
      setState(() {
        _copperRate = result['data'];
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'] ?? 'Failed to load rates')),
      );
    }
  }

  void _incrementQty() {
    setState(() {
      _quantity++;
      _qtyController.text = _quantity.toString();
    });
  }

  void _decrementQty() {
    if (_quantity <= 1000) return;
    setState(() {
      _quantity--;
      _qtyController.text = _quantity.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchLiveRates();
  }

  @override
  void dispose() {
    _qtyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Live Prices',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.cart);
            },
            icon: Icon(Icons.shopping_cart_checkout_sharp),
          ),
        ],
      ),
      drawer: DrawerWidget(),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _copperRate == null
            ? const Center(child: Text('No data available'))
            : SingleChildScrollView(
                // padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    ListView.builder(
                      itemCount: _copperRate!['Slabs'].length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16.0),
                      itemBuilder: (context, index) {
                        final slab = _copperRate!['Slabs'][index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 16.0),
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: AppColors.black,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "COPPER PRICE",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "(${slab['SlabName']})",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(
                                    "Buy: ₹ ${slab['BuyPrice']}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Qty: ${slab['SlabName']}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  CustomButton(
                                    text: 'BUY',
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      // horizontal: 24,
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.checkOut,
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  CustomButton(
                                    text: 'ADD TO CART',
                                    backgroundColor: AppColors.greenDark,
                                    foregroundColor: AppColors.white,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 14,
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.cart,
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextField(
                                      controller: _qtyController,
                                      keyboardType: TextInputType.number,
                                      cursorColor: Colors.black,
                                      textInputAction: TextInputAction.done,
                                      decoration: AppDecorations.textField(
                                        label: '',
                                        suffixIcon: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: _incrementQty,
                                              child: const Icon(
                                                Icons.keyboard_arrow_up,
                                                size: 22,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: _decrementQty,
                                              child: const Icon(
                                                Icons.keyboard_arrow_down,
                                                size: 22,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onChanged: (value) {
                                        final parsed = int.tryParse(value);
                                        if (parsed != null && parsed > 1000) {
                                          _quantity = parsed;
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
