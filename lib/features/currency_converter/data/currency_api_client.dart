import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/foundation.dart';


class CurrencyApiClient {
  final String apiUrl = 'https://open.er-api.com/v6/latest/GBP';
  final http.Client client;

  // Constructor allowing client injection, with a default to use http.Client()
  CurrencyApiClient({http.Client? client}) : client = client ?? http.Client();

  Future<Map<String, dynamic>> fetchConversions() async {
    final Map<String, dynamic> output = {};

    try {
      final response = await client.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        output.addAll(data);
      } else {
        debugPrint('Failed to load conversions: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Could not fetch conversions: $e');
    }

    return output;
  }
}

// 
