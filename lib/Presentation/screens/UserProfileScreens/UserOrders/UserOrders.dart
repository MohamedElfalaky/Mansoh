import 'package:flutter/material.dart';

import '../../../../../app/utils/myApplication.dart';
import '../../../../app/constants.dart';
import '../../../widgets/shared.dart';
import 'OrderCard/OrderCard.dart';

class UserOrders extends StatefulWidget {
  const UserOrders({Key? key}) : super(key: key);

  @override
  State<UserOrders> createState() => _UserOrdersState();
}

class _UserOrdersState extends State<UserOrders> {
  final ScrollController _controller = ScrollController();
  List<String> tabs = [
    "الكل",
    "الحالية",
    "المكتملة",
    "المرفوضة",
    "المعترضة",
    "المنتهية"
  ];
  int current = 0;
  bool isScrolling = false;
  void _animateToIndex(int index) {
    _controller.animateTo(
      index * MediaQuery.of(context).size.width,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  double changePositionedOfLine() {
    switch (current) {
      case 0:
        return MediaQuery.of(context).size.width * 0.85;
      case 1:
        return MediaQuery.of(context).size.width * 0.73;
      case 2:
        return MediaQuery.of(context).size.width * 0.60;
      case 3:
        return MediaQuery.of(context).size.width * 0.45;
      case 4:
        return MediaQuery.of(context).size.width * 0.28;
      case 5:
        return MediaQuery.of(context).size.width * 0.13;
      default:
        return 0;
    }
  }

  double changeContainerWidth() {
    switch (isScrolling) {
      case true:
        return 0;
      case false:
        return 30;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () {
          MyApplication.dismissKeyboard(context);
        },
        child: SafeArea(
          child: DefaultTabController(
              length: 5,
              child: Scaffold(
                appBar: AppBar(
                  leadingWidth: 150,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: Back(
                    header: "my_orders",
                  ),
                ),
                body: SizedBox(
                  width: size.width,
                  height: size.height,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 10), // changes position of shadow
                            ),
                          ],
                        ),
                        width: size.width,
                        height: size.height * 0.06,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: SizedBox(
                                width: size.width,
                                height: size.height * 0.04,
                                child: NotificationListener<ScrollNotification>(
                                  onNotification: (ScrollNotification) {
                                    if (ScrollNotification
                                        is ScrollEndNotification) {
                                      setState(() {
                                        isScrolling = false;
                                      });
                                    } else if (ScrollNotification
                                        is ScrollUpdateNotification) {
                                      setState(() {
                                        isScrolling = true;
                                      });
                                    }
                                    return true;
                                  },
                                  child: ListView.builder(
                                      controller: _controller,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: tabs.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: index == 0
                                                ? MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.05
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.02,
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                current = index;
                                                index <= 4
                                                    ? _animateToIndex(0)
                                                    : null;
                                              });
                                            },
                                            child: Text(
                                              tabs[index],
                                              style: Constants
                                                  .subtitleRegularFont
                                                  .copyWith(
                                                fontWeight: current == index
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                                fontSize:
                                                    current == index ? 14 : 12,
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            ),
                            AnimatedPositioned(
                              curve: Curves.fastLinearToSlowEaseIn,
                              bottom: 10,
                              left: changePositionedOfLine(),
                              duration: const Duration(milliseconds: 500),
                              child: AnimatedContainer(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                width: changeContainerWidth(),
                                height: size.height * 0.002,
                                decoration: BoxDecoration(
                                  color: Colors.black38,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                duration: const Duration(milliseconds: 1000),
                                curve: Curves.fastLinearToSlowEaseIn,
                              ),
                            )
                          ],
                        ),
                      ),
                      if (current == 0)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ListView.builder(
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return const OrderCard();
                                }),
                          ),
                        )
                      else if (current == 1)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ListView.builder(
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return const OrderCard();
                                }),
                          ),
                        )
                      else if (current == 2)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ListView.builder(
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return const OrderCard();
                                }),
                          ),
                        )
                      else if (current == 3)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ListView.builder(
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return const OrderCard();
                                }),
                          ),
                        )
                      else if (current == 4)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ListView.builder(
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return const OrderCard();
                                }),
                          ),
                        )
                      else if (current == 5)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ListView.builder(
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return const OrderCard();
                                }),
                          ),
                        )
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
