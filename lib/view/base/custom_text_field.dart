import 'package:flutter/material.dart';
import 'package:glamcode/util/dimensions.dart';

Widget customTextField(
    String title,
    TextEditingController textEditingController,
    TextInputType? textInputType,
    String? Function(String?)? fn) {
  return Padding(
    padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
    child: TextFormField(
      decoration: InputDecoration(
          focusColor: Colors.black,
          floatingLabelStyle: const TextStyle(color: Colors.black),
          labelText: title,
          border: InputBorder.none,),
      keyboardType: textInputType ?? TextInputType.text,
      controller: textEditingController,
      validator: fn ?? defaultValidator,
    ),
  );
}

String? defaultValidator(String? value) {
  if(value != null) {
    if(value.trim().isEmpty) {
      return 'Field cannot be blank';
    }
  }
  return null;
}
