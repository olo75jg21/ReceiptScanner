import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class V1TextFormField extends StatelessWidget {
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? hinttext;
  final Function? validator;
  final Function? onSaved;
  // final Function? onChanged;

  const V1TextFormField({
    Key? key,
    this.hinttext,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          errorMaxLines: 3,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hinttext,
        ),
        validator: (value) => validator?.call(value),
        onSaved: (value) => onSaved?.call(value),
        // onChanged: (value) => onChanged?.call(value),
      ),
    );
  }
}
