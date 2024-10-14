import 'dart:convert';
import 'package:harper/config.dart';
import 'package:harper/logger.dart';
import 'package:http/http.dart' as http;
import 'package:harper/Models/Dast/savedprojects.dart';

class SavedDASTServiceAPI {
  final String baseUrl = EnvLoader().getApiUrl();
  final String newUrl = 'dast/projects/saved';

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
