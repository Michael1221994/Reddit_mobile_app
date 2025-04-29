import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class flair_BottomsheetRows extends StatefulWidget {
  final String Text;
  final Function(String, bool) onChanged;
 flair_BottomsheetRows({
    super.key,
    required this.Text,
    required this.onChanged, 
    });

  @override
  State<flair_BottomsheetRows> createState() => _flair_BottomsheetRowsState();
}

class _flair_BottomsheetRowsState extends State<flair_BottomsheetRows> {
   bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: [
          Text(widget.Text),
           Transform.scale(
                      scale: 1.2,
                      child: CupertinoSwitch(
                        value: isSwitched,
                        onChanged: (bool value){
                          setState(() {
                            isSwitched=value;
                          });
                          widget.onChanged(widget.Text, value); 
                        },
                        activeColor: Colors.blue, // Color when ON
                        trackColor: Colors.transparent, // Track color when ON
                      ),
                    )
      ],)
    );
  }
}