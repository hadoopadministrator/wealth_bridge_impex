import 'package:flutter/material.dart';
import 'package:wealth_bridge_impex/screens/login_screen.dart';
import 'package:wealth_bridge_impex/screens/order_history.dart';
import 'package:wealth_bridge_impex/screens/profile_screen.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xffF5F6FA),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.white),
            child: Image.asset('assets/logo/logo.jpeg', fit: BoxFit.fill),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.black),
            title: const Text('Live Prices', style: TextStyle(fontSize: 18)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.black),
            title: const Text('Profile', style: TextStyle(fontSize: 18)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.history, color: Colors.black),
            title: const Text('Order History', style: TextStyle(fontSize: 18)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OrderHistory()),
              );
            },
          ),
          ListTile(
            title: const Text(
              'Visit our Website',
              style: TextStyle(fontSize: 18),
            ),
            leading: const Icon(Icons.web, color: Colors.black),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Contact Us', style: TextStyle(fontSize: 18)),
            leading: const Icon(Icons.contact_mail, color: Colors.black),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.share, color: Colors.black),
            title: const Text('Share this App', style: TextStyle(fontSize: 18)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.star, color: Colors.black),
            title: const Text('Rate this App', style: TextStyle(fontSize: 18)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.black),
            title: const Text('Logout', style: TextStyle(fontSize: 18)),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
