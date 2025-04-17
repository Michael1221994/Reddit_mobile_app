import 'package:flutter/material.dart';

class daysLimit extends StatefulWidget {
    final String value;
    final String? groupValue;
    final ValueChanged<String?> onChanged;
   daysLimit({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged
    });

  @override
  State<daysLimit> createState() => _daysLimitState();
}

class _daysLimitState extends State<daysLimit> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(value: widget.value, 
        groupValue:widget.groupValue, 
        onChanged:widget.onChanged
        ),

        Text(widget.value+ "days")
      ],
    );
  }
}