import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class TextComponent extends StatelessWidget {
  String texto;
  TextComponent({
    super.key,
    required this.texto,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            texto,
            style: TextStyle(
              color: kTitleTextColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Ver todo',
            style: TextStyle(
              color: kButtonColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
