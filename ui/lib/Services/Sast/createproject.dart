import 'dart:convert';
import 'package:harper/Models/Sast/Createproject.dart';
import 'package:harper/config.dart';
import 'package:harper/logger.dart';
import 'package:http/http.dart' as http;

class CreateProjectAPI {
  Future<void> sendProjectData(CreateProjectModel projectData) async {
    final url = Uri.parse('${EnvLoader().getApiUrl()}/sast/create');
    Logger().info('${EnvLoader().getApiUrl()}/sast/create');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(projectData.toJson()),
      );

      if (response.statusCode == 200) {
        Logger().info('Project data sent successfully!');
        final responseData = jsonDecode(response.body);

        if (responseData['message'] != null){
          Logger().success('Response from the create sast Manager_Projects api with success message');

        }

      } else {
        Logger().error(
            'Failed to send Manager_Projects data. Status code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      Logger().error('Unexpected error occurred on URL $url: $e');
    }
  }
}
