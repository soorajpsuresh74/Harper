import 'package:flutter/material.dart';
import 'package:harper/Models/Dashboard/card.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Center the cards in the row
        children: [
          CardModel(
            colorName: 'blue',
            colorValue: Colors.blue,
            title: 'Custom Card Title 1',
            description: 'Description for card 1. Tap to see an action.',
            textColor: Colors.white,
          ),
          SizedBox(width: 10), // Add spacing between cards
          CardModel(
            colorName: 'green',
            colorValue: Colors.green,
            title: 'Custom Card Title 2',
            description: 'Description for card 2. Tap to see an action.',
            textColor: Colors.white,
          ),
          SizedBox(width: 10), // Add spacing between cards
          CardModel(
            colorName: 'red',
            colorValue: Colors.red,
            title: 'Custom Card Title 3',
            description: 'Description for card 3. Tap to see an action.',
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
