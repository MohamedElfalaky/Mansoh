import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nasooh/Data/cubit/orders_cubit/orders_status_cubit/orders_status_cubit.dart';
import 'package:nasooh/Data/cubit/orders_cubit/orders_status_cubit/orders_status_state.dart';
import '../../../../../app/utils/myApplication.dart';
import '../../../../Data/cubit/orders_cubit/orders_filters_cubit/orders_filters_cubit.dart';
import '../../../../Data/cubit/orders_cubit/orders_filters_cubit/orders_filters_state.dart';
import '../../../../app/constants.dart';
import '../../../widgets/shared.dart';
import 'OrderCard/OrderCard.dart';

class UserOrders extends StatefulWidget {
  const UserOrders({Key? key}) : super(key: key);

  @override
  State<UserOrders> createState() => _UserOrdersState();
}

class _UserOrdersState extends State<UserOrders> {
  late StreamSubscription<ConnectivityResult> subscription;
  bool? isConnected;

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
        MyApplication.showToastView(message: '${'noInternet'.tr}');
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
    context.read<OrdersFiltersCubit>().getOrdersFilters("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () {
          MyApplication.dismissKeyboard(context);
        },
        child: SafeArea(
            child: Scaffold(
                appBar: customABarNoIcon(
                  txt: "my_orders".tr,
                  // context: context
                ),
                body: BlocBuilder<OrdersStatusCubit, OrdersStatusState>(
                    builder: (context, homeState) {
                  if (homeState is OrdersStatusLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (homeState is OrdersStatusLoaded) {
                    print("homeData is ${homeState.response!.pagination}");
                    var list = homeState.response!.data;
                    return SizedBox(
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
                                    child: NotificationListener<
                                        ScrollNotification>(
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
                                          itemCount: list!.length,
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
                                                  if (list[index].id == 0) {
                                                    context
                                                        .read<
                                                            OrdersFiltersCubit>()
                                                        .getOrdersFilters(
                                                            "");
                                                  } else {
                                                    context
                                                        .read<
                                                            OrdersFiltersCubit>()
                                                        .getOrdersFilters(
                                                            list[index].id.toString());
                                                    print(
                                                        "list[index].id! is ${list[index].id!}");
                                                  }
                                                },
                                                child: Text(
                                                  list[index].name!,
                                                  style: Constants
                                                      .subtitleRegularFont
                                                      .copyWith(
                                                    fontWeight: current == index
                                                        ? FontWeight.bold
                                                        : FontWeight.normal,
                                                    fontSize: current == index
                                                        ? 14
                                                        : 12,
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
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    width: changeContainerWidth(),
                                    height: size.height * 0.002,
                                    decoration: BoxDecoration(
                                      color: Colors.black38,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    duration:
                                        const Duration(milliseconds: 1000),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                  ),
                                )
                              ],
                            ),
                          ),
                          // if (current == 0)
                          BlocBuilder<OrdersFiltersCubit, OrdersFiltersState>(
                              builder: (context, ordersFilters) {
                            if (ordersFilters is OrdersFiltersLoading) {
                              return Center(
                                child: Column(
                                  children: const [
                                    SizedBox(
                                      height: 200,
                                    ),
                                    CircularProgressIndicator(),
                                  ],
                                ),
                              );
                            } else if (ordersFilters is OrdersFiltersLoaded) {
                              var filtersList = ordersFilters.response?.data;
                              return Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: ListView.builder(
                                      itemCount: filtersList?.length ?? 0,
                                      itemBuilder: (context, index) {
                                        return OrderCard(
                                            orderFilterData:
                                                filtersList![index]);
                                      }),
                                ),
                              );
                            } else if (ordersFilters is OrdersFiltersError) {
                              return const SizedBox();
                            } else {
                              return const SizedBox();
                            }
                          })
                        ],
                      ),
                    );
                  } else if (homeState is OrdersStatusError) {
                    return const SizedBox();
                  } else {
                    return const SizedBox();
                  }
                }))));
  }
}

