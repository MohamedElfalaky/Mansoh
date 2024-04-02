import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/Presentation/widgets/my_button.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import 'package:nasooh/app/Style/icons.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/my_application.dart';
import 'package:readmore/readmore.dart';

import '../../../Data/cubit/advisor_profile_cubit/profile_cubit.dart';
import '../../../Data/cubit/advisor_profile_cubit/profile_state.dart';
import '../ConfirmAdviseScreen/confirm_advise_screen.dart';

class AdvisorScreen extends StatefulWidget {
  const AdvisorScreen({super.key, required this.id});

  final int id;

  @override
  State<AdvisorScreen> createState() => _AdvisorScreenState();
}

class _AdvisorScreenState extends State<AdvisorScreen> {
  @override
  void initState() {
    super.initState();

    context.read<AdvisorProfileCubit>().getDataAdvisorProfile(widget.id);
  }

  bool isReadmore=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AdvisorProfileCubit, AdvisorProfileState>(
        builder: (context, state) {
          if (state is AdvisorProfileLoaded) {
            final allData = state.response!.data!;
            return Scaffold(
              appBar: customAppBar(
                  txt: "الصفحة الشخصية",
                  context: context,
                ),
              backgroundColor: Constants.whiteAppColor,
              body: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                children: [
                  Center(
                    child: Container(
                      width: 138,
                      height: 138,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                              width: 2, color: const Color(0xFF0076FF))),
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: allData.avatar == ""
                              ? Image.asset(
                                  'assets/images/PNG/no_profile_photo.png',
                                  height: 130,
                                  width: 130,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  allData.avatar!,
                                  height: 130,
                                  width: 130,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8,bottom: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          allData.fullName!,
                          style: Constants.secondaryTitleFont,
                        ),
                        SvgPicture.asset(
                          advisorIcon,
                          width: 18,
                        )
                      ],
                    ),
                  ),
                  Center(
                    child: Text(
                      allData.description??"لا يوجد وصف لهذا الناصح",
                      style: Constants.subtitleFont,
                    ),
                  ),
                  Container(
                    height: 30,
                    margin: const EdgeInsets.only(top: 10),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        margin:
                        const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                            color: Constants.primaryAppColor,
                            borderRadius: BorderRadius.circular(2)),
                        child: Center(
                            child: Text(
                              // "محامي عام",
                              allData.category?[index].name ?? "",
                              style: const TextStyle(
                                  fontFamily: Constants.mainFont,
                                  color: Constants.whiteAppColor,
                                  fontSize: 11),
                            )),
                      ),
                      itemCount: allData.category?.length ?? 0,
                    ),
                  ),
                  SizedBox(
                    height: !isReadmore?200:100,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16),
                        child: ReadMoreText(
                          callback: (v){
                            isReadmore=v;
                            setState(() {

                            });
                          },
                          allData.info!,
                          style: Constants.subtitleFont1,
                          trimLines: 2,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'المزيد',
                          trimExpandedText: '\nأقل',
                          moreStyle: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Constants.primaryAppColor),
                          lessStyle: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Constants.primaryAppColor),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin:
                    const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.only(bottom: 20),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1, color: Color(0XFFBCBCC4)))),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8),
                                  child: SvgPicture.asset(
                                    adviceQ,
                                    height: 20,
                                  )),
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: allData.adviceCount
                                        .toString(),
                                    style: Constants.subtitleFontBold,
                                  ),
                                  const TextSpan(
                                    text: " نصيحة",
                                    style: Constants.subtitleFont,
                                  )
                                ]),
                              )
                            ],
                          ),
                          const VerticalDivider(
                            color: Color(0XFFBCBCC4),
                            width: 1,
                            thickness: 1,
                          ),
                          Column(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8),
                                  child: SvgPicture.asset(
                                    rateIcon,
                                    height: 20,
                                  )),
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: allData.rate,
                                    style: Constants.subtitleFontBold,
                                  ),
                                  const TextSpan(
                                    text: " تقييم",
                                    style: Constants.subtitleFont,
                                  )
                                ]),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, right: 16, left: 16),
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 8),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  experienceIcon,
                                  height: 26,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Text(
                                  "سنوات الخبرة",
                                  style: Constants.secondaryTitleFont,
                                ),
                                const Spacer(),
                                Text(
                                  "${allData.experienceYear!} سنوات ",
                                  style: Constants.subtitleFont,
                                )
                              ],
                            ),
                            const Center(
                              child: SizedBox(
                                width: 150,
                                child: Divider(
                                  thickness: 1,
                                  color: Color(0XFFEDEDED),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  documentsIcon,
                                  height: 24,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Text(
                                  "الشهادات والإنجازات",
                                  style: Constants.secondaryTitleFont,
                                ),
                              ],
                            ),
                            Wrap(
                              children: List.generate(
                                  allData.document?.length ?? 0,
                                      (index) => Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15),
                                      child: Container(
                                        padding: const EdgeInsets
                                            .symmetric(
                                            horizontal: 8,
                                            vertical: 5),
                                        margin: const EdgeInsets
                                            .symmetric(horizontal: 4),
                                        decoration: BoxDecoration(
                                            color: const Color(
                                                0XFFEEEEEE),
                                            borderRadius:
                                            BorderRadius.circular(
                                                2)),
                                        child: Text(
                                          allData.document![index]
                                              .value ??
                                              "",
                                          style: const TextStyle(
                                              fontFamily:
                                              Constants.mainFont,
                                              color: Colors.black,
                                              fontSize: 10),
                                        ),
                                      ))),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60)
                ],
              ),
              bottomNavigationBar: Container(
                  margin:
                      const EdgeInsets.only(bottom:40, left: 20, right: 20),
                  height: 50,
                  child: CustomElevatedButton(
                    onPressedHandler: () {
                      MyApplication.navigateToReplace(context,
                          ConfirmAdviseScreen(adviserProfileData: allData));
                    },
                    txt: "طلب نصيحة",
                    isBold: true,
                  )),
            );
          }
          else if(state is AdvisorProfileLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          return const SizedBox.shrink();
        },

      ),
    );
  }
}
