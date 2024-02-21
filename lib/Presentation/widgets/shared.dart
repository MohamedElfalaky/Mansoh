import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../app/Style/icons.dart';
import '../../app/constants.dart';
getMaterialColor({required int colorHex}) {
  Map<int, Color> color = {
    50: const Color.fromRGBO(0, 123, 165, .1),
    100: const Color.fromRGBO(0, 123, 165, .2),
    200: const Color.fromRGBO(0, 123, 165, .3),
    300: const Color.fromRGBO(0, 123, 165, .4),
    400: const Color.fromRGBO(0, 123, 165, .5),
    500: const Color.fromRGBO(0, 123, 165, .6),
    600: const Color.fromRGBO(0, 123, 165, .7),
    700: const Color.fromRGBO(0, 123, 165, .8),
    800: const Color.fromRGBO(0, 123, 165, .9),
    900: const Color.fromRGBO(0, 123, 165, 1),
  };
  return MaterialColor(colorHex, color);
}

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
  const MyPrefixWidget({Key? key, this.svgString}) : super(key: key);
 final String? svgString;

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
  const Back({Key? key, this.header}) : super(key: key);
  final String? header;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const GoBack(),
        const SizedBox(
          width: 16,
        ),
        Text((header ?? "").tr,
            textAlign: TextAlign.right, style: Constants.headerNavigationFont),
      ],
    );
  }
}

customAppBar({
  required BuildContext context,
  required String txt,
  bool endIcon = false,
  List<Widget>? actions,
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
              const SizedBox(
                width: 16,
              ),
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
                    Navigator.pop(context);
                  },
                  icon: Get.locale!.languageCode == "ar"
                      ? SvgPicture.asset(
                          backArIcon,
                          width: 14,
                          height: 14,
                        )
                      : const Icon(
                          Icons.arrow_back,
                          color: Colors.black54,
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
      actions: endIcon ? actions : [],
    ),
  );
}

customABarNoIcon({required BuildContext context,
  required String txt,
  required bool  back,
}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(60.0),
    child: AppBar(
      title: Padding(
        padding: const EdgeInsets.only(right: 10,left: 10),
        child: Text(txt.tr),
      ),
      automaticallyImplyLeading: back,
    ),
  );
}
