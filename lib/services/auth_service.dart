import 'dart:convert';

import 'package:at_events/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseURL = 'https://chyazarkkwiioawhxilu.supabase.co';
  final String _supabaseKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNoeWF6YXJra3dpaW9hd2h4aWx1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzEwMjYyMDIsImV4cCI6MTk4NjYwMjIwMn0.GafapDJw7OVoOdN3osBigeYBp3RzQnocYX8UCxDyH1k';
  final storage = const FlutterSecureStorage();
  User user = User();

  Future getUser() async {
    final token = await readToken();
    final Map<String, String> headers = {
      'apiKey': _supabaseKey,
      'Authorization': 'Bearer $token',
    };

    final url = Uri.parse('$_baseURL/auth/v1/user');
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 401) return null;

    final Map<String, dynamic> decodeResponse = json.decode(response.body);
    print('filling user data');

    user.id = decodeResponse['id'];
    user.email = decodeResponse['email'];
    user.userName = decodeResponse['user_metadata']['user_name'];
    user.name = decodeResponse['user_metadata']['name'];
    user.lastName = decodeResponse['user_metadata']['last_name'];
    user.phone = decodeResponse['user_metadata']['phone'];
    user.imageName = decodeResponse['user_metadata']['profile_image'];

    notifyListeners();
    return user;
  }

  Future<String?> createUser() async {
    final Map<String, dynamic> authData = {
      'email': user.email,
      'password': user.password,
      'data': {
        'user_name': user.userName,
        'name': '',
        'last_name': '',
        'phone': '',
        'profile_image': ''
      }
    };
    final Map<String, String> headers = {'apiKey': _supabaseKey};

    final url = Uri.parse('$_baseURL/auth/v1/signup');
    final response =
        await http.post(url, headers: headers, body: json.encode(authData));
    final Map<String, dynamic> decodeResponse = json.decode(response.body);

    if (decodeResponse.containsKey('access_token')) {
      storage.write(key: 'token', value: decodeResponse['access_token']);

      //Fill the fields of the user according the response
      user.id = decodeResponse['user']['id'];
      user.userName = decodeResponse['user']['user_metadata']['user_name'];
      user.name = decodeResponse['user']['user_metadata']['name'];
      user.lastName = decodeResponse['user']['user_metadata']['last_name'];
      user.phone = decodeResponse['user']['user_metadata']['phone'];
      user.imageName = decodeResponse['user']['user_metadata']['profile_image'];
      return null;
    }
    return decodeResponse['msg'];
  }

  Future<String?> login() async {
    final Map<String, dynamic> authData = {
      'email': user.email,
      'password': user.password,
    };
    final Map<String, String> headers = {'apiKey': _supabaseKey};

    final url = Uri.parse('$_baseURL/auth/v1/token?grant_type=password');
    final response =
        await http.post(url, headers: headers, body: json.encode(authData));
    final Map<String, dynamic> decodeResponse = json.decode(response.body);

    if (decodeResponse.containsKey('access_token')) {
      storage.write(key: 'token', value: decodeResponse['access_token']);

      //Fill the fields of the user according the response
      user.id = decodeResponse['user']['id'];
      user.userName = decodeResponse['user']['user_metadata']['user_name'];
      user.name = decodeResponse['user']['user_metadata']['name'];
      user.lastName = decodeResponse['user']['user_metadata']['last_name'];
      user.phone = decodeResponse['user']['user_metadata']['phone'];
      user.imageName = decodeResponse['user']['user_metadata']['profile_image'];
      return null;
    }
    return decodeResponse['error_description'];
  }

  Future updateUser() async {
    final token = await readToken();
    final Map<String, dynamic> data = {
      'email': user.email,
      'password': user.password,
      'data': {
        'user_name': user.userName,
        'name': user.name,
        'last_name': user.lastName,
        'phone': user.phone,
        'profile_image': user.imageName
      }
    };
    print('profile_image: ${user.imageName}');
    final Map<String, String> headers = {
      'apiKey': _supabaseKey,
      'Authorization': 'Bearer $token',
    };

    final url = Uri.parse('$_baseURL/auth/v1/user');
    final response =
        await http.put(url, headers: headers, body: json.encode(data));
    final Map<String, dynamic> decodeResponse = json.decode(response.body);
    print(decodeResponse);
    notifyListeners();
  }

  Future closeSession() async {
    user = User();
    return await storage.delete(key: 'token');
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}
