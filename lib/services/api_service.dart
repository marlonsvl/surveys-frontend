import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/survey_models.dart';
import '../config/api_config.dart';

class ApiService {
  Future<void> submitSurvey(SurveyResponse response) async {
    try {
      final url = Uri.parse('${ApiConfig.baseUrl}${ApiConfig.submitSurveyEndpoint}');
      
      print('🔵 Submitting to: $url');
      print('🔵 Data: ${json.encode(response.toJson())}');

      final jsonData = response.toJson();
      
      final httpResponse = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(jsonData),
      );

      print('🟢 Status: ${httpResponse.statusCode}');
      print('🟢 Response: ${httpResponse.body}');
      
      if (httpResponse.statusCode != 201 && httpResponse.statusCode != 200) {
        final errorBody = json.decode(httpResponse.body);
        throw Exception('Error al enviar la encuesta: ${errorBody.toString()}');
      }
    } catch (e) {
      print('🔴 Error: $e');
      throw Exception('Error de conexión: $e');
    }
  }
}