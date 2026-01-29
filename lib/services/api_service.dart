import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl =
      'https://wealthbridgeimpex.com/webservice.asmx';

  /// REGISTER USER (GET)
  Future<Map<String, dynamic>> registerUser({
    required String fullName,
    required String email,
    required String mobile,
    required String password,
  }) async {
    final Uri url = Uri.parse('$_baseUrl/RegisterUser').replace(
      queryParameters: {
        'fullname': fullName,
        'email': email,
        'mobile': mobile,
        'password': password,
      },
    );

    debugPrint('Register API URL: $url');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        debugPrint('Register Raw Response: ${response.body}');

        // Remove XML wrapper
        final cleanText = response.body
            .replaceAll(RegExp(r'<[^>]*>'), '')
            .trim()
            .toLowerCase();

        debugPrint('Register Clean Text: $cleanText');

       if (cleanText == 'success') {
        return {
          'success': true,
          'message': 'Registration successful',
        };
      } else if (cleanText.contains('already')) {
        return {
          'success': false,
          'message': 'User already exists',
        };
      } else {
        return {
          'success': false,
          'message': 'Registration failed',
        };
      }
    } else {
      return {
        'success': false,
        'message': 'Server error: ${response.statusCode}',
      };
    }
    } catch (e) {
      debugPrint('Register Error: $e');
      return {'success': false, 'message': 'Something went wrong'};
    }
  }

  /// LOGIN USER (GET)
  Future<Map<String, dynamic>> loginUser({
    required String username,
    required String password,
  }) async {
    final Uri url = Uri.parse(
      '$_baseUrl/LoginUser',
    ).replace(queryParameters: {'username': username, 'password': password});

    debugPrint('Login API URL: $url');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        debugPrint('Login Raw Response: ${response.body}');
        // Remove XML wrapper
        final xmlRemoved = response.body
            .replaceAll(RegExp(r'<[^>]*>'), '')
            .trim();

        debugPrint('Login Clean JSON: $xmlRemoved');
        // Decode JSON
        final Map<String, dynamic> userData = jsonDecode(xmlRemoved);

        // Check login success
        if (userData.containsKey('ID')) {
          return {
            'success': true,
            'message': 'Login successful',
            'data': userData,
          };
        } else {
          return {'success': false, 'message': 'Invalid mobile or password'};
        }
      } else {
        return {
          'success': false,
          'message': 'Server error: ${response.statusCode}',
        };
      }
    } catch (e) {
      debugPrint('Login Error: $e');
      return {'success': false, 'message': 'Something went wrong'};
    }
  }
}
