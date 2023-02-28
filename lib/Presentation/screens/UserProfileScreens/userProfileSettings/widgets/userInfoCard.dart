import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../app/constants.dart';

class UserInfoCard extends StatelessWidget {
  const UserInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: const VisualDensity(horizontal: 0, vertical: 4),
      leading: Stack(
        children: [
          Container(
            height: 60,
            width: 60,
            color: Colors.white,
            child: const CircleAvatar(
              radius: 30,
              backgroundColor: Colors.transparent,
              child: CircleAvatar(
                radius: 28,
                backgroundColor: Colors.black12,
                child: Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          SvgPicture.asset(
            "assets/images/SVGs/Ellipse.svg",
            color: Colors.black54,
            width: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50, right: 22),
            child: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.black87,
              child: SvgPicture.asset(
                "assets/images/SVGs/pen.svg",
                color: Colors.white,
                width: 8,
              ),
            ),
          )
        ],
      ),
      title: const Text(
        "عبد الرحمن محمد كامل",
        style: Constants.mainTitleFont,
      ),
      subtitle: const Text(
        "(مستخدم)",
        style: Constants.subtitleFont1,
      ),
      trailing: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: CircleAvatar(
            radius: 16,
            backgroundColor: const Color(0xff0085A5).withOpacity(0.2),
            child: SvgPicture.asset(
              "assets/images/SVGs/pen.svg",
              color: const Color(0xff0085A5),
              width: 12,
            ),
          )),
    );
  }
}
