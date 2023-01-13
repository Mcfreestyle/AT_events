import 'dart:convert';

import 'package:at_events/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryService extends ChangeNotifier {
  final String baseURL = 'https://chyazarkkwiioawhxilu.supabase.co';
  final List<Category> categories = [];

  CategoryService() {
    // getCategories();
  }

  Future<List<Category>> getCategories() async {
    final Map<String, String> headers = {
      'apikey':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNoeWF6YXJra3dpaW9hd2h4aWx1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzEwMjYyMDIsImV4cCI6MTk4NjYwMjIwMn0.GafapDJw7OVoOdN3osBigeYBp3RzQnocYX8UCxDyH1k',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNoeWF6YXJra3dpaW9hd2h4aWx1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzEwMjYyMDIsImV4cCI6MTk4NjYwMjIwMn0.GafapDJw7OVoOdN3osBigeYBp3RzQnocYX8UCxDyH1k',
    };
    final url = Uri.parse('$baseURL/rest/v1/categories?select=*');
    final response = await http.get(url, headers: headers);
    final List<dynamic> categoriesList = json.decode(response.body);
    print('List of categories: $categoriesList');

    categories.clear();
    categoriesList.forEach((item) {
      final category = Category.fromMap(item);
      categories.add(category);
    });

    notifyListeners();
    print('getting categories from API');
    return categories;
  }
}
