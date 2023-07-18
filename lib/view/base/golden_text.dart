import 'package:flutter/material.dart';
import 'package:glamcode/util/dimensions.dart';

class GoldenText extends StatelessWidget {
  final String text;
  const GoldenText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_EXTRA_SMALL),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        color: const Color(0x3CFFA500),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: Dimensions.fontSizeSmall,
          color: Colors.orange,
            overflow: TextOverflow.fade
        ),
      ),
    );
  }
}
