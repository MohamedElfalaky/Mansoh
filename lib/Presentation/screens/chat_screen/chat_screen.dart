import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import 'package:nasooh/Presentation/widgets/MyButton.dart';
import 'package:nasooh/Presentation/widgets/noInternet.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/myApplication.dart';
import '../../../Data/cubit/send_advice_cubit/send_advise_cubit.dart';
import '../../../Data/cubit/send_advice_cubit/send_advise_state.dart';
import '../../../Data/models/advisor_profile_model/advisor_profile.dart';
import '../../../app/Style/Icons.dart';
import '../Advisor/AdvisorScreen.dart';
import '../CompleteAdviseScreen/CompleteAdviseScreen.dart';
import '../ConfirmAdviseScreen/Components/OutlinedAdvisorCard.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.adviserProfileData});

  final AdviserProfileData adviserProfileData;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController requestTitle = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // AdvisorController AdvisorController = AdvisorController();
  late StreamSubscription<ConnectivityResult> _subscription;
  String? fileSelected;
  bool? isConnected;
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

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
    _subscription = Connectivity()
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
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
    _focusNode.dispose();
    _subscription.cancel();
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
          appBar: customAppBar(
              txt: 'محادثة الناصح',
              context: context,
              endIcon: true,
              actions: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/SVGs/home_icon.svg',
                          width: 22,
                          height: 22,
                        ),
                        const SizedBox(
                          width: 25,
                        )
                      ],
                    ),
                  ],
                )
              ]),
          body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: OutlinedAdvisorCard(
                        adviserProfileData: widget.adviserProfileData,
                        isClickable: true,
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) => Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(8),
                        // constraints: BoxConstraints(mi),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 185, 184, 180)
                                .withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20)),
                        child: const Text(
                          "تفاصيل النصيحة هناك حقيقة مثبتة منذ زمن ط ويل وهي أن المقروء لصفحة ما  سيلهي القارئ عن التركيز على الشكل الخارجهناك حقيقة مثبتة منذ زمن ط ويل وهي أن المحتوىالمقروء لصفحة ما  سيلهي القارئ عن التركيز على الشكل الخارج  ",
                          style: Constants.subtitleFont,
                        ),
                      ),
                    )),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _textController,
                              focusNode: _focusNode,
                              decoration: Constants.setTextInputDecoration(
                                isSuffix: true,
                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(attachFiles),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    SvgPicture.asset(micee),
                                    const SizedBox(
                                      width: 8,
                                    )
                                  ],
                                ),
                                hintText: "آكتب رسالتك...",
                              ).copyWith(
                                hintStyle: Constants.subtitleRegularFontHint
                                    .copyWith(color: const Color(0XFF5C5E6B)),
                                enabledBorder: const OutlineInputBorder(
                                  gapPadding: 0,
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                                filled: true,
                                fillColor: const Color(0xffF5F4F5),
                              ),
                            ),
                          ),
                          Container(
                              margin: const EdgeInsetsDirectional.only(start: 8),
                              padding: const EdgeInsets.all(10),
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color(0XFF273043)),
                              child: SvgPicture.asset(
                                sendChat,
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }
}
