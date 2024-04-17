import 'package:flutter/material.dart';
import 'package:social/widgets/others/custom_text.dart';

class CustomOR extends StatelessWidget {
  const CustomOR({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).scaffoldBackgroundColor;
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: color,
            thickness: 2,
          ),
        ),
        CustomText(
          title: ' Or ',
          color: color,
        ),
        Expanded(
          child: Divider(
            color: color,
            thickness: 2,
          ),
        ),
      ],
    );
  }
}
