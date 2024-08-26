import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/school_model.dart';
import '../screen/school_screen.dart';

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<bool> login(
      BuildContext context, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        print('Response Data: $json');

        if (json['status'] == true) {
          // Login successful
          String token = json['data']['token'];
          // Navigate to the next screen, passing the token
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SchoolScreen(
                apiService: ApiService(baseUrl), // pass the ApiService instance
                token: token, // pass the token to the next screen
              ),
            ),
          );
          return true;
        } else {
          // Handle the login failure scenario
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Invalid email or password')),
          );
          return false;
        }
      } else {
        // Handle unexpected status codes
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server error: ${response.statusCode}')),
        );
        return false;
      }
    } catch (e) {
      // Handle network or other errors
      print('Error occurred: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
      return false;
    }
  }

// Get Api for school informantion
  Future<schoolModel> fetchSchool(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/school'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return schoolModel.fromJson(json);
    } else {
      throw Exception('Failed to load school data');
    }
  }

  // Future<List<School>> fetchSchools(String token) async {
  //   final response = await http.get(
  //     Uri.parse('$baseUrl/schools'),
  //     headers: {
  //       'Authorization': 'Bearer $token',
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     final List<dynamic> jsonList = jsonDecode(response.body);
  //     return jsonList.map((json) => School.fromJson(json)).toList();
  //   } else {
  //     throw Exception('Failed to load schools');
  //   }
  // }
}
