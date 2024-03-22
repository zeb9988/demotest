import 'package:flutter/material.dart';

class TCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  TCheckbox({required this.value, required this.onChanged});

  @override
  _TCheckboxState createState() => _TCheckboxState();
}

class _TCheckboxState extends State<TCheckbox> {
  bool _value = false;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _value = !_value;
          widget.onChanged(_value);
        });
      },
      child: Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
              width: 2, color: _value ? Color(0xFFD6A95C) : Colors.grey),
        ),
        child: _value
            ? Icon(
                Icons.check,
                size: 12,
                color: Color(0xFFD6A95C),
              )
            : null,
      ),
    );
  }
}
