import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/app/utils/shared_preference.dart';

import '../../../../../app/constants.dart';
import '../../UserProfileEdit/user_profile_edit.dart';

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
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.transparent,
              child: sharedPrefs.getUserPhoto() == ""
                  ? const CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.black12,
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.black54,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: Container(
                        height: 60,
                        width: 60,
                        color: Colors.white,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.transparent,
                          child: Image.network(
                            sharedPrefs.getUserPhoto(),
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
            ),
          ),
          SvgPicture.asset(
            "assets/images/SVGs/Ellipse.svg",
            color: Colors.black54,
            width: 60,
          ),

        ],
      ),
      title: Text(
        sharedPrefs.getUserName,
        style: Constants.mainTitleFont,
      ),
      subtitle: const Text(
        "(مستخدم)",
        style: Constants.subtitleFont1,
      ),
      trailing: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const UserProfileEdit(),
            ),
          );
        },
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Constants.primaryAppColor,
          child: SvgPicture.asset(
            "assets/images/SVGs/pen.svg",
            color: Colors.white,
            width: 19,
          ),
        ),
      ),
    );
  }
}
