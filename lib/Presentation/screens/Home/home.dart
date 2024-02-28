import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasooh/Presentation/screens/Home/home_screen.dart';
import 'package:nasooh/Presentation/screens/UserProfileScreens/userProfileSettings/user_profile_screen.dart';
import 'package:nasooh/app/constants.dart';
import '../UserProfileScreens/UserOrders/user_orders.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key, required this.currentIndex});
  final int currentIndex;

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  final screens = [
    const HomeScreen(),
    const UserOrdersScreen(),
    const UserProfileScreen(),
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
                icon: const Icon(Icons.home),
                label: "Home".tr,
              ),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.shopping_bag), label: "My Orders".tr),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.person), label: "My Account".tr),
            ],
          ),
        ),
      ),
    );
  }
}
