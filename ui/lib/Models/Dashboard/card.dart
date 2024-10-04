import 'package:flutter/material.dart';

class CardModel extends StatelessWidget {
  final String colorName;
  final Color colorValue;
  final String title;
  final String description;
  final Color textColor;

  const CardModel({
    required this.colorName,
    required this.colorValue,
    required this.title,
    required this.description,
    required this.textColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        splashColor: colorValue.withAlpha(30),
        onTap: () {
          debugPrint('$title tapped. Color: $colorName');
        },
        child: SizedBox(
          width: 300,
          height: 150,
          child: Container(
            color: colorValue,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: textColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
