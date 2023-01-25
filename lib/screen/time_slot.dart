import 'package:flutter/material.dart';

class TimeSlotScreen extends StatefulWidget {
  const TimeSlotScreen({Key? key}) : super(key: key);

  @override
  State<TimeSlotScreen> createState() => _TimeSlotScreenState();
}

class _TimeSlotScreenState extends State<TimeSlotScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context,index){
        return Container(
          child: Row(
            children: [
              //event time list
              Text(
                twelveHourVal("$index:00"),
              ),

            ],
          ),
        );

      })
    );
  }

  //Convert String to 12Hour
  String twelveHourVal(String inputString) {
    var splitTime = inputString.split(":");
    int hour = int.parse(splitTime[0]);
    String suffix = "AM";
    if (hour > 12) {
      hour -= 12;
      suffix = "PM";
    } else if (hour == 0) {
      hour = 12;
      suffix = "AM";
    } else if (hour == 12) {
      hour = 12;
      suffix = "PM";
    }

    String twelveHourVal = '$hour:${splitTime[1]} $suffix';
    return twelveHourVal;
  }

}
