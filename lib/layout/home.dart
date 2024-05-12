import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nasooh/Presentation/screens/Home/home_screen.dart';
import 'package:nasooh/Presentation/screens/UserProfileScreens/userProfileSettings/user_profile_screen.dart';
import 'package:nasooh/app/constants.dart';

import '../../../Data/repositories/notification/fcm.dart';
import '../Presentation/screens/UserProfileScreens/UserOrders/user_orders.dart';
import '../app/style/theme.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key, required this.currentIndex});

  final int currentIndex;

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  final screens = [
    const HomeScreen(),
    const OrdersScreen(),
    const ProfileScreen(),
  ];
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: false,
      extendBodyBehindAppBar: false,
      backgroundColor: Constants.whiteAppColor,
      body: IndexedStack(index: currentIndex, children: screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                color: Colors.blue.withOpacity(0.3),
                spreadRadius: 0.5,
                blurRadius: 5),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            selectedLabelStyle: const TextStyle(fontFamily: Constants.mainFont),
            unselectedLabelStyle:
                const TextStyle(fontFamily: Constants.mainFont),
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            selectedItemColor: const Color(0xFF0085A5),
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/SVGs/home1.svg',
                  colorFilter: getFilterColor(  currentIndex == 0
                      ? Constants.primaryAppColor
                      : Colors.grey),
                ),
                label: "Home".tr,
              ),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/images/SVGs/orders1.svg',

                    colorFilter: getFilterColor(  currentIndex == 1
                        ? Constants.primaryAppColor
                        : Colors.grey),

                  ),
                  label: "My Orders".tr),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/images/SVGs/person1.svg',
                    colorFilter: getFilterColor(  currentIndex == 2
                        ? Constants.primaryAppColor
                        : Colors.grey),
                  ),
                  label: "My Account".tr),
            ],
          ),
        ),
      ),
    );
  }
}
