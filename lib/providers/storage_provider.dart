import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageImageProvider extends ChangeNotifier {
  File? image;
  String? imageName;
  Uint8List? imageBytes;

  final SupabaseClient client = SupabaseClient(
    'https://chyazarkkwiioawhxilu.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNoeWF6YXJra3dpaW9hd2h4aWx1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzEwMjYyMDIsImV4cCI6MTk4NjYwMjIwMn0.GafapDJw7OVoOdN3osBigeYBp3RzQnocYX8UCxDyH1k',
  );

  Future uploadEventImageStorage() async {
    final response =
        await client.storage.from('events').upload('IMG/$imageName', image!);
    print(response);
  }

  Future uploadUserImageStorage() async {
    final response =
        await client.storage.from('users').upload('IMG/$imageName', image!);
    print(response);
  }

  Future downloadImageStorage(imageName) async {
    final response =
        await client.storage.from('events').download('IMG/$imageName');
    // return File.fromRawPath(response);
    // return File(imageName).writeAsBytes(response);
    return response;
  }

  Future activeCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;

    this.image = File(image.path);
    imageBytes = this.image!.readAsBytesSync();
    imageName = image.name;

    notifyListeners();
  }

  Future activeGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    this.image = File(image.path);
    imageBytes = this.image!.readAsBytesSync();
    imageName = image.name;

    notifyListeners();
  }

  Future cleanImage() async {
    image = null;
    imageName = null;
    imageBytes = null;
    notifyListeners();
  }
}
