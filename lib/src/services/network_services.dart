import 'package:dio/dio.dart';
import 'package:marker/src/constants/api.dart';
import 'package:marker/src/models/credential_model.dart';
import 'package:marker/src/models/note_content_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetworkService {
  NetworkService._internal();

  static final NetworkService _instance = NetworkService._internal();

  factory NetworkService() => _instance;

  static final _dio = Dio();

  Future userLogin(Credential credential) async {
    const url = API.loginUrl;
    final Response response = await _dio.post(url, data: credential.toJson());
    if (response.statusCode == 200) {
      return response.data;
    }
    throw Exception('Network Fail');
  }

  Future noteGetAll() async {
    const url = API.noteUrl;
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token') ?? "";
    final Response response = await _dio.get(url,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        }));
    if (response.statusCode == 200) {
      return response.data;
    }
    throw Exception('Network Fail');
  }

  Future noteAddNewNote(NoteContent noteContent) async {
    const url = API.noteUrl;
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token') ?? "";
    final Response response = await _dio.post(url,
        data: noteContent.toJson(),
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        }));
    if (response.statusCode == 201) {
      return response.data;
    }
    throw Exception('Network Fail');
  }

  Future noteDeleteNote(String id) async {
    const url = API.noteUrl;
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token') ?? "";
    final Response response = await _dio.delete('$url/$id',
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        }));
    if (response.statusCode == 200) {
      return response.data;
    }
    throw Exception('Network Fail');
  }
}
