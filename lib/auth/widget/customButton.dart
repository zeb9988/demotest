import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Button extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget child;

  final Size minimumSize;
  const Button({
    Key? key,
    required this.onPressed,
    required this.child,
    this.minimumSize = const Size(100, 50),
  }) : super(key: key);

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(const Color(0xffD6A95C)),
        minimumSize: MaterialStateProperty.all<Size?>(widget.minimumSize),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
      child: widget.child,
    );
  }
}
