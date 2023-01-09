import 'package:at_events/models/event_model.dart';
import 'package:at_events/routes/route.dart';
import 'package:at_events/services/auth_service.dart';
import 'package:at_events/services/event_service.dart';
import 'package:at_events/ui/theme/colors.dart';
import 'package:at_events/ui/views/calendar/details_event.dart';
import 'package:at_events/ui/views/calendar/widgets/card_event_widget.dart.dart';
import 'package:at_events/ui/widgets/floating_button_widget.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timeline_calendar/timeline/model/calendar_options.dart';
import 'package:flutter_timeline_calendar/timeline/model/datetime.dart';
import 'package:flutter_timeline_calendar/timeline/model/day_options.dart';
import 'package:flutter_timeline_calendar/timeline/model/headers_options.dart';
import 'package:flutter_timeline_calendar/timeline/utils/calendar_types.dart';
import 'package:flutter_timeline_calendar/timeline/widget/timeline_calendar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventCalendarView extends StatefulWidget {
  const EventCalendarView({super.key});

  @override
  _EventCalendarView createState() => _EventCalendarView();
}

class _EventCalendarView extends State<EventCalendarView> {
  @override
  Widget build(BuildContext context) {
    final eventService = context.watch<EventService>();
    final authService = context.read<AuthService>();
    final myEvents = eventService.getMyEvents(authService.user.id!);

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Eventos',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        actions: [
          FloatingButtonWidget(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      // floatingActionButton: SizedBox(
      //   height: 150,
      //   width: 45,
      //   child: FloatingActionButton(
      //     backgroundColor: MyColor.primary,
      //     onPressed: () => setState(() => _resetSelectedDate()),
      //     child: const Text('Hoy'),
      //   ),
      // ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                //Eventos del dia
                const SelectedDayEvents(),
                //Evento que asistire y me interesan
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
                  child: Column(children: [
                    Container(
                      child: Row(
                        children: const [
                          Text(
                            'Eventos marcados',
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
                    MarkedEvents(),
                  ]),
                ),
                //
                //Mis eventos
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
                    SizedBox(
                      height: 240,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: myEvents.length,
                        itemBuilder: (context, index) {
                          final event = myEvents[index];
                          return CardEventCalendar(
                            event: event,
                            onTap: () {
                              eventService.selectedEvent = event;
                              Navigator.pushNamed(context, MyRoutes.rEVENT,
                                  arguments: true);
                            },
                          );
                        },
                      ),
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
      ),
    );
  }
}

class MarkedEvents extends StatelessWidget {
  const MarkedEvents({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final eventService = context.watch<EventService>();
    final List<Event> myAttendances = eventService.eventsAttendancesOfUser;
    final List<Event> myInterests = eventService.eventsInterestsOfUser;
    final List<Event> myMarkedEvents = [...myAttendances, ...myInterests];

    myMarkedEvents.sort(((a, b) => a.date!.compareTo(b.date!)));
    print('My marked events: ${myMarkedEvents.toString()}');

    return (myMarkedEvents.isNotEmpty)
        ? SizedBox(
            height: 240,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: myMarkedEvents.length,
              itemBuilder: (context, index) {
                final event = myMarkedEvents[index];
                return CardEventCalendar(
                  event: event,
                  onTap: () {
                    eventService.selectedEvent = event;
                    Navigator.pushNamed(context, MyRoutes.rEVENT);
                  },
                );
              },
            ),
          )
        : const Text('No hay eventos');
  }
}

class SelectedDayEvents extends StatefulWidget {
  const SelectedDayEvents({super.key});

  @override
  State<SelectedDayEvents> createState() => _SelectedDayEventsState();
}

class _SelectedDayEventsState extends State<SelectedDayEvents> {
  // late DateTime _selectedDate;
  late CalendarDateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
  }

  void _resetSelectedDate() {
    // _selectedDate = DateTime.now().add(Duration(days: 0));
    final String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    print('date in string: $date');
    _selectedDate = CalendarDateTime.parseDate(date);
    print(_selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    final eventService = context.read<EventService>();
    final eventsByDate =
        eventService.showEventsByDay(_selectedDate!.toDateTime());
    eventsByDate.sort(((a, b) => a.date!.compareTo(b.date!)));
    print('eventsByDate: ${eventsByDate.toString()}');

    return Column(
      children: [
        // CalendarTimeline(
        //   showYears: false,
        //   initialDate: _selectedDate,
        //   firstDate: DateTime.now(),
        //   lastDate: DateTime.now().add(const Duration(days: 365 * 4)),
        //   onDateSelected: (date) => setState(
        //     () => _selectedDate = date,
        //   ),
        //   leftMargin: 15,
        //   monthColor: Colors.black,
        //   dayColor: Colors.black,
        //   dayNameColor: Colors.white,
        //   activeDayColor: Colors.white,
        //   activeBackgroundDayColor: MyColor.primary,
        //   dotsColor: const Color(0xFF333A47),
        //   locale: 'es',
        // ),
        // DatePicker(
        //   DateTime.now(),
        //   width: 60,
        //   height: 80,
        //   initialSelectedDate: _selectedDate,
        //   selectionColor: MyColor.primary,
        //   selectedTextColor: Colors.white,
        //   onDateChange: (date) {
        //     setState(() {
        //       _selectedDate = date;
        //     });
        //   },
        //   locale: 'es',
        // ),
        TimelineCalendar(
          dateTime: _selectedDate,
          calendarType: CalendarType.GREGORIAN,
          calendarLanguage: "en",
          calendarOptions: CalendarOptions(
            viewType: ViewType.DAILY,
            toggleViewType: true,
            headerMonthElevation: 10,
            headerMonthShadowColor: Colors.black26,
            headerMonthBackColor: Colors.transparent,
          ),
          dayOptions: DayOptions(
            compactMode: true,
            weekDaySelectedColor: MyColor.primary,
            selectedBackgroundColor: MyColor.primary,
          ),
          headerOptions: HeaderOptions(
              weekDayStringType: WeekDayStringTypes.SHORT,
              monthStringType: MonthStringTypes.FULL,
              backgroundColor: MyColor.primary,
              headerTextColor: Colors.black),
          onChangeDateTime: (datetime) {
            // print(datetime);
            setState(() {
              _selectedDate = datetime;
            });
          },
          onDateTimeReset: (datetime) {
            _resetSelectedDate();
            setState(() {});
          },
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
          child: Column(
            children: [
              Container(
                child: Row(
                  children: const [
                    Text(
                      'Eventos del dia',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 2,
                color: Colors.black,
              ),
              //tarjeta de eventos
              (eventsByDate.isNotEmpty)
                  ? SizedBox(
                      height: 240,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: eventsByDate.length,
                        itemBuilder: (context, index) {
                          final event = eventsByDate[index];
                          return CardEventCalendar(
                            event: event,
                            onTap: () {
                              eventService.selectedEvent = event;
                              Navigator.pushNamed(context, MyRoutes.rEVENT);
                            },
                          );
                        },
                      ),
                    )
                  : const Text('No hay eventos'),
            ],
          ),
        ),
      ],
    );
  }
}
