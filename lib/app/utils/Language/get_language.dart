import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasooh/app/utils/sharedPreferenceClass.dart';
import '../../Style/sizes.dart';
import '../../constants.dart';
import 'ar.dart';
import 'en.dart';


class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys =>
      {'ar': getArabicLanguage(), 'en': getEnglishLanguage()};
}






enum SingingCharacter { Arabic, English }

class ChangeLangItem extends StatefulWidget {
  const ChangeLangItem({
    Key? key,
  }) : super(key: key);

  @override
  State<ChangeLangItem> createState() => _ChangeLangItemState();
}

class _ChangeLangItemState extends State<ChangeLangItem> {
  SingingCharacter _character = Get.locale!.languageCode == 'en'
      ? SingingCharacter.English
      : SingingCharacter.Arabic;

  void arabSelection(SingingCharacter value) {
    setState(() {
      _character = value;
      Get.updateLocale(const Locale('ar'));
      sharedPrefs.setLanguage( 'ar' );
    });
  }

  void engSelection(SingingCharacter value) {
    setState(() {
      _character = value;
      Get.updateLocale(const Locale('en'));
      sharedPrefs.setLanguage( 'en' );
    });
  }

  @override
  void initState() {
    sharedPrefs.getLanguage();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return    Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            Radio(
              activeColor: Constants.primaryAppColor,
              value: SingingCharacter.Arabic,
              onChanged: (val) {
                arabSelection(val as SingingCharacter);
              },
              groupValue: _character,
            ),
            const Text("العربية", style: Constants.mainTitleFont),
          ],
        ),
        Row(
          children: [
            Radio(
              activeColor: Constants.primaryAppColor,
              value: SingingCharacter.English,
              onChanged: (val) {
                engSelection(val as SingingCharacter);
              },
              groupValue: _character,
            ),
            const Text("English", style: Constants.mainTitleFont),
          ],
        )
      ],
    );
  }
}




class ColoredContain extends StatelessWidget {
  const ColoredContain({Key? key, this.color, this.txt}) : super(key: key);
  final Color ?color;
  final String ?txt;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context) * 0.3,
      height: height(context) * 0.06,
      decoration:
      BoxDecoration(borderRadius: BorderRadius.circular(15), color: color),
      child: Center(
          child: Text(
             txt!)),
    );
  }
}
