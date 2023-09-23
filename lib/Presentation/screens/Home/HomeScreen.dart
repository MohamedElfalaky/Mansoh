import 'dart:async';

// import 'package:badges/badges.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nasooh/Data/cubit/home/advisor_state.dart';
import 'package:nasooh/Presentation/screens/Advisor/AdvisorScreen.dart';
import 'package:nasooh/Presentation/screens/Home/Components/AdvisorCard.dart';
import 'package:nasooh/Presentation/screens/Home/controller/HomeController.dart';
import 'package:nasooh/Presentation/widgets/noInternet.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/myApplication.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../Data/cubit/authentication/category_cubit/category_cubit.dart';
import '../../../Data/cubit/authentication/category_cubit/category_state.dart';
import '../../../Data/cubit/home/advisor_list_cubit.dart';
import '../../../Data/cubit/home/home_slider_cubit.dart';
import '../../../Data/cubit/home/home_state.dart';
import '../FilterScreen/FilterScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = HomeController();
  late StreamSubscription<ConnectivityResult> subscription;
  bool? isConnected;
  final controller = PageController(initialPage: 0);
  int _currentPage = 0;
  Timer? _timer;

// bool select = false ;

  Future<void> getDataFromApi() async {
    await context.read<CategoryCubit>().getCategories();
    var profileCubit = CategoryCubit.get(context);
    // select = profileCubit.categoryModel?.data?[0].selected??true;
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
///////////////////////////
    MyApplication.checkConnection().then((value) {
      if (value) {
        //////
        // todo recall data
        ///
        ///
        ///
        ///
      } else {
        MyApplication.showToastView(message: '${'noInternet'.tr}');
      }
    });

    // todo subscribe to internet change
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

      /// if internet comes back
      if (result != ConnectivityResult.none) {
        /// call your apis
        // todo recall data
        ///
        ///
        ///
        ///
      }
    });
    context.read<HomeSliderCubit>().getDataHomeSlider();
    context.read<AdvisorListCubit>().getAdvisorList();
    getDataFromApi();
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
    _timer!.cancel();
    homeController.categories.forEach((element) {
      element["isSelected"] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // todo if not connected display nointernet widget else continue to the rest build code
    final sizee = MediaQuery.of(context).size;
    if (isConnected == null) {
      MyApplication.checkConnection().then((value) {
        setState(() {
          isConnected = value;
        });
      });
    } else if (!isConnected!) {
      MyApplication.showToastView(message: '${'noInternet'.tr}');
      return NoInternetWidget(size: sizee);
    }

    return GestureDetector(
        onTap: () {
          MyApplication.dismissKeyboard(context);
        }, // hide keyboard on tap anywhere

        child: Scaffold(
          backgroundColor: Constants.whiteAppColor,
          body: BlocBuilder<HomeSliderCubit, HomeState>(
              builder: (context, homeState) {
            if (homeState is HomeSliderLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (homeState is HomeSliderLoaded) {
              return Container(
                  color: Constants.whiteAppColor,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  margin: const EdgeInsets.only(left: 16, right: 16, top: 35),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Badge(
                            backgroundColor: Constants.primaryAppColor,
                            // borderSide: const BorderSide(color: Colors.white),
                            alignment: const AlignmentDirectional(0, -7),
                            label: const Text("2"),
                            // position: BadgePosition.topStart(top: -7, start: 0),
                            // badgeContent: const Text(
                            //   "9+",
                            //   style: TextStyle(
                            //       fontSize: 8, color: Constants.whiteAppColor),
                            //   // context.watch<CartItemsCubit>().cartLength ?? "",
                            //   // style: const TextStyle(color: Colors.white),
                            // ),
                            child: Card(
                              child: SizedBox(
                                height: 40,
                                width: 40,
                                child: Center(
                                  child: SvgPicture.asset(
                                    notificationIcon,
                                    height: 25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Image.asset(
                            logo,
                            height: 55,
                            width: 55,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextField(
                        decoration: Constants.setTextInputDecoration(
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: SvgPicture.asset(
                                searchIcon,
                              ),
                            ),
                            isSuffix: true,
                            suffixIcon: InkWell(
                             onTap: (){
                               MyApplication.navigateTo(context, FilterScreen());
                             }, child: Container(
                                padding: const EdgeInsets.all(8.0),
                                // margin: const EdgeInsets.all(2.0),
                                color: Constants.primaryAppColor.withOpacity(0.2),
                                child: SvgPicture.asset(
                                  filterIcon,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            hintText: "ابحث باسم الناصح أو التخصص ...."),
                      ),
                      const SizedBox(
                        height: 16,
                      ),

                      ///
                      ///
                      ///
                      //////////////////// Slider
                      ///
                      ///
                      ///
                      Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [
                              Constants.primaryAppColor,
                              Constants.whiteAppColor,
                            ], stops: [
                              0,
                              0.6
                            ]),
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(0, 6),
                                  blurRadius: 10,
                                  spreadRadius: -5,
                                  blurStyle: BlurStyle.normal,
                                  color: const Color(0XFF5C5E6B1A)
                                      .withOpacity(0.1)),
                            ],
                            borderRadius: BorderRadius.circular(5)),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            PageView(
                                controller: controller,
                                children: homeState.response!.data!
                                    .map((e) =>
                                        homeController.pageViewItem(e.image!))
                                    .toList()),
                            SizedBox(
                              height: 20,
                              width: 70,
                              child: Center(
                                child: SmoothPageIndicator(
                                  onDotClicked: (index) {
                                    if (_currentPage < 2) {
                                      _currentPage++;
                                    } else {
                                      _currentPage = 0;
                                    }

                                    controller.animateToPage(
                                      _currentPage,
                                      duration:
                                          const Duration(milliseconds: 350),
                                      curve: Curves.easeIn,
                                    );
                                  },
                                  controller: controller,
                                  count: homeState.response!.data!.length,
                                  effect: ExpandingDotsEffect(
                                      activeDotColor: Constants.primaryAppColor,
                                      dotColor: Constants.primaryAppColor
                                          .withOpacity(0.2),
                                      spacing: 5,
                                      dotWidth: 8,
                                      dotHeight: 4),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),

                      ///
                      ///
                      ///
                      ///
                      ///////////////////// Filter bar
                      BlocBuilder<CategoryCubit, CategoryState>(
                          builder: (context, categoryState) {
                        if (categoryState is CategoryLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (categoryState is CategoryLoaded) {
                          final catList = categoryState.response?.data ?? [];
                          return Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(top: 8),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                    // scrollDirection: Axis.horizontal,
                                    children: catList
                                        .map(
                                          (e) => InkWell(
                                            onTap: () {
                                              setState(() {
                                                catList.forEach((element) {
                                                  element.selected = false;
                                                });
                                                e.selected = true;
                                              });
                                            },
                                            child: Container(
                                                margin: const EdgeInsets.only(
                                                    left: 16),
                                                child: Text(
                                                  e.name ?? '',
                                                  style: e.selected == true
                                                      ? const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily: Constants
                                                              .mainFont,
                                                          fontSize: 16)
                                                      : const TextStyle(
                                                          fontFamily: Constants
                                                              .mainFont),
                                                )),
                                          ),
                                        )
                                        .toList()),
                              ));
                        } else if (categoryState is CategoryError) {
                          return const SizedBox();
                        } else {
                          return const SizedBox();
                        }
                      }),

                      ///
                      ///
                      ///
                      /////////////////////////////// Advisor Card
                      ///
                      ///
                      ///

                      // SizedBox(
                      //   height: 8,
                      // ),
                      BlocBuilder<AdvisorListCubit, AdvisorState>(
                          builder: (context, advisorState) {
                        if (advisorState is AdvisorListLoading) {
                          return Center(
                            child: Column(
                              children: const [
                                SizedBox(
                                  height: 120,
                                ),
                                CircularProgressIndicator(),
                              ],
                            ),
                          );
                        } else if (advisorState is AdvisorListLoaded) {
                          return Expanded(
                            child: ListView.builder(
                              // shrinkWrap: true,
                              // physics: BouncingScrollPhysics(),
                              itemCount:
                                  advisorState.adListResponse?.data?.length ??
                                      0,
                              itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    MyApplication.navigateTo(
                                        context,
                                        AdvisorScreen(
                                            id: advisorState.adListResponse!
                                                .data![index].id!));
                                  },
                                  child: AdvisorCard(
                                    adviserData: advisorState
                                        .adListResponse!.data![index],
                                  )),
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      })
                    ],
                  ));
            } else if (homeState is HomeSliderError) {
              return const SizedBox();
            } else {
              return const SizedBox();
            }
          }),
        ));
  }
}
