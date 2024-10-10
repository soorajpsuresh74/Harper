import 'dart:convert';

import 'package:harper/config.dart';
import 'package:harper/logger.dart';
import 'package:http/http.dart' as http;

import 'package:harper/Models/Sast/projectsmain.dart';

class ProjectManagerMainService{
  final String baseUrl = EnvLoader().getApiUrl();
  final String newUrl = '/projectmanager/fetch1';
  Future<List<ProjectManagerMain>> fetchSavedProjects() async {
    final String url = '$baseUrl/$newUrl';
    try{
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200){
        final List<dynamic> jsonResponse = json.decode(response.body);

        return jsonResponse.map((project) => ProjectManagerMain.fromJson(project)).toList();
      }else{
        throw Exception('Failed to load saved projects: ${response.statusCode}');
      }
    }catch (e){
      Logger().error('Error occurred during fetch: $e');
      rethrow;
    }

  }
}