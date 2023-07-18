import 'package:flutter/material.dart';
import 'package:glamcode/util/dimensions.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.PADDING_SIZE_DEFAULT,
      color: const Color(0xFFFFF1F1),
    );
  }
}
