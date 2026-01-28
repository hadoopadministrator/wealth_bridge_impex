import 'package:flutter/material.dart';

class PriceWidget extends StatelessWidget {
  final String title;
  final String price;
  final String unit;
  const PriceWidget({
    super.key,
    required this.title,
    required this.price,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: const Color(0xffF9B236), width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: const Color(0xffF9B236)),
            ),
            SizedBox(height: 4),
            Text(
              price,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 4),
            Text(unit, style: TextStyle(fontSize: 14, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
