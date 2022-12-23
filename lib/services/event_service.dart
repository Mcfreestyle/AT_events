import 'dart:convert';

import 'package:at_events/providers/storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:at_events/models/event_model.dart';
import 'package:intl/intl.dart';

class EventService extends ChangeNotifier {
  final String baseURL = 'https://chyazarkkwiioawhxilu.supabase.co';
  late StorageImageProvider _storageImage;
  final List<Event> events = [];
  List<Event> eventsByCategory = [];
  Event? selectedEvent;
  bool isLoading = true;
  // bool isSaving = false;

  EventService() {
    showEvents();
  }

  StorageImageProvider get storageImage => _storageImage;

  set storageImage(newStorage) {
    _storageImage = newStorage;
    notifyListeners();
  }

  Future<List<Event>> showEvents() async {
    isLoading = true;
    notifyListeners();

    final Map<String, String> headers = {
      'apikey':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNoeWF6YXJra3dpaW9hd2h4aWx1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzEwMjYyMDIsImV4cCI6MTk4NjYwMjIwMn0.GafapDJw7OVoOdN3osBigeYBp3RzQnocYX8UCxDyH1k',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNoeWF6YXJra3dpaW9hd2h4aWx1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzEwMjYyMDIsImV4cCI6MTk4NjYwMjIwMn0.GafapDJw7OVoOdN3osBigeYBp3RzQnocYX8UCxDyH1k',
    };
    final url = Uri.parse('$baseURL/rest/v1/events?select=*');
    final response = await http.get(url, headers: headers);
    final List<dynamic> eventsList = json.decode(response.body);
    print('List of events: $eventsList');

    eventsList.forEach((item) async {
      final event = Event.fromMap(item);
      final uint8Image =
          await _storageImage.downloadImageStorage(event.imageName);
      event.uint8Image = uint8Image;
      events.add(event);
    });
    isLoading = false;

    notifyListeners();
    print('getting events from API');
    return events;
  }

  List<Event> showEventsByDay(DateTime day) {
    List<Event> eventsByDate = [];
    final stringDay = DateFormat('dd:mm:yyyy').format(day);

    events.forEach((event) {
      final stringDate = DateFormat('dd:mm:yyyy').format(event.date!);

      if (stringDate == stringDay) {
        eventsByDate.add(event);
      }
    });
    return eventsByDate;
  }

  List<Event> showEvenstByPrice(bool price) {
    List<Event> freeEvents = [];
    List<Event> privateEvents = [];

    events.forEach((event) {
      if (event.price == 0.0) {
        freeEvents.add(event);
      } else {
        privateEvents.add(event);
      }
    });

    if (price) return privateEvents;
    return freeEvents;
  }

  Future<List<Event>> showEventsByCategory(int categoryId) async {
    final Map<String, String> headers = {
      'apikey':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNoeWF6YXJra3dpaW9hd2h4aWx1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzEwMjYyMDIsImV4cCI6MTk4NjYwMjIwMn0.GafapDJw7OVoOdN3osBigeYBp3RzQnocYX8UCxDyH1k',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNoeWF6YXJra3dpaW9hd2h4aWx1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzEwMjYyMDIsImV4cCI6MTk4NjYwMjIwMn0.GafapDJw7OVoOdN3osBigeYBp3RzQnocYX8UCxDyH1k',
    };
    final url = Uri.parse(
        '$baseURL/rest/v1/categories?id=eq.$categoryId&select=events(*)');
    final response = await http.get(url, headers: headers);
    final List<dynamic> eventsList = json.decode(response.body)[0]['events'];
    print('List of events by category: $eventsList');

    eventsByCategory = [];
    eventsList.forEach((item) async {
      final event = Event.fromMap(item);
      final uint8Image =
          await _storageImage.downloadImageStorage(event.imageName);
      event.uint8Image = uint8Image;
      eventsByCategory.add(event);
    });
    notifyListeners();
    return eventsByCategory;
  }

  Future createEvent(Event event) async {
    final Map<String, String> headers = {
      'apikey':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNoeWF6YXJra3dpaW9hd2h4aWx1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzEwMjYyMDIsImV4cCI6MTk4NjYwMjIwMn0.GafapDJw7OVoOdN3osBigeYBp3RzQnocYX8UCxDyH1k',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNoeWF6YXJra3dpaW9hd2h4aWx1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzEwMjYyMDIsImV4cCI6MTk4NjYwMjIwMn0.GafapDJw7OVoOdN3osBigeYBp3RzQnocYX8UCxDyH1k',
      'Content-Type': 'application/json',
      'Prefer': 'return=minimal',
    };
    final url = Uri.parse('$baseURL/rest/v1/event');
    await http.post(url, body: event.toJson(), headers: headers);

    events.add(event);
    notifyListeners();
  }
}
