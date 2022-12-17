import 'package:flutter/material.dart';

class CardEventCalendar extends StatelessWidget {
  final String? imageEvent;
  final String? titleEvent;
  final String? hoursEvent;

  const CardEventCalendar(
      {Key? key, this.imageEvent, this.titleEvent, this.hoursEvent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      child: Card(
          shape: RoundedRectangleBorder(
            // borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: Colors.black,
            ),
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(
                          20) //                 <--- border radius here
                      ),
                ),
                height: 160.0,
                child: Ink.image(
                  image: NetworkImage('$imageEvent'),
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Text('$titleEvent',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17))
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [Text('Hora: $hoursEvent')],
                        ),
                      )
                    ],
                  )),
            ],
          )),
    );
  }
}