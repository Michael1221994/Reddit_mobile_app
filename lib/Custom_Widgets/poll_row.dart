import 'package:flutter/material.dart';


class PollRow extends StatefulWidget {
  final TextEditingController textcontroller;
  void Function()? removePolls;
  final int counter;
   PollRow({
    super.key,
    required this.textcontroller,
    required this.removePolls,
    required this.counter,
    });

  @override
  State<PollRow> createState() => _PollRowState();
}

class _PollRowState extends State<PollRow> {
  @override
  Widget build(BuildContext context) {
  return Row(
    children: [
      Flexible(
        fit: FlexFit.loose,
        child: TextField(
          controller: widget.textcontroller, // Correctly reference the controller based on current index
          decoration: const InputDecoration(labelText: "Other poll"),
        ),
      ),
      IconButton(
        icon:  const Icon(Icons.cancel),
        onPressed: widget.removePolls,
        
      ),
      
    ],
  );
}
}