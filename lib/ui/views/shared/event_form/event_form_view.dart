import 'package:at_events/models/category_model.dart';
import 'package:at_events/models/event_model.dart';
import 'package:at_events/providers/storage_provider.dart';
import 'package:at_events/services/category_service.dart';
import 'package:at_events/ui/views/shared/event_form/widgets/buttons_widget.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';

import 'package:at_events/ui/theme/colors.dart';
import 'package:at_events/ui/styles/inputdecoration_style.dart';
import 'package:at_events/ui/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';

class EventFormView extends StatefulWidget {
  final Event? event;

  const EventFormView({super.key, this.event});

  @override
  State<EventFormView> createState() => _EventFormViewState();
}

class _EventFormViewState extends State<EventFormView> {
  String? selectedCategory;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  bool submit = false;

  @override
  void initState() {
    super.initState();
    //Conditional used when we want to update an event
    if (widget.event != null) {
      final event = widget.event!.toMap();
      nameController.text = event['name'];
      dateController.text = event['date'];
      placeController.text = event['place'];
      descriptionController.text = event['description'];
      priceController.text = event['price'].toString();
    }

    nameController.addListener(() => setState(() {}));
    dateController.addListener(() => setState(() {}));
    placeController.addListener(() => setState(() {}));
    descriptionController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    dateController.dispose();
    placeController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('building EventFormView');
    final List<DropdownMenuItem<String>> menuItems = [];
    final storageImage = context.watch<StorageImageProvider>();
    final categoryService = context.watch<CategoryService>();
    final categories = categoryService.categories;
    print('list of  categories: $categories');

    //Conditional used when we want to update an event
    if (widget.event != null && selectedCategory == null) {
      for (Category category in categories) {
        if (category.id == widget.event!.categoryId) {
          selectedCategory = category.name;
          break;
        }
      }
      storageImage.imageBytes = widget.event!.uint8Image;
      storageImage.imageName = widget.event!.imageName;
    }

    for (Category category in categories) {
      menuItems.add(
          DropdownMenuItem(value: category.name, child: Text(category.name!)));
    }

    if (nameController.text != '' &&
        dateController.text != '' &&
        placeController.text != '' &&
        descriptionController.text != '' &&
        selectedCategory != null &&
        storageImage.imageBytes != null) {
      submit = true;
    } else {
      submit = false;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            final FocusScopeNode focus = FocusScope.of(context);
            if (!focus.hasPrimaryFocus && focus.hasFocus) {
              FocusManager.instance.primaryFocus!.unfocus();
            }
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      color: MyColor.lightSecondary,
                      height: 180,
                      child: (storageImage.imageBytes != null)
                          ? SizedBox(
                              width: double.infinity,
                              child: Image.memory(
                                storageImage.imageBytes!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : null,
                    ),
                    Positioned(
                      top: 120,
                      right: 10,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.image),
                        label: const Text('Agregar imagen'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColor.secondary,
                          fixedSize: const Size(180, 35),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        onPressed: () => _showModalBottomSheet(context),
                      ),
                    ),
                  ],
                ),
                Form(
                  key: formkey,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        TextFieldWidget(
                          controller: nameController,
                          keyboardType: TextInputType.text,
                          hintText: 'Nombre del evento',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DateTimePicker(
                          controller: dateController,
                          type: DateTimePickerType.dateTime,
                          dateMask: 'd MMM, yyyy hh:mm a',
                          // initialValue: DateTime.now().toString(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          dateLabelText: 'Fecha y hora',
                          decoration: myInputDecoration(
                            hintText: 'Fecha y hora del evento',
                            suffixIcon: const Icon(Icons.event),
                          ),
                          // onChanged: (val) => print(val),
                          onSaved: (val) => print(val),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFieldWidget(
                          controller: placeController,
                          keyboardType: TextInputType.streetAddress,
                          hintText: 'Lugar del evento',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownButtonFormField(
                          decoration: myInputDecoration(hintText: 'Categoria'),
                          hint: const Text('Categoria'),
                          items: menuItems,
                          value: selectedCategory,
                          onChanged: (value) {
                            setState(() {
                              selectedCategory = value!;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFieldWidget(
                          controller: descriptionController,
                          keyboardType: TextInputType.multiline,
                          hintText: 'Detalles del evento',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFieldWidget(
                          controller: priceController,
                          keyboardType: TextInputType.number,
                          hintText: 'Precio del evento',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: (widget.event == null)
                              ? CreateButton(
                                  submit: submit,
                                  selectedCategory: selectedCategory,
                                  nameController: nameController,
                                  dateController: dateController,
                                  placeController: placeController,
                                  descriptionController: descriptionController,
                                  priceController: priceController,
                                )
                              : UpdateButton(
                                  event: widget.event!,
                                  submit: submit,
                                  selectedCategory: selectedCategory,
                                  nameController: nameController,
                                  dateController: dateController,
                                  placeController: placeController,
                                  descriptionController: descriptionController,
                                  priceController: priceController,
                                ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _showModalBottomSheet(BuildContext context) {
  final storage = context.read<StorageImageProvider>();

  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.filter),
            title: const Text('Abrir galeria'),
            onTap: () {
              storage.activeGallery();
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Tomar foto'),
            onTap: () {
              storage.activeCamera();
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
