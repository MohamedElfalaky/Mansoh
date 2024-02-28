import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nasooh/Presentation/widgets/my_button.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/my_application.dart';
import '../../../Data/cubit/authentication/category_cubit/category_cubit.dart';
import '../../../Data/cubit/authentication/category_cubit/category_state.dart';
import '../../../Data/cubit/home/advisor_list_cubit.dart';
import '../../../Data/models/Auth_models/category_model.dart';
import '../../../app/Style/icons.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key, this.searchTxt});
  final String? searchTxt;

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  Set<CategoryData> selectedItems = {};
  bool textFieldPressed = true;
  double initialRate = 0;
  List<CategoryData> catList = [];
  @override
  void initState() {
    super.initState();

    context.read<CategoryCubit>().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MyApplication.dismissKeyboard(context);
      },
      child: Scaffold(
        appBar: customAppBar(
            txt: 'تصفية',
            context: context,
            endIcon: true,
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black38)),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        initialRate = 0;

                        selectedItems.clear();

                        catList.map((e) {
                          e.children!.map((e) => e.selected = false).toList();
                          return e.selected = false;
                        }).toList();
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("مسح",
                            style: Constants.secondaryTitleRegularFont),
                        const SizedBox(width: 4),
                        SvgPicture.asset(recycleIcon),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
        body: BlocBuilder<CategoryCubit, CategoryState>(
            builder: (context, state) {
          if (state is CategoryLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state is CategoryLoaded) {
            catList = state.response?.data ?? [];
            return SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text("المجالات", style: Constants.mainTitleFont),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 6),
                    child: Text("جميع المجالات",
                        style: Constants.secondaryTitleRegularFont),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        textFieldPressed = !textFieldPressed;
                      });
                    },
                    child: TextField(
                      enabled: false,
                      decoration: Constants.setTextInputDecoration(
                          prefixIcon: const MyPrefixWidget(
                            svgString: categoriesIcon,
                          ),
                          isSuffix: true,
                          suffixIcon:
                              const Icon(Icons.keyboard_arrow_down_sharp),
                          hintText: "اختر المجال أو التخصص..."),
                    ),
                  ),
                  if (textFieldPressed)
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade200)),
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ListView.builder(
                            itemCount: catList.length,
                            itemBuilder: (context, int index) => ExpansionTile(
                                tilePadding: const EdgeInsets.all(0),
                                title: Row(
                                  children: [
                                    SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: Checkbox(
                                            side: MaterialStateBorderSide
                                                .resolveWith(
                                              (states) => const BorderSide(
                                                  width: 1.0,
                                                  color: Constants
                                                      .primaryAppColor),
                                            ),
                                            value: catList[index].selected,
                                            onChanged: (bool? s) {
                                              setState(() {
                                                catList[index].selected = s;
                                                if (catList[index].selected ==
                                                    true) {
                                                  catList[index]
                                                      .children
                                                      ?.map((e) {
                                                    selectedItems.add(e);
                                                    e.selected = true;
                                                  }).toList();
                                                } else {
                                                  catList[index]
                                                      .children
                                                      ?.map((e) {
                                                    selectedItems.remove(e);
                                                    e.selected = false;
                                                  }).toList();
                                                }
                                              });
                                            })),
                                    const SizedBox(width: 4),
                                    Expanded(
                                        child: Text(catList[index].name!,
                                            style:
                                                Constants.secondaryTitleFont)),
                                  ],
                                ),
                                children: catList[index]
                                    .children!
                                    .map((e) => Padding(
                                          padding:
                                              const EdgeInsetsDirectional.only(
                                                  start: 12,
                                                  end: 4,
                                                  top: 4,
                                                  bottom: 4),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                  height: 24,
                                                  width: 24,
                                                  child: Checkbox(
                                                      value:
                                                          e.selected == true ||
                                                              selectedItems
                                                                  .contains(e),
                                                      side: MaterialStateBorderSide
                                                          .resolveWith((states) =>
                                                              const BorderSide(
                                                                  width: 1,
                                                                  color: Constants
                                                                      .primaryAppColor)),
                                                      onChanged: (s) {
                                                        setState(() {
                                                          e.selected = s;
                                                          if (e.selected ==
                                                              true) {
                                                            selectedItems
                                                                .add(e);
                                                          } else {
                                                            selectedItems
                                                                .remove(e);
                                                          }
                                                        });
                                                      })),
                                              const SizedBox(width: 8),
                                              Text(
                                                e.name!,
                                                style: Constants
                                                    .secondaryTitleRegularFont,
                                              ),
                                            ],
                                          ),
                                        ))
                                    .toList())))
                  else
                    SizedBox(height: 250),
                  SizedBox(
                    height: 290,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Wrap(
                        children: selectedItems
                            .toSet()
                            .map((e) => Container(
                                  margin: const EdgeInsetsDirectional.only(
                                      end: 10, bottom: 8, top: 10),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  decoration: BoxDecoration(
                                      color: const Color(0XFFEEEEEE),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        e.name!,
                                        style: const TextStyle(
                                            fontFamily: Constants.mainFont,
                                            fontSize: 10),
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        height: 14,
                                        width: 14,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: Border.all(
                                                color:
                                                    const Color(0XFF5C5E6B))),
                                        child: Center(
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedItems.remove(e);
                                              });
                                            },
                                            child: const Icon(
                                              Icons.close_outlined,
                                              size: 12,
                                              color: Color(0XFF5C5E6B),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        }),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("التقييم", style: Constants.mainTitleFont),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: RatingBar.builder(
                  initialRating: initialRate,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 40.0,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    initialRate = rating;
                  },
                ),
              ),
              MyButton(
                onPressedHandler: ()   {
                  List<String?> idList = selectedItems
                      .map((category) => category.id.toString())
                      .toList();
                  String idString = idList.join(', ');
                  context
                      .read<AdvisorListCubit>()
                      .getAdvisorList(
                          categoryValue: idString,
                          searchTxt: widget.searchTxt,
                          rateVal: initialRate,

                  )
                      .then((value) => {Navigator.pop(context)});
                },
                txt: "تصفية",
                isBold: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
