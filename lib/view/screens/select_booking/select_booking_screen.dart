import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glamcode/data/api/api_helper.dart';

import 'package:glamcode/view/base/error_screen.dart';
import 'package:glamcode/view/screens/select_booking/bookingslotmodel.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../blocs/cart_data/cart_data_bloc.dart';
import '../../../util/dimensions.dart';
import '../../base/loading_screen.dart';
import '../payment/payment_screen.dart';

class SelectBookingDateScreen extends StatefulWidget {
  const SelectBookingDateScreen({Key? key}) : super(key: key);

  @override
  State<SelectBookingDateScreen> createState() =>
      _SelectBookingDateScreenState();
}

class _SelectBookingDateScreenState extends State<SelectBookingDateScreen> {
  late Future<BookingSlotModel?> _future;

  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("BOOKING SLOT"),
      ),
      body: Column(
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
                  final DateTime dateTime = DateTime.parse(selectedDateTime);
                  final DateFormat formatter = DateFormat('HH:mm:ss');
                  final timeSlot = formatter.format(dateTime);
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
                        List<Status> slotArray = bookingSlotsData.status ?? [];
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
                                  final date =
                                      DateTime.parse(slotArray[index].d!);
                                  final DateFormat formatter =
                                      DateFormat('HH:mm:ss');
                                  setState(() {
                                    context.read<CartDataBloc>().add(
                                        CartBookingSlotUpdate(formatter
                                            .parseStrict(
                                                slotArray[index].otherDate!)
                                            .copyWith(
                                              year: date.year,
                                              month: date.month,
                                              day: date.day,
                                            )
                                            .toString()));
                                  });
                                },
                                child: timeSlot ==
                                        "${(slotArray[index].otherDate)}"
                                    ? Card(
                                        color: const Color(0xFFae65ff),
                                        child: Center(
                                            child: Text(
                                          (slotArray[index].otherDate) ?? "",
                                          style: const TextStyle(
                                              color: Colors.white),
                                        )),
                                      )
                                    : Card(
                                        color: const Color(0xFFd9bef4),
                                        child: Center(
                                          child: Text(
                                            slotArray[index].otherDate ?? "",
                                          ),
                                        ),
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
        ],
      ),
      bottomNavigationBar: BlocBuilder<CartDataBloc, CartDataState>(
        builder: (context, cartState) {
          if (cartState is CartDataLoading) {
            return const LoadingScreen();
          } else if (cartState is CartDataLoaded) {
            return BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Total Price",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Rs. ${cartState.cartData.originalAmount}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding:
                        const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFFA854FC),
                            minimumSize: const Size(double.infinity,
                                Dimensions.PADDING_SIZE_DEFAULT),
                            padding: const EdgeInsets.symmetric(
                                vertical: Dimensions.PADDING_SIZE_DEFAULT),
                            textStyle: TextStyle(
                                fontSize: Dimensions.fontSizeExtraLarge)),
                        onPressed: () {
                          if (cartState.cartData.bookingDateTime != null &&
                              cartState.cartData.bookingDateTime != "") {
                            // Navigator.pushNamed(context, '/cart');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PaymentScreen()));
                            //was builder: (context) => const cartScreen()));
                            // Navigator.pushNamed(context, '/payment');
                          } else {
                            Fluttertoast.showToast(
                                msg: "Please select a time slot.",
                                gravity: ToastGravity.BOTTOM);
                          }
                        },
                        child: const Text("Next")),
                  ))
                ],
              ),
            );
          } else {
            return const CustomError();
          }
        },
      ),
    );
  }
}
