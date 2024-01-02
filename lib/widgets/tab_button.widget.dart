import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  const TabButton({
    super.key,
    required this.title,
    this.selected = false,
  });

  final String title;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                color: selected ? Colors.black : Colors.grey,
              ),
            ),
            if (selected) Container(height: 2, color: Colors.red)
          ],
        ),
      ),
    );
  }
}