//import 'dart:async';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../../app/utils/myApplication.dart';
// import '../../../../Data/cubit/orders_cubit/orders_status_cubit/orders_filters_cubit.dart';
// import '../../../../Data/cubit/orders_cubit/orders_status_cubit/orders_filters_state.dart';
// import '../../../../app/constants.dart';
// import '../../../../app/utils/lang/language_constants.dart';
// import '../../../widgets/noInternet.dart';
// import '../../../widgets/shared.dart';
// import 'OrderCard/OrderCard.dart';
//
// class UserOrders extends StatefulWidget {
//   const UserOrders({Key? key}) : super(key: key);
//
//   @override
//   State<UserOrders> createState() => _UserOrdersState();
// }
//
// class _UserOrdersState extends State<UserOrders> {
//   late StreamSubscription<ConnectivityResult> subscription;
//   bool? isConnected;
//
//   final ScrollController _controller = ScrollController();
//   // List<String> tabs = [
//   //   "الكل",
//   //   "الحالية",
//   //   "المكتملة",
//   //   "المرفوضة",
//   //   "المعترضة",
//   //   "المنتهية"
//   // ];
//   int current = 0;
//   bool isScrolling = false;
//
//   void _animateToIndex(int index) {
//     _controller.animateTo(
//       index * MediaQuery.of(context).size.width,
//       duration: const Duration(milliseconds: 500),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   double changePositionedOfLine() {
//     switch (current) {
//       case 0:
//         return MediaQuery.of(context).size.width * 0.85;
//       case 1:
//         return MediaQuery.of(context).size.width * 0.73;
//       case 2:
//         return MediaQuery.of(context).size.width * 0.60;
//       case 3:
//         return MediaQuery.of(context).size.width * 0.45;
//       case 4:
//         return MediaQuery.of(context).size.width * 0.28;
//       case 5:
//         return MediaQuery.of(context).size.width * 0.13;
//       default:
//         return 0;
//     }
//   }
//
//   double changeContainerWidth() {
//     switch (isScrolling) {
//       case true:
//         return 0;
//       case false:
//         return 30;
//       default:
//         return 0;
//     }
//   }
//
//   @override
//   void initState() {
//     MyApplication.checkConnection().then((value) {
//       if (value) {
//       } else {
//         MyApplication.showToastView(
//             message: '${ 'noInternet')}');
//       }
//     });
//
//     subscription = Connectivity()
//         .onConnectivityChanged
//         .listen((ConnectivityResult result) {
//       if (mounted) {
//         setState(() {
//           result == ConnectivityResult.none
//               ? isConnected = false
//               : isConnected = true;
//         });
//       }
//
//       if (result != ConnectivityResult.none) {
//       }
//     });
//
//     context.read<OrdersStatusCubit>().getOrdersStatus();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // todo if not connected display nointernet widget else continue to the rest build code
//     final size = MediaQuery.of(context).size;
//     if (isConnected == null) {
//       MyApplication.checkConnection().then((value) {
//         setState(() {
//           isConnected = value;
//         });
//       });
//     } else if (!isConnected!) {
//       MyApplication.showToastView(
//           message: '${ 'noInternet')}');
//       return NoInternetWidget(size: size);
//     }
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: GestureDetector(
//         onTap: () {
//           MyApplication.dismissKeyboard(context);
//         },
//         child: SafeArea(
//           child: Scaffold(
//               appBar: AppBar(
//                 leadingWidth: 150,
//                 backgroundColor: Colors.transparent,
//                 elevation: 0,
//                 leading: Back(
//                   header: "my_orders",
//                 ),
//               ),
//               body: BlocBuilder<OrdersStatusCubit, OrdersStatusState>(
//                   builder: (context, ordersSState) {
//                 if (ordersSState is OrdersStatusLoading) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 } else if (ordersSState is OrdersStatusLoaded) {
//                   print("ordersSState is ${ordersSState.response!.data}");
//                   final ordersStatusList = ordersSState.response?.data ??[];
//                   return SizedBox(
//                     width: size.width,
//                     height: size.height,
//                     child: Column(
//                       children: [
//                         Container(
//                           margin: const EdgeInsets.only(top: 20),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.1),
//                                 spreadRadius: 5,
//                                 blurRadius: 7,
//                                 offset: const Offset(
//                                     0, 10), // changes position of shadow
//                               ),
//                             ],
//                           ),
//                           width: size.width,
//                           height: size.height * 0.06,
//                           child: Stack(
//                             children: [
//                               Positioned(
//                                 top: 0,
//                                 left: 0,
//                                 right: 0,
//                                 child: SizedBox(
//                                   width: size.width,
//                                   height: size.height * 0.04,
//                                   child:
//                                       NotificationListener<ScrollNotification>(
//                                     onNotification: (ScrollNotification) {
//                                       if (ScrollNotification
//                                           is ScrollEndNotification) {
//                                         setState(() {
//                                           isScrolling = false;
//                                         });
//                                       } else if (ScrollNotification
//                                           is ScrollUpdateNotification) {
//                                         setState(() {
//                                           isScrolling = true;
//                                         });
//                                       }
//                                       return true;
//                                     },
//                                     child: ListView.builder(
//                                         controller: _controller,
//                                         scrollDirection: Axis.horizontal,
//                                         itemCount: ordersStatusList.length,
//                                         itemBuilder: (context, index) {
//                                           return Padding(
//                                             padding: EdgeInsets.symmetric(
//                                               horizontal: index == 0
//                                                   ? MediaQuery.of(context)
//                                                           .size
//                                                           .width *
//                                                       0.05
//                                                   : MediaQuery.of(context)
//                                                           .size
//                                                           .width *
//                                                       0.02,
//                                             ),
//                                             child: GestureDetector(
//                                               onTap: () {
//                                                 setState(() {
//                                                   current = index;
//                                                   index <= 4
//                                                       ? _animateToIndex(0)
//                                                       : null;
//                                                 });
//                                               },
//                                               child: Text(
//                                                 ordersStatusList[index].name??"",
//                                                 style: Constants
//                                                     .subtitleRegularFont
//                                                     .copyWith(
//                                                   fontWeight: current == index
//                                                       ? FontWeight.bold
//                                                       : FontWeight.normal,
//                                                   fontSize: current == index
//                                                       ? 14
//                                                       : 12,
//                                                 ),
//                                               ),
//                                             ),
//                                           );
//                                         }),
//                                   ),
//                                 ),
//                               ),
//                               AnimatedPositioned(
//                                 curve: Curves.fastLinearToSlowEaseIn,
//                                 bottom: 10,
//                                 left: changePositionedOfLine(),
//                                 duration: const Duration(milliseconds: 500),
//                                 child: AnimatedContainer(
//                                   margin: const EdgeInsets.symmetric(
//                                       horizontal: 10),
//                                   width: changeContainerWidth(),
//                                   height: size.height * 0.002,
//                                   decoration: BoxDecoration(
//                                     color: Colors.black38,
//                                     borderRadius: BorderRadius.circular(5),
//                                   ),
//                                   duration: const Duration(milliseconds: 1000),
//                                   curve: Curves.fastLinearToSlowEaseIn,
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         // if (current == 0)
//                           Expanded(
//                             child: Padding(
//                               padding: const EdgeInsets.all(16.0),
//                               child: ListView.builder(
//                                   itemCount: 10,
//                                   itemBuilder: (context, index) {
//                                     return const OrderCard();
//                                   }),
//                             ),
//                           )
//                         // else if (current == 1)
//                         //   Expanded(
//                         //     child: Padding(
//                         //       padding: const EdgeInsets.all(16.0),
//                         //       child: ListView.builder(
//                         //           itemCount: 10,
//                         //           itemBuilder: (context, index) {
//                         //             return const OrderCard();
//                         //           }),
//                         //     ),
//                         //   )
//                         // else if (current == 2)
//                         //   Expanded(
//                         //     child: Padding(
//                         //       padding: const EdgeInsets.all(16.0),
//                         //       child: ListView.builder(
//                         //           itemCount: 10,
//                         //           itemBuilder: (context, index) {
//                         //             return const OrderCard();
//                         //           }),
//                         //     ),
//                         //   )
//                         // else if (current == 3)
//                         //   Expanded(
//                         //     child: Padding(
//                         //       padding: const EdgeInsets.all(16.0),
//                         //       child: ListView.builder(
//                         //           itemCount: 10,
//                         //           itemBuilder: (context, index) {
//                         //             return const OrderCard();
//                         //           }),
//                         //     ),
//                         //   )
//                         // else if (current == 4)
//                         //   Expanded(
//                         //     child: Padding(
//                         //       padding: const EdgeInsets.all(16.0),
//                         //       child: ListView.builder(
//                         //           itemCount: 10,
//                         //           itemBuilder: (context, index) {
//                         //             return const OrderCard();
//                         //           }),
//                         //     ),
//                         //   )
//                         // else if (current == 5)
//                         //   Expanded(
//                         //     child: Padding(
//                         //       padding: const EdgeInsets.all(16.0),
//                         //       child: ListView.builder(
//                         //           itemCount: 10,
//                         //           itemBuilder: (context, index) {
//                         //             return const OrderCard();
//                         //           }),
//                         //     ),
//                         //   )
//                       ],
//                     ),
//                   );
//                 } else if (ordersSState is OrdersStatusError) {
//                   return const SizedBox();
//                 } else {
//                   return const SizedBox();
//                 }
//               })),
//         ),
//       ),
//     );
//   }
// }
