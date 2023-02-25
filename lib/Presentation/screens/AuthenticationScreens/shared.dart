import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app/constants.dart';
import '../../../app/utils/lang/language_constants.dart';

class goBack extends StatelessWidget {
  const goBack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            offset: Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: SvgPicture.asset(
          'assets/images/SVGs/back.svg',
          width: 14,
          height: 14,
        ),
      ),
    );
  }
}

class MyPrefixWidget extends StatelessWidget {
  MyPrefixWidget({Key? key, this.svgString}) : super(key: key);
  String? svgString;
  String getSvgString() {
    return svgString == null ? 'assets/images/SVGs/flag.svg' : svgString!;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Container(
        width: 60,
        height: 60,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          // shape: BoxShape.rectangle,
          color: Color(0xffEEEEEE),
        ),
        child: SvgPicture.asset(
          getSvgString(),
        ),
      ),
    );
  }
}

class Back extends StatelessWidget {
  Back({Key? key, this.header}) : super(key: key);
  String? header;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const goBack(),
        const SizedBox(
          width: 16,
        ),
        Text(getTranslated(context, header ?? "")!,
            textAlign: TextAlign.right, style: Constants.headerNavigationFont),
      ],
    );
  }
}
