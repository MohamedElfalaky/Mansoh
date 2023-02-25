import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/Presentation/screens/AuthenticationScreens/LoginScreen/loginscreen.dart';
import 'package:nasooh/Presentation/screens/Home/HomeScreen.dart';
import 'package:nasooh/Presentation/screens/OnBoardong/OnBoarding.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:nasooh/app/constants.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  final screens = [
    const HomeScreen(),
    OnBoarding(),
    const LoginScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.whiteAppColor,
      body: IndexedStack(index: currentIndex, children: screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            // backgroundColor: Colors.red,
            selectedLabelStyle: TextStyle(fontFamily: Constants.mainFont),
            unselectedLabelStyle: TextStyle(fontFamily: Constants.mainFont),
            type: BottomNavigationBarType.fixed,
            // backgroundColor: Theme.of(context).colorScheme.secondary,
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  // activeIcon: SvgPicture.asset(tempPic),
                  icon: Icon(Icons.home),
                  label: "الرئيسية"),
              BottomNavigationBarItem(
                  // activeIcon: SvgPicture.asset(tempPic),
                  icon: Icon(Icons.shopping_bag),
                  label: "طلباتي"),
              BottomNavigationBarItem(
                  // activeIcon: SvgPicture.asset(tempPic),
                  icon: Icon(Icons.person),
                  label: "ملفاتي"),
            ],
          ),
        ),
      ),
    );
  }
}
