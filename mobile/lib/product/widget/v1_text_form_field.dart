import 'package:flutter/material.dart';

class V1TextFormField extends StatelessWidget {
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? hinttext;
  final bool obscureText;
  final Function? validator;
  final Function? onSaved;
  // final Function? onChanged;

  const V1TextFormField({
    Key? key,
    this.hinttext,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextFormField(
        obscureText: obscureText,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          errorMaxLines: 1,
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
