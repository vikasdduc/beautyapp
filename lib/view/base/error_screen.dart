import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomError extends StatelessWidget {

  const CustomError({
    Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
              'assets/images/error.jpg'),
          const Text(
            'Oops! Something went wrong!',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: kDebugMode ? Colors.red : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 21),
          ),
          const SizedBox(height: 12),
          const Text(
            kDebugMode
                ? 'https://docs.flutter.dev/testing/errors'
                : "We encountered an error and we've notified our engineering team about it. Sorry for the inconvenience caused.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
        ],
      ),
    );
  }
}