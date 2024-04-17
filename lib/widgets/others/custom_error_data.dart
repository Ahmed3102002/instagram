import 'package:flutter/material.dart';
import 'package:social/widgets/others/custom_text.dart';

class CustomDataError extends StatelessWidget {
  const CustomDataError({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/error.png'),
        CustomText(
          title: 'Some thing error \n Try again later',
          fontSize: 20,
          color: Theme.of(context).dividerColor,
        )
      ],
    );
  }
}
