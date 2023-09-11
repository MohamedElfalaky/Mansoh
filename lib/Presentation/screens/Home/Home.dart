import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/Presentation/screens/AuthenticationScreens/LoginScreen/check_mob_screen.dart';
import 'package:nasooh/Presentation/screens/Home/HomeScreen.dart';
import 'package:nasooh/Presentation/screens/OnBoardong/OnBoarding.dart';
import 'package:nasooh/Presentation/screens/UserProfileScreens/userProfileSettings/userProfileScreen.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:nasooh/app/constants.dart';

import '../../../app/utils/lang/language_constants.dart';
import '../UserProfileScreens/UserOrders/UserOrders.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  final screens = [
    const HomeScreen(),
    const UserOrders(),
    const UserProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.whiteAppColor,
      body: IndexedStack(index: currentIndex, children: screens),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            // backgroundColor: Colors.red,
            selectedLabelStyle: const TextStyle(fontFamily: Constants.mainFont),
            unselectedLabelStyle:
                const TextStyle(fontFamily: Constants.mainFont),
            type: BottomNavigationBarType.fixed,
            // backgroundColor: Theme.of(context).colorScheme.secondary,
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                // activeIcon: SvgPicture.asset(tempPic),
                icon: const Icon(Icons.home),
                label: getTranslated(context, "Home")!,
              ),
              BottomNavigationBarItem(
                  // activeIcon: SvgPicture.asset(tempPic),
                  icon: const Icon(Icons.shopping_bag),
                  label: getTranslated(context, "My Orders")!),
              BottomNavigationBarItem(
                  // activeIcon: SvgPicture.asset(tempPic),
                  icon: const Icon(Icons.person),
                  label: getTranslated(context, "My Account")!),
            ],
          ),
        ),
      ),
    );
  }
}
