import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/Data/cubit/home/advisor_state.dart';
import 'package:nasooh/Data/models/category_parent_model.dart';
import 'package:nasooh/Presentation/screens/Advisor/advisor_screen.dart';
import 'package:nasooh/Presentation/screens/Home/Components/advisor_card.dart';
import 'package:nasooh/app/Style/icons.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/my_application.dart';
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
  final dynamic rateVal;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  int selectedCategoryId = 0;
  int? selectedSubCategory;

  late AdvisorListCubit advisorListCubit;

  @override
  void initState() {
    super.initState();
    advisorListCubit = context.read<AdvisorListCubit>();

    context.read<HomeSliderCubit>().getDataHomeSlider();

    advisorListCubit.getAdvisorList(
        categoryValue: widget.catVal, rateVal: widget.rateVal);
    context.read<CategoryParentCubit>().getCategoryParent();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          MyApplication.dismissKeyboard(context);
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: false,
          extendBodyBehindAppBar: false,
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
                  margin: const EdgeInsets.only(left: 16, right: 16, top: 50),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 16,bottom: 8),
                        child: TextField(
                          controller: searchController,
                          onSubmitted: (val) {
                            context.read<AdvisorListCubit>().getAdvisorList(
                                  categoryValue: widget.catVal,
                                  searchTxt: searchController.text,
                                  rateVal: widget.rateVal,
                                );
                          },
                          decoration: Constants.setTextInputDecoration(
                            hintColor: const Color(0xff5C5E6B),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: SvgPicture.asset(searchIcon),
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
                                decoration: BoxDecoration(
                                    color: Constants.primaryAppColor
                                        .withOpacity(0.2),
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                    )),
                                child: SvgPicture.asset(
                                  filterIcon,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            hintText: "ابحث باسم الناصح أو التخصص ....",
                          ),
                        ),
                      ),

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
                                              ))
                                            .toList()),
                                  ),
                                  const SizedBox(height: 5),
                                  SizedBox(
                                    height: selectedCategoryId==0?0:40,
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
                        } else if (advisorState is AdvisorListEmpty) {
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
                        } else if (advisorState is AdvisorListLoaded) {
                          return Flexible(
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
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
