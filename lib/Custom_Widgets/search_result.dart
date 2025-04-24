import 'package:flutter/material.dart';

class SearchResult extends StatelessWidget {
  final String name;
  final String description;
  final bool adult;
  void Function()? ontap;
   SearchResult({
    super.key,
    required this.name,
    required this.description,
    required this.adult,
    required this.ontap
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(20), 
          ),
      ),
    );
  }
}