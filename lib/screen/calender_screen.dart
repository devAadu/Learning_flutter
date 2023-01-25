import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ClanderScreen extends StatefulWidget {
  const ClanderScreen({Key? key}) : super(key: key);

  @override
  State<ClanderScreen> createState() => _ClanderScreenState();
}

class _ClanderScreenState extends State<ClanderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCalendar(
        view: CalendarView.day,
        allowAppointmentResize: true,
        dataSource: _getDataSource(),
        appointmentBuilder: appointmentBuilder,
        showCurrentTimeIndicator: false,
        timeSlotViewSettings: const TimeSlotViewSettings(
            timeIntervalHeight: 100,

        ),
      ),
    );
  }

  Widget appointmentBuilder(BuildContext context,
      CalendarAppointmentDetails calendarAppointmentDetails) {
    final Appointment appointment = calendarAppointmentDetails.appointments.first;
    return Column(
      children: [


        Container(
            width: calendarAppointmentDetails.bounds.width,
            color: appointment.color,
            child: Container(
              margin: const EdgeInsets.only(right: 15, left: 6),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xff33BB47).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //event name and time
                  Row(
                    children: const [
                      Expanded(
                        child: Text("fuck",style: TextStyle(
                          color: Colors.white
                        ),),
                      ),
                      Text(
                        // formatDateTime(time: (model.from ?? 0) * 1000, type: FormatDateTimeType.TIMEONLY),
                          "10:00",),
                    ],
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  //event location
                  Row(
                    children: [
                      Image.asset(
                        "icons/ic_location_pin.png",
                        height: 12,
                        width: 12,
                        color: const Color(0xff266C30),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 3),
                        child: Text(
                            "2664 Royal Ln, Mesa Square, New Jersey.",
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),

                  //event organizer name
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xff679E6F).withOpacity(0.11),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipOval(
                          child: Image.asset(
                            // "images/bg_user_tmp2.png",
                            "packages/flutter_paypal/lib/src/assets/img/cloud_state.png",
                            height: 20,
                            width: 20,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3),
                          child: Text("Aadesh",),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),

      ],
    );
  }

  _DataSource _getDataSource() {
    final List<Appointment> appointments = <Appointment>[];
    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(hours: 4,minutes: 30)),
      endTime: DateTime.now().add(const Duration(hours: 5,minutes: 35)),
      subject: 'Meeting',
      color: Colors.green,
    )
    );

    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(hours: 7)),
      endTime: DateTime.now().add(const Duration(hours: 8)),
      subject: 'Meeting',
      color: Colors.blue,
    )
    );

    return _DataSource(appointments);
  }

  Widget monthCellBuilder(BuildContext context, MonthCellDetails details) {
    var mid = details.visibleDates.length ~/ 2.toInt();
    var midDate = details.visibleDates[0].add(Duration(days: mid));

    if (details.date.month != midDate.month) {
      return Container(
        color: Colors.pinkAccent,
        child: Text(
          details.date.day.toString(),
        ),
      );
    } else {
      return Container(
        color: Colors.green,
        child: Text(
          details.date.day.toString(),
        ),
      );
    }
  }

}


class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}
