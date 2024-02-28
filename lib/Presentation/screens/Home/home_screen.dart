import 'dart:async';

// import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/Data/cubit/home/advisor_state.dart';
import 'package:nasooh/Data/models/category_parent_model.dart';
import 'package:nasooh/Presentation/screens/Advisor/advisor_screen.dart';
import 'package:nasooh/Presentation/screens/Home/Components/advisor_card.dart';
import 'package:nasooh/Presentation/screens/Home/controller/home_controller.dart';
import 'package:nasooh/app/Style/icons.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/my_application.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../Data/cubit/authentication/category_parent_cubit/category_parent_cubit.dart';
import '../../../Data/cubit/authentication/category_parent_cubit/category_parent_state.dart';
import '../../../Data/cubit/home/advisor_list_cubit.dart';
import '../../../Data/cubit/home/home_slider_cubit.dart';
import '../../../Data/cubit/home/home_state.dart';
import '../FilterScreen/filter_screen.dart';
import '../UserProfileScreens/UserNotifications/user_notifications.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.catVal, this.rateVal});

  final String? catVal;
  final double? rateVal;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = HomeController();
  final TextEditingController searchController = TextEditingController();
  late PageController controller;
  int _currentPage = 0;
  int selectedCategoryId = 0;
  int? selectedSubCategory;

  late AdvisorListCubit advisorListCubit;

  Future<void> getDataFromApi() async {
    await context.read<CategoryParentCubit>().getCategoryParent();
  }

  @override
  void initState() {
    controller = PageController(initialPage: 0);
    super.initState();
    context.read<HomeSliderCubit>().getDataHomeSlider();
    advisorListCubit = context.read<AdvisorListCubit>();

    advisorListCubit.getAdvisorList(
      categoryValue: widget.catVal,
      rateVal: widget.rateVal,
    );
    getDataFromApi();
  }

  @override
  void dispose() {
    super.dispose();
    for (var element in homeController.categories) {
      element["isSelected"] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          MyApplication.dismissKeyboard(context);
        },
        child: Scaffold(
          backgroundColor: Constants.whiteAppColor,
          body: BlocBuilder<HomeSliderCubit, HomeState>(
              builder: (context, homeState) {
            if (homeState is HomeSliderLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
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
                          InkWell(
                            onTap: () => MyApplication.navigateTo(
                                context, const UserNotifications()),
                            child: Badge(
                              backgroundColor: Constants.primaryAppColor,
                              alignment: const AlignmentDirectional(0, -7),
                              label: const Text("2"),
                              child: Card(
                                child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: Center(
                                    child: SvgPicture.asset(notificationIcon,
                                        height: 25),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Image.asset(logo,
                              height: 55, width: 55, fit: BoxFit.cover),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: searchController,
                        onSubmitted: (val) {
                          context.read<AdvisorListCubit>().getAdvisorList(
                                categoryValue: widget.catVal,
                                searchTxt: searchController.text,
                                rateVal: widget.rateVal,
                              );
                        },
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
                              onTap: () {
                                MyApplication.navigateTo(
                                    context,
                                    FilterScreen(
                                        searchTxt: searchController.text));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                // margin: const EdgeInsets.all(2.0),
                                color:
                                    Constants.primaryAppColor.withOpacity(0.2),
                                child: SvgPicture.asset(
                                  filterIcon,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            hintText: "ابحث باسم الناصح أو التخصص ...."),
                      ),
                      const SizedBox(height: 16),
                      if (homeState.response?.data?.isEmpty == false)
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
                                    color: Colors.black45.withOpacity(0.1)),
                              ],
                              borderRadius: BorderRadius.circular(5)),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              PageView(
                                  controller: controller,
                                  children: homeState.response!.data!
                                      .map((e) => homeController.pageViewItem(e
                                              .image ??
                                          "https://w7.pngwing.com/pngs/895/199/png-transparent-spider-man-heroes-download-with-transparent-background-free-thumbnail.png"))
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
                                    count:
                                        homeState.response?.data?.length ?? 0,
                                    effect: ExpandingDotsEffect(
                                        activeDotColor:
                                            Constants.primaryAppColor,
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
                      const SizedBox(height: 8),
                      BlocBuilder<CategoryParentCubit, CategoryParentState>(
                          builder: (context, categoryState) {
                        if (categoryState is CategoryParentLoading) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        } else if (categoryState is CategoryParentLoaded) {
                          List<CategoryParentData> catList =
                              categoryState.response?.data ?? [];
                          return Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(top: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 30,
                                    child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        children: catList
                                            .map(
                                              (e) => InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    selectedCategoryId = e.id!;
                                                    debugPrint(
                                                        'cat id $selectedCategoryId');
                                                    for (var element
                                                        in catList) {
                                                      element.selected = false;
                                                    }
                                                    e.selected = true;
                                                    if (e.id == 0) {
                                                      advisorListCubit
                                                          .getAdvisorList();
                                                    } else {
                                                      advisorListCubit.getAdvisorList(
                                                          categoryValue:
                                                              '$selectedCategoryId',
                                                          searchTxt:
                                                              searchController
                                                                  .text,
                                                          rateVal:
                                                              widget.rateVal);
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 16),
                                                    child: Text(
                                                      e.name ?? '',
                                                      style: e.selected == true
                                                          ? const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  Constants
                                                                      .mainFont,
                                                              fontSize: 16)
                                                          : const TextStyle(
                                                              fontFamily:
                                                                  Constants
                                                                      .mainFont),
                                                    )),
                                              ),
                                            )
                                            .toList()),
                                  ),
                                  const SizedBox(height: 5),
                                  SizedBox(
                                    height: 40,
                                    child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        children: catList.map((e) {
                                          if (e.id == selectedCategoryId) {
                                            return Row(
                                                children: e.children!
                                                    .map((e) => Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      4),
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 3),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                              border: Border.all(
                                                                  width: 1.5,
                                                                  color: selectedSubCategory ==
                                                                          e.id
                                                                      ? Colors
                                                                          .blueAccent
                                                                      : Colors
                                                                          .black38)),
                                                          child: InkWell(
                                                            onTap: () {
                                                              debugPrint(
                                                                  'sub category ${e.id}');
                                                              debugPrint(
                                                                  'sub category ${e.name}');
                                                              selectedSubCategory =
                                                                  e.id;
                                                              setState(() {});

                                                              context
                                                                  .read<
                                                                      AdvisorListCubit>()
                                                                  .getAdvisorList(
                                                                      categoryValue:
                                                                          '$selectedSubCategory');
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8.0),
                                                              child: Text(
                                                                e.name!,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: e.id ==
                                                                          selectedSubCategory
                                                                      ? 14
                                                                      : 12,
                                                                  fontWeight: e
                                                                              .id ==
                                                                          selectedSubCategory
                                                                      ? FontWeight
                                                                          .bold
                                                                      : FontWeight
                                                                          .w400,
                                                                  fontFamily:
                                                                      Constants
                                                                          .mainFont,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ))
                                                    .toList());
                                          }
                                          return const SizedBox.shrink();
                                        }).toList()),
                                  )
                                ],
                              ));
                        }
                        return const SizedBox.shrink();
                      }),
                      BlocBuilder<AdvisorListCubit, AdvisorState>(
                          builder: (context, advisorState) {
                        if (advisorState is AdvisorListLoading) {
                          return const Center(
                            child: Column(
                              children: [
                                SizedBox(height: 120),
                                CircularProgressIndicator.adaptive(),
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
                        }
                        return const SizedBox.shrink();
                      })
                    ],
                  ));
            }
            return const SizedBox.shrink();
          }),
        ));
  }
}
