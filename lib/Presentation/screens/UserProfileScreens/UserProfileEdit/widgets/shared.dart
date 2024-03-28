import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../app/constants.dart';

class SeparatorWidget extends StatelessWidget {
  const SeparatorWidget({super.key, this.height = 1, this.color = Colors.black});

  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}

Widget buildSaveButton({required String label, void Function()? onPressed}) =>
    Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
      child: FloatingActionButton.extended(
        backgroundColor: Constants.primaryAppColor,
        onPressed: onPressed ?? () {},
        label: Text(label.tr,
            style: Constants.secondaryTitleFont.copyWith(
              color: Colors.white,
            )),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
