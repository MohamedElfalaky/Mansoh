import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nasooh/app/constants.dart';

import '../../../Data/cubit/settings_cubits/privacy_cubit/privacy_cubit.dart';
import '../../../Data/cubit/settings_cubits/privacy_cubit/privacy_state.dart';
// import '../../../app/Style/icons.dart';
import '../../../app/style/icons.dart';
import '../../widgets/shared.dart';

class TermsConditionsScreen extends StatefulWidget {
  const TermsConditionsScreen({super.key});

  @override
  State<TermsConditionsScreen> createState() => _TermsConditionsScreenState();
}

class _TermsConditionsScreenState extends State<TermsConditionsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PrivacyCubit>().getPrivacy();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Constants.whiteAppColor,
      appBar: customAppBar(context: context, txt: "terms_conditions".tr),
      body: BlocBuilder<PrivacyCubit, PrivacyState>(
          builder: (context, privacyState) {
        if (privacyState is PrivacyLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (privacyState is PrivacyLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        termsConditions,
                        height: 40,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "الشروط والأحكام",
                            style: Constants.mainTitleFont,
                          ),
                          // ignore: prefer_const_constructors
                          Text(
                            "آخر تحديث 12-10-2022",
                            style: Constants.subtitleRegularFont,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                  child: ListView(
                    children: [
                      Text(
                        privacyState.response?.data?.description ?? "",
                        style: Constants.subtitleRegularFont,
                      )
                    ],
                  ),
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    // !_checked
                    //     ? InkWell(
                    //   onTap: () {
                    //     setState(() {
                    //       _checked = !_checked;
                    //     });
                    //   },
                    //   child: Container(
                    //     width: 22,
                    //     height: 22,
                    //     decoration: BoxDecoration(
                    //         shape: BoxShape.circle,
                    //         border: Border.all(
                    //             color: Colors.black, width: 1.4)),
                    //   ),
                    // )
                    //     :
                    InkWell(
                      onTap: () {
                        // setState(() {
                        //   _checked = !_checked;
                        // });
                      },
                      child: SvgPicture.asset(
                        checkIcon,
                        width: 24,
                        height: 24,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text("اوافق علي جميع الشروط والأحكام"),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    // !_privacy
                    //     ? InkWell(
                    //   onTap: () {
                    //     setState(() {
                    //       _privacy = !_privacy;
                    //     });
                    //   },
                    //   child: Container(
                    //     width: 22,
                    //     height: 22,
                    //     decoration: BoxDecoration(
                    //         shape: BoxShape.circle,
                    //         border: Border.all(
                    //             color: Colors.black, width: 1.4)),
                    //   ),
                    // )
                    //     :
                    InkWell(
                      onTap: () {
                        // setState(() {
                        //   _privacy = !_privacy;
                        // });
                      },
                      child: SvgPicture.asset(
                        checkIcon,
                        width: 24,
                        height: 24,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "اوافق علي سياسة الخصوصية",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                )
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      }),
    );
  }
}
