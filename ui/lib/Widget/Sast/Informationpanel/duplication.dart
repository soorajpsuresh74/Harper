import 'package:flutter/cupertino.dart';

class Duplication extends StatelessWidget {
  const Duplication({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('A'),
        Text('B'),
        Text('C'),
        Text('D'),
        Text('E'),
      ],
    );
  }
}
