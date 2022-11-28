import 'package:flutter/material.dart';

class V1Container extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;

  const V1Container({
    Key? key,
    this.height,
    this.width,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 250,
      height: height ?? 50,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
            offset: Offset(0.0, 1.0),
            blurRadius: 6.0,
          ),
        ],
        border: Border.all(color: Colors.black12),
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      ),
      child: child,
    );
  }
}
