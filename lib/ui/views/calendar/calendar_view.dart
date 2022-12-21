import 'package:at_events/ui/theme/colors.dart';
import 'package:at_events/ui/views/calendar/datails_event.dart';
import 'package:at_events/ui/views/calendar/widgets/card_event_widget.dart.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';

class EventCalendarView extends StatefulWidget {
  @override
  _EventCalendarView createState() => _EventCalendarView();
}

class _EventCalendarView extends State<EventCalendarView> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now().add(Duration(days: 0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          title: const Text(
            'Eventos',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
            )
          ],
        ),
        floatingActionButton: SizedBox(
          height: 150,
          width: 45,
          child: FloatingActionButton(
            backgroundColor: MyColor.primary,
            onPressed: () => setState(() => _resetSelectedDate()),
            child: const Text('Hoy'),
          ),
        ),
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    child: CalendarTimeline(
                      showYears: false,
                      initialDate: _selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 365 * 4)),
                      onDateSelected: (date) => setState(
                        () => _selectedDate = date,
                      ),
                      leftMargin: 15,
                      monthColor: Colors.black,
                      dayColor: Colors.black,
                      dayNameColor: Colors.white,
                      activeDayColor: Colors.white,
                      activeBackgroundDayColor: MyColor.primary,
                      dotsColor: Color(0xFF333A47),
                      selectableDayPredicate: (date) => date.day != 23,
                      locale: 'es',
                    ),
                  ),

                  /* CalendarTimeline(
                    showYears: false,
                    initialDate: _selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365 * 4)),
                    onDateSelected: (date) => setState(
                      () => _selectedDate = date,
                    ),
                    leftMargin: 15,
                    monthColor: Colors.black,
                    dayColor: Colors.black,
                    dayNameColor: Colors.white,
                    activeDayColor: Colors.white,
                    activeBackgroundDayColor: MyColor.primary,
                    dotsColor: Color(0xFF333A47),
                    selectableDayPredicate: (date) => date.day != 23,
                    locale: 'es',
                  ),*/
                  /////
                  /*  Container(
                    height: 120,
                    child: //calendario
                        CalendarTimeline(
                      showYears: false,
                      initialDate: _selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 365 * 4)),
                      onDateSelected: (date) => setState(
                        () => _selectedDate = date,
                      ),
                      leftMargin: 15,
                      monthColor: Colors.black,
                      dayColor: Colors.black,
                      dayNameColor: Colors.white,
                      activeDayColor: Colors.white,
                      activeBackgroundDayColor: MyColor.primary,
                      dotsColor: Color(0xFF333A47),
                      selectableDayPredicate: (date) => date.day != 23,
                      locale: 'es',
                    ),
                  ),*/

                  //Eventos del dia
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
                    child: Column(children: [
                      Container(
                        child: Row(
                          children: const [
                            Text(
                              'Eventos del dia',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 2,
                        color: Colors.black,
                      ),
                      //tarjeta de eventos
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DetailsEvent()),
                          );
                        },
                        child: SizedBox(
                            height: 230,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: const [
                                CardEventCalendar(
                                  imageEvent:
                                      'https://cdn.pixabay.com/photo/2022/10/17/15/02/photography-7527978_960_720.jpg',
                                  titleEvent: 'FOTOS AL AIRE LIBRE',
                                  hoursEvent: '3.30pm',
                                ),
                                CardEventCalendar(
                                  imageEvent:
                                      'https://cdn.pixabay.com/photo/2022/11/19/09/35/forest-7601671_960_720.jpg',
                                  titleEvent: 'GREEN DAY',
                                  hoursEvent: '8.30pm',
                                )
                              ],
                            )),
                      ),
                    ]),
                  ),
                  //Evento que asistire
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
                    child: Column(children: [
                      Container(
                        child: Row(
                          children: const [
                            Text(
                              'Eventos que asistire',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 2,
                        color: Colors.black,
                      ),
                      //
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DetailsEvent()),
                          );
                        },
                        child: SizedBox(
                            height: 230,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: const [
                                CardEventCalendar(
                                  imageEvent:
                                      'https://cdn.pixabay.com/photo/2018/02/27/09/19/colors-3185020_960_720.jpg',
                                  titleEvent: 'FIESTA DE COLORES',
                                  hoursEvent: '4.00pm',
                                ),
                                CardEventCalendar(
                                  imageEvent:
                                      'https://cdn.pixabay.com/photo/2016/10/22/20/52/balloons-1761634_960_720.jpg',
                                  titleEvent: 'HAPPY',
                                  hoursEvent: '11.30pm',
                                )
                              ],
                            )),
                      ),
                    ]),
                  ),
                  //
                  //Evento que asistire
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
                    child: Column(children: [
                      Container(
                        child: Row(
                          children: const [
                            Text(
                              'Mis eventos',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 2,
                        color: Colors.black,
                      ),
                      //
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DetailsEvent()),
                          );
                        },
                        child: SizedBox(
                            height: 230,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: const [
                                CardEventCalendar(
                                  imageEvent:
                                      'https://cdn.pixabay.com/photo/2016/03/27/16/23/woman-1283009_960_720.jpg',
                                  titleEvent: 'EXPOSICION AL AIRE LIBRE',
                                  hoursEvent: '2.00pm',
                                ),
                              ],
                            )),
                      ),
                    ]),
                  ),
                  //
                ],
              ),
            ),
            //
            const SizedBox(
              height: 80,
            )
          ],
        ));
  }
}
