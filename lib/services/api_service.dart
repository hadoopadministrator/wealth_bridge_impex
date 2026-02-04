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
    required String address,
    required String landmark,
    required String pincode,
    required String gst,
  }) async {
    final safeLandmark = landmark.trim();

    final String queryString =
        'fullname=${Uri.encodeComponent(fullName.trim())}'
        '&email=${Uri.encodeComponent(email.trim())}'
        '&mobile=${Uri.encodeComponent(mobile.trim())}'
        '&password=${Uri.encodeComponent(password.trim())}'
        '&address=${Uri.encodeComponent(address.trim())}'
        '&landmark=${Uri.encodeComponent(safeLandmark)}'
        '&pincode=${Uri.encodeComponent(pincode.trim())}'
        '&gst=${Uri.encodeComponent(gst.trim())}';

    final Uri url = Uri.parse('$_baseUrl/RegisterUser?$queryString');

    debugPrint('Register API URL: $url');

    try {
      final response = await http.get(url);

      if (response.statusCode != 200) {
        return {
          'success': false,
          'message': 'Server error: ${response.statusCode}',
        };
      }

      // Remove XML wrapper
      final cleanResponse = response.body
          .replaceAll(RegExp(r'<[^>]*>'), '')
          .trim();

      final Map<String, dynamic> jsonData = jsonDecode(cleanResponse);

      final bool isSuccess =
          jsonData['Status']?.toString().toLowerCase() == 'success';

      final String message =
          jsonData['Message']?.toString() ??
          (isSuccess ? 'Registered successfully' : 'Registration failed');

      return {'success': isSuccess, 'message': message};
    } catch (e) {
      debugPrint('Register Error: $e');
      return {'success': false, 'message': 'Something went wrong'};
    }
  }

  /// LOGIN USER (GET)
  Future<Map<String, dynamic>> loginUser({
    required String emailOrMobile,
    required String password,
  }) async {
    final Uri url = Uri.parse('$_baseUrl/LoginUser').replace(
      queryParameters: {
        'emailOrMobile': emailOrMobile.trim(),
        'password': password.trim(),
      },
    );

    debugPrint('Login API URL: $url');

    try {
      final response = await http.get(url);

      if (response.statusCode != 200) {
        return {
          'success': false,
          'message': 'Server error: ${response.statusCode}',
        };
      }

      final cleanJson = response.body.replaceAll(RegExp(r'<[^>]*>'), '').trim();

      debugPrint('response: $cleanJson');

      final Map<String, dynamic> jsonData = jsonDecode(cleanJson);

      final bool isSuccess =
          jsonData['Status']?.toString().toLowerCase() == 'success';

      return {
        'success': isSuccess,
        'message':
            jsonData['Message']?.toString() ??
            (isSuccess ? 'Login successful' : 'Login failed'),
        'data': jsonData,
      };
    } catch (e) {
      debugPrint('Login Error: $e');
      return {'success': false, 'message': 'Something went wrong'};
    }
  }

  /// Update User Profile
  Future<void> updateUserProfile({
  required int id,
  required String fullname,
  required String email,
  required String mobile,
  required String address,
  required String landmark,
  required String pincode,
  required String gst,
}) async {
  final Uri url =
      Uri.parse('https://wealthbridgeimpex.com/webservice.asmx');

  final String body = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
               xmlns:xsd="http://www.w3.org/2001/XMLSchema"
               xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <UpdateUserProfile xmlns="http://tempuri.org/">
      <id>$id</id>
      <fullname>$fullname</fullname>
      <email>$email</email>
      <mobile>$mobile</mobile>
      <address>$address</address>
      <landmark>$landmark</landmark>
      <pincode>$pincode</pincode>
      <gst>$gst</gst>
    </UpdateUserProfile>
  </soap:Body>
</soap:Envelope>
''';

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'text/xml; charset=utf-8',
        'SOAPAction': 'http://tempuri.org/UpdateUserProfile',
      },
      body: body,
    );

    // print('Status Code: ${response.statusCode}');
    print('Response Body:\n${response.body}\n');
  } catch (e) {
    print('Error updating profile: $e');
  }
}
}
