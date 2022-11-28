import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class V1TextFormField extends StatelessWidget {
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? hinttext;
  final Function? validator;
  // final Function? onChanged;

  const V1TextFormField({
    Key? key,
    this.hinttext,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hinttext,
          hintStyle: context.textTheme.bodyText1!
              .copyWith(fontWeight: FontWeight.normal),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        validator: (value) => validator?.call(value),
        // onChanged: (value) => onChanged?.call(value),
      ),
    );
  }
}
