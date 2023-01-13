import 'dart:convert';

import 'package:at_events/providers/storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:at_events/models/event_model.dart';
import 'package:intl/intl.dart';

class EventService extends ChangeNotifier {
  final String baseURL = 'https://chyazarkkwiioawhxilu.supabase.co';
  final String _apikey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNoeWF6YXJra3dpaW9hd2h4aWx1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzEwMjYyMDIsImV4cCI6MTk4NjYwMjIwMn0.GafapDJw7OVoOdN3osBigeYBp3RzQnocYX8UCxDyH1k';
  // Map<String, String> headers = {
  //   'apikey': _apikey,
  //   'Authorization': 'Bearer $_apikey',
  //   'Content-Type': 'application/json',
  //   'Prefer': 'return=minimal',
  // };
  late StorageImageProvider _storageImage;
  // late EventsCatalog _eventsCatalog;
  // late List<dynamic> events;
  final List<Event> events = [];
  final List<Event> eventsByCategory = [];
  final List<Event> eventsAttendancesOfUser = [];
  final List<Event> eventsInterestsOfUser = [];
  Event? selectedEvent;

  EventService() {
    // getEvents();
  }

  StorageImageProvider get storageImage => _storageImage;

  set storageImage(newStorage) {
    _storageImage = newStorage;
    notifyListeners();
  }

  Future<List<Event>> getEvents() async {
    final Map<String, String> headers = {
      'apikey': _apikey,
      'Authorization': 'Bearer $_apikey',
    };
    final url = Uri.parse('$baseURL/rest/v1/events?select=*');
    final response = await http.get(url, headers: headers);
    final List<dynamic> eventsList = json.decode(response.body);

    events.clear();
    for (final item in eventsList) {
      final event = Event.fromMap(item);
      final uint8Image =
          await _storageImage.downloadImageStorage(event.imageName);
      event.uint8Image = uint8Image;
      events.add(event);
    }

    print('events obtained from API');
    // notifyListeners();
    return events;
  }

  List<Event> showEventsByDay(DateTime day) {
    List<Event> eventsByDate = [];
    final stringDay = DateFormat('dd/MM/yyyy').format(day);

    for (Event event in events) {
      final stringDate = DateFormat('dd/MM/yyyy').format(event.date!);
      if (stringDate == stringDay) {
        eventsByDate.add(event);
      }
    }
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
      'apikey': _apikey,
      'Authorization': 'Bearer $_apikey',
    };
    final url = Uri.parse(
        '$baseURL/rest/v1/categories?id=eq.$categoryId&select=events(*)');
    final response = await http.get(url, headers: headers);
    print(
        'response of GET /rest/v1/categories?id=eq.$categoryId&select=events(*): ${response.body}');
    final List<dynamic> eventsList = json.decode(response.body)[0]['events'];

