import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nasooh/Data/cubit/send_chat_cubit/send_chat_cubit.dart';
import 'package:nasooh/Data/cubit/send_chat_cubit/send_chat_state.dart';
import 'package:nasooh/Data/cubit/show_advice_cubit/show_advice_cubit/show_advice_cubit.dart';
import 'package:nasooh/Data/cubit/show_advice_cubit/show_advice_cubit/show_advice_state.dart';
import 'package:nasooh/Presentation/widgets/noInternet.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/myApplication.dart';

import '../../../Data/models/advice_screen_models/show_advice_model.dart';
import '../../../app/Style/Icons.dart';
import '../ConfirmAdviseScreen/Components/OutlinedAdvisorCard.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.showAdviceData});

  final ShowAdviceData showAdviceData;

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
        context
            .read<ShowAdviceCubit>()
            .getAdviceFunction(adviceId: widget.showAdviceData.id!);
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
        context
            .read<ShowAdviceCubit>()
            .getAdviceFunction(adviceId: widget.showAdviceData.id!);

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
    _textController.clear();
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

      child: MultiBlocListener(
        listeners: [
          BlocListener<SendChatCubit, SendChatState>(
            listener: (context, state) {
              // TODO: implement listener

              if (state is SendChatLoaded) {
                context
                    .read<ShowAdviceCubit>()
                    .getAdviceFunction(adviceId: widget.showAdviceData.id!);
              }
            },
          ),
          BlocListener<ShowAdviceCubit, ShowAdviceState>(
            listener: (context, state) {
              if (state is ShowAdviceLoaded) {
                _textController.clear();
              }
            },
          ),
        ],
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
                          adviserProfileData: widget.showAdviceData.adviser!,
                          isClickable: true,
                        ),
                      ),
                      Expanded(
                          child: BlocBuilder<ShowAdviceCubit, ShowAdviceState>(
                        builder: (context, state) {
                          if (state is ShowAdviceLoaded) {
                            return ListView.builder(
                              reverse: true,
                              itemCount: state.response!.data!.chat!.length,
                              itemBuilder: (context, index) => Align(
                                alignment: state.response!.data!.chat![index]
                                            .adviser ==
                                        null
                                    ? AlignmentDirectional.centerStart
                                    : AlignmentDirectional.centerEnd,
                                child: Container(
                                  constraints: BoxConstraints(maxWidth: 220),
                                  // width: 100,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  padding: const EdgeInsets.all(8),
                                  // constraints: BoxConstraints(mi),
                                  decoration: BoxDecoration(
                                      color: state.response!.data!.chat![index]
                                                  .adviser ==
                                              null
                                          ? const Color.fromARGB(
                                                  255, 185, 184, 180)
                                              .withOpacity(0.2)
                                          : Constants.primaryAppColor
                                              .withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    state.response!.data!.chat![index].message
                                        .toString(),
                                    style: Constants.subtitleFont,
                                    // textAlign: state.response!.data!
                                    //             .chat![index].adviser ==
                                    //         null
                                    //     ? TextAlign.start
                                    //     : TextAlign.end,
                                  ),
                                ),
                              ),
                            );
                          } else if (state is ShowAdviceError) {
                            return Center(
                              child: Text("Error"),
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
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
                            BlocBuilder<ShowAdviceCubit, ShowAdviceState>(
                              builder: (context, state) {
                                return InkWell(
                                  onTap: () {
                                    if (state is ShowAdviceLoaded) {
                                      MyApplication.checkConnection()
                                          .then((value) {
                                        if (value) {
                                          if (_textController.text.isEmpty) {
                                            MyApplication.showToastView(
                                                message:
                                                    "لا يمكن ارسال رسالة فارغة!");
                                          } else {
                                            context
                                                .read<SendChatCubit>()
                                                .sendChatFunction(
                                                    msg: _textController.text,
                                                    adviceId: widget
                                                        .showAdviceData.id
                                                        .toString());
                                          }
                                        } else {
                                          MyApplication.showToastView(
                                              message: "لا يوجد اتصال");
                                        }
                                      });
                                    } else {}
                                  },
                                  child: Container(
                                      margin: const EdgeInsetsDirectional.only(
                                          start: 8),
                                      padding: const EdgeInsets.all(10),
                                      height: 40,
                                      width: 40,
                                      decoration:
                                          //  state is ShowAdviceLoaded
                                          //     ?
                                          BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: const Color(0XFF273043)),
                                      // : BoxDecoration(
                                      //     borderRadius:
                                      //         BorderRadius.circular(15),
                                      //     color: Colors.grey),
                                      child: SvgPicture.asset(
                                        sendChat,
                                        // color:
                                        // state is ShowAdviceLoaded
                                        //     ? null
                                        //     : const Color.fromARGB(
                                        //         255, 57, 53, 53),
                                      )),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ))),
      ),
    );
  }
}
