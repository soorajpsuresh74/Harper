import 'dart:convert';
import 'package:harper/config.dart';
import 'package:harper/logger.dart';
import 'package:http/http.dart' as http;
import 'package:harper/Models/Sast/savedprojects.dart';

class FetchSavedServiceAPI {
  final String baseUrl = EnvLoader().getApiUrl();
  final String newUrl = 'saved_projects';

  Future<List<FetchSavedProjectModel>> fetchSavedProjects() async {
    final String url = '$baseUrl/$newUrl';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);

        return jsonResponse
            .map((project) => FetchSavedProjectModel.fromJson(project))
            .toList();
      } else {
        throw Exception('Failed to load saved projects: ${response.statusCode}');
      }
    } catch (e) {
      Logger().error('Error occurred during fetch: $e');
      rethrow;
    }
  }
}
