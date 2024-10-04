import 'dart:convert';

import 'package:harper/Models/login.dart';
import 'package:harper/config.dart';
import 'package:harper/logger.dart';
import 'package:http/http.dart' as http;

class LoginApiService {
  late final String apiUrl;

  LoginApiService() {
    _initializeApiUrl();
  }

  Future<void> _initializeApiUrl() async {
    try {
      apiUrl = EnvLoader().getApiUrl();
      Logger().info('Successfully fetched $apiUrl');
    } catch (e) {
      Logger().error('Error while fetch api url in LoginApiService');
    }
  }

  Future<String?> login(LoginModel loginModel) async {
    if (apiUrl.isEmpty) {
      Logger().error('API url is not sent');
      return null;
    }
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(loginModel.toJson()),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body)['result'];
      } else {
        Logger().error('Login failed: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      Logger().error('Error during login: $e');
      return null;
    }
  }
}
