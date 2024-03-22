import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final Icon icon;
  final String hintText;
  final int maxLines;
  final bool is_pass;
  final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    required this.icon,
    required this.is_pass,
    this.validator,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 63,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(color: Colors.black),
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.is_pass && !_isPasswordVisible,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: widget.icon,
          ),
          hintText: widget.hintText,
          border: InputBorder.none,
          errorStyle: TextStyle(color: Colors.black),
          suffixIcon: widget.is_pass
              ? IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                )
              : null,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Enter your ${widget.hintText}';
          }
          return widget.validator?.call(value);
        },
        maxLines: widget.maxLines,
      ),
    );
  }
}
