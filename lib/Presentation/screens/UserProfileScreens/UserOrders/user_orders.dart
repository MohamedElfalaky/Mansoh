import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nasooh/Data/cubit/orders_cubit/orders_status_cubit/orders_status_cubit.dart';
import 'package:nasooh/Data/cubit/orders_cubit/orders_status_cubit/orders_status_state.dart';
import 'package:nasooh/Presentation/screens/chat_screen/chat_screen.dart';
import '../../../../../app/utils/my_application.dart';
import '../../../../Data/cubit/orders_cubit/orders_filters_cubit/orders_filters_cubit.dart';
import '../../../../Data/cubit/orders_cubit/orders_filters_cubit/orders_filters_state.dart';
import '../../../../app/constants.dart';
import '../../../widgets/shared.dart';
import '../../CompleteAdviseScreen/complete_advise_screen.dart';
import 'OrderCard/order_card.dart';

class UserOrdersScreen extends StatefulWidget {
  const UserOrdersScreen({super.key});

  @override
  State<UserOrdersScreen> createState() => _UserOrdersScreenState();
}

class _UserOrdersScreenState extends State<UserOrdersScreen> {
  late StreamSubscription<ConnectivityResult> subscription;
  bool? isConnected;

  final ScrollController _controller = ScrollController();

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
        return MediaQuery.of(context).size.width * 0.83;
      case 1:
        return MediaQuery.of(context).size.width * 0.7;
      case 2:
        return MediaQuery.of(context).size.width * 0.57;
      case 3:
        return MediaQuery.of(context).size.width * 0.42;
      case 4:
        return MediaQuery.of(context).size.width * 0.27;
      case 5:
        return MediaQuery.of(context).size.width * 0.14;
      default:
        return 0;
    }
  }

  double changeContainerWidth() {
    switch (isScrolling) {
      case true:
        return 0;
      case false:
        return 50;
      default:
        return 0;
    }
  }

  @override
  void initState() {
    MyApplication.checkConnection().then((value) {
      if (value) {
      } else {
        MyApplication.showToastView(message: 'noInternet'.tr);
      }
    });

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (mounted) {
        setState(() {
          result == ConnectivityResult.none
              ? isConnected = false
              : isConnected = true;
        });
      }

      if (result != ConnectivityResult.none) {}
    });
    context.read<OrdersStatusCubit>().getOrdersStatus();
    context.read<OrdersFiltersCubit>().getOrdersFilters(id: "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () {
          MyApplication.dismissKeyboard(context);
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: customABarNoIcon(
                txt: "my_orders".tr, back: false, context: context),
            body: BlocBuilder<OrdersStatusCubit, OrdersStatusState>(
                builder: (context, homeState) {
              if (homeState is OrdersStatusLoading) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (homeState is OrdersStatusLoaded) {
                var ordersList = homeState.response!.data;
                return Column(
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
                      height: 40,
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
                                onNotification: (scrollNotification) {
                                  if (scrollNotification
                                      is ScrollEndNotification) {
                                    setState(() {
                                      isScrolling = false;
                                    });
                                  } else if (scrollNotification
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
                                    itemCount: ordersList!.length,
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
                                            if (ordersList[index].id == 0) {
                                              context
                                                  .read<OrdersFiltersCubit>()
                                                  .getOrdersFilters(id: "");
                                            } else {
                                              context
                                                  .read<OrdersFiltersCubit>()
                                                  .getOrdersFilters(
                                                      id: ordersList[index]
                                                          .id
                                                          .toString());
                                            }
                                          },
                                          child: Text(
                                            ordersList[index].name!,
                                            style: Constants.subtitleRegularFont
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
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              width: changeContainerWidth(),
                              alignment: Alignment.center,
                              height: 2,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              duration: const Duration(milliseconds: 1000),
                              curve: Curves.fastLinearToSlowEaseIn,
                            ),
                          )
                        ],
                      ),
                    ),
                    buildOrdersFilterBlocBuilder()
                  ],
                );
              } else if (homeState is OrdersStatusEmpty) {
                return const Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(bottom: 150),
                  child: Center(
                      child: Text(
                    'لا يوجد ناصحين بهذا القسم',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      fontFamily: Constants.mainFont,
                    ),
                  )),
                ));
              }
              return const SizedBox.shrink();
            })));
  }

  BlocBuilder<OrdersFiltersCubit, OrdersFiltersState>
      buildOrdersFilterBlocBuilder() {
    return BlocBuilder<OrdersFiltersCubit, OrdersFiltersState>(
        builder: (context, ordersFilters) {
      if (ordersFilters is OrdersFiltersEmpty) {
        return const Expanded(
            child: Padding(
          padding: EdgeInsets.only(bottom: 150),
          child: Center(
              child: Text(
            'لا يوجد طلبات بهذا القسم',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              fontFamily: Constants.mainFont,
            ),
          )),
        ));
      }
      if (ordersFilters is OrdersFiltersLoading) {
        return const SizedBox(
          height: 200,
          child: Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        );
      } else if (ordersFilters is OrdersFiltersLoaded) {
        var filtersList = ordersFilters.response?.data;

        return Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(16.0),
              itemCount: filtersList?.length ?? 0,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: filtersList![index].label!.id == 1
                      ? () {
                          MyApplication.navigateTo(
                              context,
                              CompleteAdviseScreen(
                                adviceId: filtersList[index].id!,
                              ));
                        }
                      : () {
                          print(
                              'advisor profile data ${filtersList[index].adviser?.category?.length}');
                          MyApplication.navigateTo(
                              context,
                              ChatScreen(
                                statusClickable:
                                    filtersList[index].label!.id == 3,
                                labelToShow:
                                    filtersList[index].label!.id == 1 ||
                                        filtersList[index].label!.id == 2,
                                openedStatus: filtersList[index].label!.id == 2,
                                adviceId: filtersList[index].id!,
                                adviserProfileData: filtersList[index].adviser,
                              ));
                        },
                  child: OrderCard(orderFilterData: filtersList[index]),
                );
              }),
        );
      }
      return const SizedBox.shrink();
    });
  }
}
