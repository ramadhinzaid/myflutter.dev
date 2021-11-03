import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:zaid_study/appbar.dart';

class DateHome extends StatefulWidget {
  const DateHome({Key key}) : super(key: key);

  @override
  _DateHomeState createState() => _DateHomeState();
}

class _DateHomeState extends State<DateHome> {
  DateTime _dateSelected = DateTime.now();
  DateTime _predateSelect = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ZaidAppBar(
        title: "Date",
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat("dd MMM y", 'id_ID').format(_dateSelected) ?? "",
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              onPressed: () => _modals(context),
              child: Text(
                "Select Date",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  _modals(BuildContext context) {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (
          context,
        ) {
          return StatefulBuilder(builder: (context, setStateModal) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              alignment: Alignment.topCenter,
              height: 560,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 400,
                      child: SfDateRangePicker(
                        initialSelectedDate: _dateSelected,
                        onSelectionChanged: (date) => setStateModal(() {
                          _predateSelect = date.value;
                        }),
                        enablePastDates: false,
                        selectionTextStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                        selectionShape: DateRangePickerSelectionShape.circle,
                        monthViewSettings: DateRangePickerMonthViewSettings(
                          dayFormat: 'EEE',
                          weekendDays: [7],
                          showTrailingAndLeadingDates: true,
                        ),
                        monthCellStyle: DateRangePickerMonthCellStyle(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black87),
                          weekendTextStyle: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        navigationDirection:
                            DateRangePickerNavigationDirection.vertical,
                        selectionMode: DateRangePickerSelectionMode.single,

                        // build custom cell date
                        // cellBuilder:
                        //     (BuildContext context, DateRangePickerCellDetails details) {
                        //   final bool _isToday = details.date.toString().split(" ")[0] ==
                        //       DateTime.now().toString().split(" ")[0];

                        //   return Container(
                        //     height: 48,
                        //     width: 48,
                        //     decoration: BoxDecoration(
                        //         border: Border.all(
                        //             color: _isToday ? Colors.blue : Colors.white)),
                        //     child: Center(
                        //       child: Text(
                        //         details.date.day.toString(),
                        //         style: TextStyle(
                        //           color: _isToday ? Colors.blue : Colors.black,
                        //         ),
                        //       ),
                        //     ),
                        //   );
                        // },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(-3, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text("Pergi"),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                DateFormat("dd MMM y", 'id_ID')
                                        .format(_predateSelect) ??
                                    "",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            TextButton(
                                onPressed: () => {
                                      setStateModal(() {
                                        _dateSelected = _predateSelect;
                                      }),
                                      Navigator.of(context).pop(true)
                                    },
                                child: Container(
                                  height: 48,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Simpan",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          });
        }).whenComplete(() => setState(() {
          _predateSelect = _dateSelected;
        }));
  }
}
