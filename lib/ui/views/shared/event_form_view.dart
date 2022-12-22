import 'package:at_events/ui/widgets/button_widget.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';

import 'package:at_events/ui/theme/colors.dart';
import 'package:at_events/ui/styles/inputdecoration_style.dart';
import 'package:at_events/ui/widgets/textfield_widget.dart';

//Change name of view
class EventFormView extends StatefulWidget {
  const EventFormView({super.key});

  @override
  State<EventFormView> createState() => _EventFormViewState();
}

class _EventFormViewState extends State<EventFormView> {
  final List<DropdownMenuItem<String>> menuItems = const [
    DropdownMenuItem(value: "Concierto", child: Text("Concierto")),
    DropdownMenuItem(value: "Teatro", child: Text("Teatro")),
    DropdownMenuItem(value: "Comida", child: Text("Comida")),
    DropdownMenuItem(value: "Ponencia", child: Text("Ponencia")),
  ];

  String? selectedItem;

  @override
  Widget build(BuildContext context) {
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
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 200,
                  child: CalendarTimeline(
                    showYears: false,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365 * 4)),
                    onDateSelected: (date) {},
                    leftMargin: 15,
                    monthColor: Colors.black,
                    dayColor: Colors.black,
                    dayNameColor: Colors.white,
                    activeDayColor: Colors.white,
                    activeBackgroundDayColor: MyColor.primary,
                    dotsColor: const Color(0xFF333A47),
                    locale: 'es',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const TextFieldWidget(
                        keyboardType: TextInputType.text,
                        hintText: 'Nombre del evento',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DateTimePicker(
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
                        onChanged: (val) => print(val),
                        validator: (val) {
                          print(val);
                          return null;
                        },
                        onSaved: (val) => print(val),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const TextFieldWidget(
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
                        value: selectedItem,
                        onChanged: (value) {
                          setState(() {
                            selectedItem = value!;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const TextFieldWidget(
                        keyboardType: TextInputType.multiline,
                        hintText: 'Detalles del evento',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ButtonWidget(
                          title: 'Crear evento',
                          function: () {},
                        ),
                      )
                    ],
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
