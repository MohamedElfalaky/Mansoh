import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app/constants.dart';
import '../../app/utils/lang/language_constants.dart';

class GoBack extends StatelessWidget {
  const GoBack({
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
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
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
        const GoBack(),
        const SizedBox(
          width: 16,
        ),
        Text(getTranslated(context, header ?? "")!,
            textAlign: TextAlign.right, style: Constants.headerNavigationFont),
      ],
    );
  }
}

customAppBar({
  BuildContext? context,
  required String txt,
  bool endIcon =false ,
  List<Widget>? actions
}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(60.0),
    child: AppBar(
      leading: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const SizedBox(width: 16,),
              Container(
                // margin: EdgeInsets.symmetric(horizontal: 10),
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
                    Navigator.pop(context!);
                  },
                  icon: SvgPicture.asset(
                    'assets/images/SVGs/back.svg',
                    width: 14,
                    height: 14,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      title: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Text(txt),
            ],
          ),
        ],
      ),
      actions: endIcon ?actions  : [],
    ),
  );
}
