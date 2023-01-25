import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learning_flutter/utils/date_picker_custom.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';


class AlertScreen extends StatefulWidget {
  const AlertScreen({Key? key}) : super(key: key);

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime? _chosenDateTime;

  //Material DatePicker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(

         builder: (context,child){
           return Theme(
             data: Theme.of(context).copyWith(
               colorScheme: const ColorScheme.light(
                 primary: Colors.red, // header background color
                 onPrimary: Colors.white, // header text color
                 onSurface: Colors.black, // body text color
               ),
               textButtonTheme: TextButtonThemeData(
                 style: TextButton.styleFrom(
                   primary: Colors.red, // button text color
                 ),
               ),
             ),
             child: child!,
           );
         },
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectDateCustom(BuildContext context) async {
    final DateTime? picked = await showDatePickerCustom(

        builder: (context,child){
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Colors.red, // header background color
                onPrimary: Colors.white, // header text color
                onSurface: Colors.black, // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: Colors.red, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  _customDatePicker(BuildContext context) async{
    DateTime? newDateTime = await showRoundedDatePicker(
        context: context,
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        styleDatePicker: MaterialRoundedDatePickerStyle(
          textStyleDayButton: const TextStyle(fontSize: 36, color: Colors.white),
          textStyleYearButton: const TextStyle(
            fontSize: 52,
            color: Colors.white,
          ),
          textStyleDayHeader: const TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
          textStyleCurrentDayOnCalendar:
          const TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
          textStyleDayOnCalendar: const TextStyle(fontSize: 28, color: Colors.white),
          textStyleDayOnCalendarSelected:
          const TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
          textStyleDayOnCalendarDisabled: TextStyle(fontSize: 28, color: Colors.white.withOpacity(0.1)),
          textStyleMonthYearHeader:
          const TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
          paddingDatePicker: const EdgeInsets.all(0),
          paddingMonthHeader: const EdgeInsets.all(32),
          paddingActionBar: const EdgeInsets.all(16),
          paddingDateYearHeader: const EdgeInsets.all(32),
          sizeArrow: 50,
          colorArrowNext: Colors.white,
          colorArrowPrevious: Colors.white,
          marginLeftArrowPrevious: 16,
          marginTopArrowPrevious: 16,
          marginTopArrowNext: 16,
          marginRightArrowNext: 32,
          textStyleButtonAction: const TextStyle(fontSize: 28, color: Colors.white),
          textStyleButtonPositive:
          const TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
          textStyleButtonNegative: TextStyle(fontSize: 28, color: Colors.white.withOpacity(0.5)),
          decorationDateSelected: BoxDecoration(color: Colors.orange[600], shape: BoxShape.rectangle,borderRadius: BorderRadius.circular(10)),
          backgroundPicker: Colors.deepPurple[400],
          backgroundActionBar: Colors.deepPurple[300],
          backgroundHeaderMonth: Colors.deepPurple[300],
        ),
        styleYearPicker: MaterialRoundedYearPickerStyle(
          textStyleYear: const TextStyle(fontSize: 40, color: Colors.white),
          textStyleYearSelected:
          const TextStyle(fontSize: 56, color: Colors.white, fontWeight: FontWeight.bold),
          heightYearRow: 100,
          backgroundPicker: Colors.deepPurple[400],
        ));

  }

  //Material timepicker
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }

  //Cupertino DateTime Picker
  void _showDatePicker(ctx) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              height: 500,
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  SizedBox(
                    height: 400,
                    child: CupertinoDatePicker(
                        initialDateTime: DateTime.now(),
                        onDateTimeChanged: (val) {
                          setState(() {
                            _chosenDateTime = val;
                          });
                        }),
                  ),

                  // Close the modal
                  CupertinoButton(
                    child: const Text('OK'),
                    onPressed: () => Navigator.of(ctx).pop(),
                  )
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Hello Master'),
                    content: const Text('You clicked me'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text("AlertDialog")),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                // showCustomDialog(context);
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Country List'),
                        content: setupAlertDialoadContainer(),
                      );
                    });
              },
              child: const Text("Custom Dialog")),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              // _selectDate(context);
              // selectDateRange(context);
              _selectDateCustom(context);
              //
              // _customDatePicker(context);
            },
            child: Text("${selectedDate.toLocal()}".split(' ')[0]),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              _selectTime(context);
            },
            child: Text("${selectedTime.hour}:${selectedTime.minute}"),
          ),
          CupertinoButton(
            child: Text(_chosenDateTime != null
                ? _chosenDateTime.toString()
                : 'No date time picked!'),
            onPressed: () {
              _showDatePicker(context);
            },
          ),
          ElevatedButton(
              onPressed: () {
                _showDialog(context);
              },
              child: const Text("Show Dialog Cupertino"))
        ],
      ),
    );
  }

  // Material Dialog
  void showCustomDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            height: 240,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(40)),
            child: const SizedBox.expand(child: FlutterLogo()),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  //Cupertino Alert Dialog
  _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Column(
              children: const <Widget>[
                Text("CupertinoAlertDialog"),
                Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ],
            ),
            content: const Text("An iOS-style alert dialog." "An alert dialog informs the user about situations that require acknowledgement."
                    " An alert dialog has an optional title, optional content, and an optional list of actions."),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              CupertinoDialogAction(
                child: const Text("CANCEL"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              CupertinoDialogAction(
                child: const Text("MAY BE"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Widget setupAlertDialoadContainer() {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      color: Colors.red,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return const ListTile(
            title: Text('Gujarat, India'),
          );
        },
      ),
    );
  }

  Future selectDateRange(BuildContext context) async {
    DateTimeRange? pickedRange = await showDateRangePicker(
        context: context,
        initialDateRange: DateTimeRange(
          start: DateTime.now(),
          end: DateTime.now(),
        ),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 2),
        helpText: 'Select Date Range',
        cancelText: 'CANCEL',
        confirmText: 'OK',
        saveText: 'SAVE',
        errorFormatText: 'Invalid format.',
        errorInvalidText: 'Out of range.',
        errorInvalidRangeText: 'Invalid range.',
        fieldStartHintText: 'Start Date',
        fieldEndLabelText: 'End Date');

    if (pickedRange != null) {
      print(
          'picked range ${pickedRange.start} ${pickedRange.end} ${pickedRange.duration.inDays}');
    }

}

}
