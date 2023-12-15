import 'dart:convert';
import 'package:http/http.dart' as http;
import 'User.dart';

class Services {
  //static const String url = 'http://60.50.96.153/intec-erp/public/get-customers';
  static const String url = 'http://192.168.0.14/new-tsk-cp-dev/public/api/project';
  static Future<List<User>> getUsers() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<User> list = parseUsers(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<User> parseUsers(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }
}