import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glamcode/view/screens/dashboard/dashboard_screen.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../blocs/cart_data/cart_data_bloc.dart';
import '../../../../data/api/api_helper.dart';
import '../../../../data/model/bookings.dart';
import '../../../base/error_screen.dart';
import '../../../base/loading_screen.dart';
import '../../select_booking/bookingslotmodel.dart';

class RecheduleBottomSheet extends StatefulWidget {
  final OngoingBookingsArr ongoingBookingsArr;
  const RecheduleBottomSheet({super.key, required this.ongoingBookingsArr});

  @override
  State<RecheduleBottomSheet> createState() => _RecheduleBottomSheetState();
}

class _RecheduleBottomSheetState extends State<RecheduleBottomSheet> {
  late Future<BookingSlotModel?> _future;
  String? datetimetopass;
  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  bool isCurrent = false;

  @override
  void initState() {
    _future = getBookingSlots(DateTime.now());
    currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    context.read<CartDataBloc>().add(const CartBookingSlotUpdate(""));
    super.initState();
  }

  Future<BookingSlotModel?> getBookingSlots(DateTime dateTime) {
    return DioClient.instance.getBookingSlots(dateTime);
  }

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement == CalendarElement.calendarCell) {
      print(calendarTapDetails.date);
      setState(() {
        _future = DioClient.instance
            .getBookingSlots(calendarTapDetails.date ?? DateTime.now());
        currentDate = DateFormat('yyyy-MM-dd')
            .format(calendarTapDetails.date ?? DateTime.now());
        // appointmentDetails = calendarTapDetails.appointments!.cast<Appointment>();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: SfCalendar(
            view: CalendarView.month,
            todayTextStyle: const TextStyle(color: Colors.white),
            allowAppointmentResize: false,
            allowDragAndDrop: false,
            allowViewNavigation: false,
            showNavigationArrow: true,
            todayHighlightColor: const Color(0xFFae65ff),
            initialSelectedDate: DateTime.now(),
            monthViewSettings: const MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
              dayFormat: 'EEE',
              showAgenda: false,
              showTrailingAndLeadingDates: true,
              numberOfWeeksInView: 5,
              monthCellStyle: MonthCellStyle(
                backgroundColor: Colors.white,
                todayBackgroundColor: Colors.white,
                textStyle: TextStyle(color: Colors.black),
              ),
            ),
            minDate: DateTime.now(),
            onTap: calendarTapped,
            selectionDecoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: const Color(0xFFae65ff), width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(25)),
              shape: BoxShape.rectangle,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: BlocBuilder<CartDataBloc, CartDataState>(
            builder: (context, cartState) {
              if (cartState is CartDataLoading) {
                return const LoadingScreen();
              } else if (cartState is CartDataLoaded) {
                String selectedDateTime =
                    cartState.cartData.bookingDateTime ?? "";
                log(selectedDateTime.toString());
                String timeSlot = "";
                try {
                  final DateTime dateTime = DateTime.parse(selectedDateTime);
                  final DateFormat formatter = DateFormat('HH:mm:ss');
                  timeSlot = formatter.format(dateTime);
                } catch (e) {}
                return FutureBuilder<BookingSlotModel?>(
                  future: _future,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const LoadingScreen();
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      BookingSlotModel bookingSlotsData = BookingSlotModel();
                      if (snapshot.hasData) {
                        bookingSlotsData = snapshot.data!;
                        print(bookingSlotsData.status);
                      }
                      List<AvailableSlots> slotArray =
                          bookingSlotsData.availableSlots ?? [];
                      return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1.5,
                            crossAxisCount: 4,
                          ),
                          itemCount: slotArray.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                // final date = DateTime.parse(
                                //     "2023-10-03T10:00:00.000000Z");
                                // final DateFormat formatter =
                                //     DateFormat('HH:mm:ss');
                                setState(() {
                                  context.read<CartDataBloc>().add(
                                      CartBookingSlotUpdate(
                                          "${slotArray[index].date!} ${slotArray[index].otherDate}"));
                                  datetimetopass =
                                      "${slotArray[index].date} ${slotArray[index].otherDate}";
                                });
                                log("${timeSlot}");
                                log("The date time to pass $datetimetopass");
                              },
                              // child: timeSlot == "${(slotArray[index].date)}${slotArray[index].slotStartTime}"
                              child: (slotArray[index].isCurrent == true)
                                  ? (selectedDateTime ==
                                          "${slotArray[index].date!} ${slotArray[index].otherDate}"
                                      ? Card(
                                          color: const Color(0xFFae65ff),
                                          child: Center(
                                              child: Text(
                                            (slotArray[index].slotStartTime) ??
                                                "",
                                            style: const TextStyle(
                                                color: Colors.white),
                                          )),
                                        )
                                      : Card(
                                          color: const Color(0xFFd9bef4),
                                          child: Center(
                                            child: Text(
                                              slotArray[index].slotStartTime ??
                                                  "",
                                            ),
                                          ),
                                        ))
                                  : const Card(
                                      color: const Color(0xFFd9bef4),
                                      child: Center(
                                          child: Text(
                                        // (slotArray[index]
                                        //         .slotStartTime) ??
                                        "Not Available",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 10),
                                      )),
                                    ),
                            );
                          });
                    } else {
                      return const CustomError();
                    }
                  },
                );
              } else {
                return const CustomError();
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CupertinoButton(
              child: Text(
                "Reschedule",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if (datetimetopass != null) {
                  DioClient.instance.cancelReschedule(
                      widget.ongoingBookingsArr.bookingId.toString(),
                      datetimetopass.toString(),
                      "2");
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Rescheduled to $datetimetopass"),
                    backgroundColor: Colors.green,
                  ));
                  setState(() {
                    datetimetopass = null;
                  });
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              DashboardScreen(pageIndex: 2))));
                }
              },
              color: (datetimetopass != null)
                  ? Color.fromARGB(255, 2, 195, 50)
                  : Colors.white),
        ),
      ],
    );
  }
}
