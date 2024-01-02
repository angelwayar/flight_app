import 'package:flutter/material.dart';

class HeaderButton extends StatelessWidget {
  const HeaderButton({
    super.key,
    required this.title,
    this.selected = false,
  });

  final String title;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 13.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        color: selected ? Colors.white : null,
        border: Border.all(color: Colors.white),
      ),
      child: Center(
        child: Text(
          title.toUpperCase(),
          style: TextStyle(
            color: selected ? Colors.red : Colors.white,
          ),
        ),
      ),
    );
  }
}
