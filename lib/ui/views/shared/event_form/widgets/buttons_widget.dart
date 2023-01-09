import 'package:at_events/models/category_model.dart';
import 'package:at_events/models/event_model.dart';
import 'package:at_events/providers/storage_provider.dart';
import 'package:at_events/services/auth_service.dart';
import 'package:at_events/services/category_service.dart';
import 'package:at_events/services/event_service.dart';
import 'package:at_events/ui/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateButton extends StatelessWidget {
  const CreateButton({
    Key? key,
    required this.submit,
    required this.selectedCategory,
    required this.nameController,
    required this.dateController,
    required this.placeController,
    required this.descriptionController,
    required this.priceController,
  }) : super(key: key);

  final bool submit;
  final String? selectedCategory;
  final TextEditingController nameController;
  final TextEditingController dateController;
  final TextEditingController placeController;
  final TextEditingController descriptionController;
  final TextEditingController priceController;

  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
      title: 'Crear evento',
      onPressed: submit
          ? () async {
              final eventService = context.read<EventService>();
              final authService = context.read<AuthService>();
              final categoryService = context.read<CategoryService>();
              final categories = categoryService.categories;
              final storageImage = context.read<StorageImageProvider>();
              late int categoryId;

              for (Category category in categories) {
                if (category.name == selectedCategory) {
                  categoryId = category.id!;
                  break;
                }
              }
              final event = Event(
                name: nameController.text,
                date: DateTime.parse(dateController.text),
                place: placeController.text,
                description: descriptionController.text,
                price: priceController.text != ''
                    ? double.parse(priceController.text)
                    : 0,
                imageName: storageImage.imageName,
                categoryId: categoryId,
                userId: authService.user.id!,
              );
              await storageImage.uploadEventImageStorage();
              await eventService.createEvent(event);
              storageImage.cleanImage();
            }
          : null,
    );
  }
}

class UpdateButton extends StatelessWidget {
  const UpdateButton({
    Key? key,
    required this.event,
    required this.submit,
    required this.selectedCategory,
    required this.nameController,
    required this.dateController,
    required this.placeController,
    required this.descriptionController,
    required this.priceController,
  }) : super(key: key);

  final Event event;
  final bool submit;
  final String? selectedCategory;
  final TextEditingController nameController;
  final TextEditingController dateController;
  final TextEditingController placeController;
  final TextEditingController descriptionController;
  final TextEditingController priceController;

  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
      title: 'Actualizar evento',
      onPressed: submit
          ? () async {
              final eventService = context.read<EventService>();
              final authService = context.read<AuthService>();
              final categoryService = context.read<CategoryService>();
              final categories = categoryService.categories;
              final storageImage = context.read<StorageImageProvider>();
              late int categoryId;

              for (Category category in categories) {
                if (category.name == selectedCategory) {
                  categoryId = category.id!;
                  break;
                }
              }
              final updatedEvent = Event(
                id: event.id,
                createdAt: event.createdAt,
                name: nameController.text,
                date: DateTime.parse(dateController.text),
                place: placeController.text,
                description: descriptionController.text,
                price: priceController.text != ''
                    ? double.parse(priceController.text)
                    : 0,
                imageName: storageImage.imageName,
                attendance: event.attendance,
                interested: event.interested,
                categoryId: categoryId,
                userId: authService.user.id!,
                uint8Image: storageImage.imageBytes,
              );
              if (storageImage.image != null) {
                await storageImage.uploadEventImageStorage();
              }
              await eventService.updateEvent(updatedEvent);
              storageImage.cleanImage();
            }
          : null,
    );
  }
}
