import 'package:flutter/material.dart';

Size displaySize(BuildContext context) {
  // print(MediaQuery.of(context).size);
  return MediaQuery.of(context).size;
}

double displayHeight(BuildContext context) {
  // print(displaySize(context).height);
  return displaySize(context).height;
}

double displayWidth(BuildContext context) {
  // print(displaySize(context).width);
  return displaySize(context).width;
}