    eventsByCategory.clear();
    for (final item in eventsList) {
      final event = Event.fromMap(item);
      final uint8Image =
          await _storageImage.downloadImageStorage(event.imageName);
      event.uint8Image = uint8Image;
      eventsByCategory.add(event);
    }
    print('events by category obtained from API');
    notifyListeners();
    return eventsByCategory;
  }

  List<Event> getMyEvents(String userId) {
    final myEvents = events.where((event) => event.userId == userId).toList();
    return myEvents;
  }

  Future getEventsAttendancesOfUser(String userId) async {
    final eventAttendacesList = await getEventAttendances();

    eventsAttendancesOfUser.clear();
    eventAttendacesList.forEach((element) {
      if (element['user_id'] == userId) {
        final matchedEvent =
            events.firstWhere((event) => event.id == element['event_id']);
        eventsAttendancesOfUser.add(matchedEvent);
      }
    });
    print('eventAttendacesOfUser: $eventsAttendancesOfUser');
    // notifyListeners();
  }

  Future getEventsInterestsOfUser(String userId) async {
    final eventsInterestsList = await getEventInterests();

    eventsInterestsOfUser.clear();
    eventsInterestsList.forEach((element) {
      if (element['user_id'] == userId) {
        final matchedEvent =
            events.firstWhere((event) => event.id == element['event_id']);
        eventsInterestsOfUser.add(matchedEvent);
      }
    });
    print('eventInterestsOfUser: $eventsInterestsOfUser');
    // notifyListeners();
  }

  Future createEvent(Event event) async {
    final Map<String, String> headers = {
      'apikey': _apikey,
      'Authorization': 'Bearer $_apikey',
      'Content-Type': 'application/json',
      'Prefer': 'return=minimal',
    };
    final Map<String, dynamic> data = {
      "name": event.name!,
      "date": event.date!.toIso8601String(),
      "place": event.place,
      "description": event.description,
      "price": event.price!,
      "category_id": event.categoryId!,
      "user_id": event.userId,
      "imageName": event.imageName,
    };
    print('data of event to create: $data');
    final url = Uri.parse('$baseURL/rest/v1/events');
    final response =
        await http.post(url, headers: headers, body: json.encode(data));
    print('status code of POST in /rest/v1/events: ${response.statusCode}');

    // events.add(event);
    notifyListeners();
  }

  Future updateEvent(Event event) async {
    final Map<String, String> headers = {
      'apikey': _apikey,
      'Authorization': 'Bearer $_apikey',
      'Content-Type': 'application/json',
      'Prefer': 'return=minimal',
    };
    final Map<String, dynamic> data = {
      "name": event.name!,
      "date": event.date!.toIso8601String(),
      "place": event.place,
      "description": event.description,
      "price": event.price!,
      "category_id": event.categoryId!,
      "user_id": event.userId,
      "imageName": event.imageName,
    };
    print('data of event to update: $data');
    final url = Uri.parse('$baseURL/rest/v1/events?id=eq.${event.id}');
    final response =
        await http.patch(url, headers: headers, body: json.encode(data));
    print(
        'status code of PATCH in /rest/v1/events?id=eq.${event.id}: ${response.statusCode}');

    final eventIndex = events.indexWhere((element) => element.id == event.id);
    events[eventIndex] = event;
    selectedEvent = event;

    //
    final attendancesIndex =
        eventsAttendancesOfUser.indexWhere((element) => element.id == event.id);
    if (attendancesIndex != -1) {
      eventsAttendancesOfUser[attendancesIndex] = event;
    }

    //
    final interestsIndex =
        eventsInterestsOfUser.indexWhere((element) => element.id == event.id);
    if (interestsIndex != -1) {
      eventsInterestsOfUser[interestsIndex] = event;
    }

    notifyListeners();
  }

  /*-----------------EVENT_ATTENDANCES---------------*/
  Future<List<dynamic>> getEventAttendances() async {
    final Map<String, String> headers = {
      'apikey': _apikey,
      'Authorization': 'Bearer $_apikey',
    };
    final url = Uri.parse('$baseURL/rest/v1/event_attendances?select=*');
    final response = await http.get(url, headers: headers);
    final List<dynamic> eventAttendacesList = json.decode(response.body);
    print('List of attendances at the events obtained');
    return eventAttendacesList;
  }

  Future verifyAttendance(int eventId, String userId) async {
    final Map<String, String> headers = {
      'apikey': _apikey,
      'Authorization': 'Bearer $_apikey',
      'Content-Type': 'application/json',
      'Prefer': 'return=minimal',
    };

    final bool isAssistant =
        eventsAttendancesOfUser.any((element) => element.id == eventId);
    final bool isInterested =
        eventsInterestsOfUser.any((element) => element.id == eventId);

    if (isAssistant) {
      //Delete row in event_attendances table
      await deleteEventAttendance(headers, eventId, userId);
    } else {
      //Insert row in event_attendances table
      await createEventAttendance(headers, eventId, userId);
    }

    if (isInterested) {
      deleteEventInterest(headers, eventId, userId);
      final int interestsNb = await amountEventInterests(eventId);
      await updateEventInterest(headers, interestsNb, eventId);
    }

    final int attendancesNb = await amountEventAttendances(eventId);
    await updateEventAttendance(headers, attendancesNb, eventId);

    notifyListeners();
  }

  Future<int> amountEventAttendances(int eventId) async {
    final eventAttendances = await getEventAttendances();
    final attendancesNb = eventAttendances.fold(0, (sum, element) {
      if (element['event_id'] == eventId) sum++;
      return sum;
    });
    print('attendacesNb: $attendancesNb');
    return attendancesNb;
  }

  Future updateEventAttendance(
      Map<String, String> headers, int attendancesNb, int eventId) async {
    //Update row in events table in the attendance column
    final Map<String, dynamic> data = {'attendance': attendancesNb};
    final url2 = Uri.parse('$baseURL/rest/v1/events?id=eq.$eventId');
    final response2 =
        await http.patch(url2, headers: headers, body: json.encode(data));
    print(
        'status code of PATCH in /rest/v1/events?id=eq.$eventId: ${response2.statusCode}');

    final event = events.firstWhere((event) => event.id == eventId);
    event.attendance = attendancesNb;
  }

  Future createEventAttendance(
      Map<String, String> headers, int eventId, String userId) async {
    final Map<String, dynamic> data = {'event_id': eventId, 'user_id': userId};
    final url = Uri.parse('$baseURL/rest/v1/event_attendances');
    final response =
        await http.post(url, headers: headers, body: json.encode(data));
    print(
        'status code of POST in /rest/v1/event_attendances: ${response.statusCode}');

    //Add a new event attendance to eventsAttendancesOfUser list
    final Event newEventAttendance =
        events.firstWhere((event) => event.id == eventId);
    eventsAttendancesOfUser.add(newEventAttendance);
  }

  Future deleteEventAttendance(
      Map<String, String> headers, int eventId, String userId) async {
    final url = Uri.parse(
        '$baseURL/rest/v1/event_attendances?event_id=eq.$eventId&user_id=eq.$userId');
    final response = await http.delete(url, headers: headers);
    print(
        'status code of DELETE in /rest/v1/event_attendances?event_id=eq.$eventId&user_id=$userId: ${response.statusCode}');

    //Delete a event attendance to eventsAttendancesOfUser list
    final Event eventAttendance =
        events.firstWhere((event) => event.id == eventId);
    eventsAttendancesOfUser.remove(eventAttendance);
  }

  /*-----------------EVENT_STAKEHOLDERS---------------*/
  Future<List<dynamic>> getEventInterests() async {
    final Map<String, String> headers = {
      'apikey': _apikey,
      'Authorization': 'Bearer $_apikey',
    };
    final url = Uri.parse('$baseURL/rest/v1/event_stakeholders?select=*');
    final response = await http.get(url, headers: headers);
    final List<dynamic> eventInterestsList = json.decode(response.body);
    print('List of interests at the events obtained');
    return eventInterestsList;
  }

  Future verifyInterest(int eventId, String userId) async {
    final Map<String, String> headers = {
      'apikey': _apikey,
      'Authorization': 'Bearer $_apikey',
      'Content-Type': 'application/json',
      'Prefer': 'return=minimal',
    };

    final bool isInterested =
        eventsInterestsOfUser.any((element) => element.id == eventId);
    final bool isAssistant =
        eventsAttendancesOfUser.any((element) => element.id == eventId);

    if (isInterested) {
      //Delete row in event_stakeholders table
      await deleteEventInterest(headers, eventId, userId);
    } else {
      //Insert row in event_stakeholders table
      await createEventInterest(headers, eventId, userId);
    }

    if (isAssistant) {
      await deleteEventAttendance(headers, eventId, userId);
      final int attendancesNb = await amountEventAttendances(eventId);
      await updateEventAttendance(headers, attendancesNb, eventId);
    }

    final int interestsNb = await amountEventInterests(eventId);
    await updateEventInterest(headers, interestsNb, eventId);

    notifyListeners();
  }

  Future<int> amountEventInterests(int eventId) async {
    final eventInterests = await getEventInterests();
    final interestsNb = eventInterests.fold(0, (sum, element) {
      if (element['event_id'] == eventId) sum++;
      return sum;
    });
    print('interestsNb: $interestsNb');
    return interestsNb;
  }

  Future updateEventInterest(
      Map<String, String> headers, int interestsNb, int eventId) async {
    //Update row in events table in the interested column
    final Map<String, dynamic> data = {'interested': interestsNb};
    final url2 = Uri.parse('$baseURL/rest/v1/events?id=eq.$eventId');
    final response2 =
        await http.patch(url2, headers: headers, body: json.encode(data));
    print(
        'status code of PATCH in /rest/v1/events?id=eq.$eventId: ${response2.statusCode}');

    final event = events.firstWhere((event) => event.id == eventId);
    event.interested = interestsNb;
  }

  Future createEventInterest(
      Map<String, String> headers, int eventId, String userId) async {
    final Map<String, dynamic> data = {'event_id': eventId, 'user_id': userId};
    final url = Uri.parse('$baseURL/rest/v1/event_stakeholders');
    final response =
        await http.post(url, headers: headers, body: json.encode(data));
    print(
        'status code of POST in /rest/v1/event_stakeholders: ${response.statusCode}');

    //Add a new event interest to eventsInterestsOfUser list
    final Event newEventInterest =
        events.firstWhere((event) => event.id == eventId);
    eventsInterestsOfUser.add(newEventInterest);
  }

  Future deleteEventInterest(
      Map<String, String> headers, int eventId, String userId) async {
    final url = Uri.parse(
        '$baseURL/rest/v1/event_stakeholders?event_id=eq.$eventId&user_id=eq.$userId');
    final response = await http.delete(url, headers: headers);
    print(
        'status code of DELETE in /rest/v1/event_stakeholders?event_id=eq.$eventId&user_id=$userId: ${response.statusCode}');

    //Delete a event interest to eventsInterestsOfUser list
    final Event eventInterest =
        events.firstWhere((event) => event.id == eventId);
    eventsInterestsOfUser.remove(eventInterest);
  }
}
