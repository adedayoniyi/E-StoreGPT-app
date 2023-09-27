import 'package:flutter/material.dart';

class QuickSearchContainer extends StatelessWidget {
  final Color borderColor;
  final String searchText;
  const QuickSearchContainer({
    Key? key,
    required this.borderColor,
    required this.searchText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        // height:,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: borderColor,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            searchText,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
