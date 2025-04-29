import 'package:flutter/material.dart';
import 'package:reddit_attempt2/Custom_Widgets/rows_for_flair_bottomsheet.dart';


class FlairesBottomsheet extends StatefulWidget {
  final Function(String , bool) onToggle;
  const FlairesBottomsheet({
    super.key,
    required this.onToggle
    });

  @override
  State<FlairesBottomsheet> createState() => _FlairesBottomsheetState();
}

class _FlairesBottomsheetState extends State<FlairesBottomsheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          flair_BottomsheetRows(Text: "Not Safe For Work (NSFW)",onChanged: widget.onToggle,),
          flair_BottomsheetRows(Text: "Spoiler",onChanged: widget.onToggle,),
          flair_BottomsheetRows(Text: "Brand affiliate",onChanged: widget.onToggle,),
        ],
      ),
    );
  }
}