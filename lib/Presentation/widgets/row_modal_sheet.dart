import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../app/constants.dart';

class RowModalSheet extends StatelessWidget {
  const RowModalSheet(
      {this.onPressed, required this.imageIcon, required this.txt, super.key});

  final void Function()? onPressed;
  final String imageIcon;
  final String txt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:8.0),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(imageIcon),
            const SizedBox(
              width: 8,
            ),
            Text(
              txt,
              style: const TextStyle(
                  fontSize: 14,
                  fontFamily: Constants.mainFont,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
