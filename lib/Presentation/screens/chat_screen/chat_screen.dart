import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nasooh/Data/cubit/send_chat_cubit/send_chat_cubit.dart';
import 'package:nasooh/Data/cubit/send_chat_cubit/send_chat_state.dart';
import 'package:nasooh/Data/cubit/show_advice_cubit/show_advice_cubit/show_advice_cubit.dart';
import 'package:nasooh/Data/cubit/show_advice_cubit/show_advice_cubit/show_advice_state.dart';
import 'package:nasooh/Presentation/screens/Home/Home.dart';
import 'package:nasooh/Presentation/widgets/noInternet.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/myApplication.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import '../../../Data/models/advisor_profile_model/advisor_profile.dart';
import '../../../app/Style/Icons.dart';
import '../../../app/Style/sizes.dart';
import '../ConfirmAdviseScreen/Components/OutlinedAdvisorCard.dart';
import '../UserProfileScreens/UserOrders/UserOrders.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    this.adviserProfileData,
    required this.adviceId,
    this.openedStatus = false,
    this.labelToShow = false,
    this.statusClickable = false,
  });

  final AdviserProfileData? adviserProfileData;
  final int adviceId;
  final bool labelToShow;
  final bool? openedStatus;
  final bool statusClickable;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late StreamSubscription<ConnectivityResult> _subscription;
  String? fileSelected;
  bool? isConnected;
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  File? pickedFile;
  String? voiceSelected;

  @override
  void initState() {
    super.initState();

    player.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.playing) {
        setState(() {
          isPlay = true;
        });
      } else {
        setState(() {
          isPlay = false;
        });
      }
    });

    MyApplication.checkConnection().then((value) {
      if (value) {
        context
            .read<ShowAdviceCubit>()
            .getAdviceFunction(adviceId: widget.adviceId);
        //////
        // todo recall data
        ///
        ///
        ///
        ///
      } else {
        MyApplication.showToastView(message: 'noInternet'.tr);
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
            .getAdviceFunction(adviceId: widget.adviceId);

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
    player.dispose();
    _subscription.cancel();
  }

  final record = AudioRecorder();
  File? voiceFile;
  bool isRecording = false;

  deleteRecord() async {
    await record.stop();
    isRecording = false;
    voiceFile = null;
    setState(() {});
  }

  void startRecord() async {
    await openTheRecorder();
    String uniqueKey = const Uuid().v4() +
        DateTime.now().toIso8601String().replaceAll('.', '-');
    Directory tempDir = await getApplicationDocumentsDirectory();
    // Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    if (Platform.isIOS) {
      voiceFile = File('$tempPath/$uniqueKey.m4a');
    } else {
      voiceFile = File('$tempPath/$uniqueKey.mp3');
    }

    record.start(const RecordConfig(), path: voiceFile!.path).then((value) {
      isRecording = true;
      setState(() {});
    }).onError((error, stackTrace) {
      isRecording = false;
    });
  }

  stopRecord() async {
    await record.stop();
    isRecording = false;
    if (voiceFile!.existsSync()) {
      List<int> imageBytes = await File(voiceFile!.path).readAsBytesSync();
      // print(imageBytes);
      voiceSelected = base64.encode(imageBytes);
      print("xxxxxx");
    } else {
      print("yyyyyyyyyyy");
      // final x =
      //     await File('${voiceFile!.path}/file.mp3').create(recursive: true);
      // List<int> imageBytes = await File(voiceFile!.path).readAsBytesSync();
      // // print(imageBytes);
      // voiceSelected = base64.encode(imageBytes);
    }
    print(voiceFile);
    print("voiceFile");
    setState(() {});
  }

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted && await record.hasPermission()) {
        throw Exception('Microphone permission not granted');
      }
    } else {
      throw Exception(
          'communication_provider.dart =====> openTheRecorder error =======> Microphone permission not available for web');
    }
  }

  final player = AudioPlayer();

  bool isPlay = false;

  Future<void> playAudioFromUrl(String url) async {
    await player.play(UrlSource(url));
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
      MyApplication.showToastView(message: 'noInternet'.tr);
      return NoInternetWidget(size: sizee);
    }

    return GestureDetector(
      onTap: () {
        MyApplication.dismissKeyboard(context);
      }, // hide keyboard on tap anywhere

      child: WillPopScope(
        onWillPop: () async {
          final shouldPop = await Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const Home()),
              (Route<dynamic> route) => false);
          // Navigator.of(context).pu(
          //     MaterialPageRoute(builder: (context) =>  const Home()));
          return shouldPop;
        },
        child: MultiBlocListener(
          listeners: [
            BlocListener<SendChatCubit, SendChatState>(
              listener: (context, state) {
                // TODO: implement listener

                if (state is SendChatLoaded) {
                  context
                      .read<ShowAdviceCubit>()
                      .getAdviceFunction(adviceId: widget.adviceId);
                  _textController.clear();
                }
              },
            ),
            BlocListener<ShowAdviceCubit, ShowAdviceState>(
              listener: (context, state) {
                if (state is ShowAdviceLoaded) {
                  // _textController.clear();

                  AudioPlayer().play(AssetSource("click.wav"));
                }
              },
            ),
          ],
          child: Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(60.0),
                child: AppBar(
                  leading: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 16,
                          ),
                          Container(
                            // margin: EdgeInsets.symmetric(horizontal: 10),
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.1),
                                  offset: Offset(0, 4),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: IconButton(
                              onPressed: () {
                                MyApplication.navigateTo(context, const Home());
                              },
                              icon: Get.locale!.languageCode == "ar"
                                  ? SvgPicture.asset(
                                      backArIcon,
                                      width: 14,
                                      height: 14,
                                    )
                                  : const Icon(
                                      Icons.arrow_back,
                                      color: Colors.black54,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  title: const Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'محادثة الناصح',
                          ),
                        ],
                      ),
                    ],
                  ),
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
                  ],
                ),
              ),
              body: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 16, right: 16, top: 18),
                        // padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: OutlinedAdvisorCard(
                          labelToShow: widget.labelToShow,
                          adviceId: widget.adviceId,
                          adviserProfileData: widget.adviserProfileData!,
                          isClickable: widget.statusClickable,
                        ),
                      ),
                      Expanded(
                          child: BlocBuilder<ShowAdviceCubit, ShowAdviceState>(
                        buildWhen: (previous, current) {
                          return current is! ShowAdviceLoading;
                        },
                        builder: (context, state) {
                          if (state is ShowAdviceLoaded) {
                            return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: ListView.builder(
                                  reverse: true,
                                  itemCount: state.response?.data?.chat?.length,
                                  itemBuilder: (context, index) => Align(
                                    alignment: state.response?.data
                                                ?.chat?[index].adviser ==
                                            null
                                        ? AlignmentDirectional.centerStart
                                        : AlignmentDirectional.centerEnd,
                                    child: state.response?.data?.chat?[index]
                                                .mediaType ==
                                            "1"
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              state.response?.data?.chat?[index]
                                                          .message ==
                                                      null
                                                  ? const SizedBox()
                                                  : Container(
                                                      constraints:
                                                          const BoxConstraints(
                                                              maxWidth: 220),
                                                      // width: 100,
                                                      margin: const EdgeInsets.symmetric(
                                                          vertical: 8),
                                                      padding: const EdgeInsets.all(
                                                          8),
                                                      // constraints: BoxConstraints(mi),
                                                      decoration: BoxDecoration(
                                                          color: state
                                                                      .response
                                                                      ?.data
                                                                      ?.chat?[
                                                                          index]
                                                                      .adviser ==
                                                                  null
                                                              ? const Color.fromARGB(255, 185, 184, 180)
                                                                  .withOpacity(
                                                                      0.2)
                                                              : Constants
                                                                  .primaryAppColor
                                                                  .withOpacity(0.6),
                                                          borderRadius: BorderRadius.circular(20)),
                                                      child: Text(
                                                        state
                                                                .response
                                                                ?.data
                                                                ?.chat?[index]
                                                                .message ??
                                                            "",
                                                        style: Constants
                                                            .subtitleFont,
                                                      )),
                                              InkWell(
                                                onTap: () {
                                                  launchUrl(Uri.parse(state
                                                          .response
                                                          ?.data
                                                          ?.chat?[index]
                                                          .document?[0]
                                                          .file ??
                                                      ""));
                                                },
                                                child: Container(
                                                  width: width(context) * 0.6,
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  padding:
                                                      const EdgeInsets.all(7),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          color: Colors
                                                              .grey.shade400)),
                                                  child:
                                                      state
                                                                  .response
                                                                  ?.data
                                                                  ?.chat?[index]
                                                                  .document?[0]
                                                                  .file
                                                                  ?.endsWith(
                                                                      "mp3") ??
                                                              false
                                                          ? InkWell(
                                                              onTap: () => playAudioFromUrl(state
                                                                      .response
                                                                      ?.data
                                                                      ?.chat?[
                                                                          index]
                                                                      .document?[
                                                                          0]
                                                                      .file ??
                                                                  ""),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                      child: SvgPicture
                                                                          .asset(
                                                                              voiceShape)),
                                                                  const SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  CircleAvatar(
                                                                      child: SvgPicture
                                                                          .asset(
                                                                              voice)),
                                                                ],
                                                              ))
                                                          : state
                                                                      .response
                                                                      ?.data
                                                                      ?.chat?[
                                                                          index]
                                                                      .document?[0]
                                                                      .file
                                                                      ?.endsWith("m4a") ??
                                                                  false
                                                              ? InkWell(
                                                                  onTap: () => playAudioFromUrl(state.response?.data?.chat?[index].document?[0].file ?? ""),
                                                                  child: Row(
                                                                    children: [
                                                                      // isPlay ? Text("playing") :
                                                                      Expanded(
                                                                          child:
                                                                              SvgPicture.asset(voiceShape)),
                                                                      const SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      CircleAvatar(
                                                                          child:
                                                                              SvgPicture.asset(voice)),
                                                                    ],
                                                                  ))
                                                              : Row(
                                                                  children: [
                                                                    state.response?.data?.chat?[index].document?[0].file?.endsWith("png") ??
                                                                            false
                                                                        ? SvgPicture.asset(
                                                                            photo)
                                                                        : state.response?.data?.chat?[index].document?[0].file?.endsWith("jpg") ??
                                                                                false
                                                                            ? SvgPicture.asset(photo)
                                                                            : state.response?.data?.chat?[index].document?[0].file?.endsWith("jpeg") ?? false
                                                                                ? SvgPicture.asset(photo)
                                                                                : state.response?.data?.chat?[index].document?[0].file?.endsWith("pdf") ?? false
                                                                                    ? SvgPicture.asset(pdf)
                                                                                    : state.response?.data?.chat?[index].document?[0].file?.endsWith("mp4") ?? false
                                                                                        ? SvgPicture.asset(mp4Icon)
                                                                                        : const SizedBox(),
                                                                    const SizedBox(
                                                                      width: 7,
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Text(
                                                                        state.response?.data?.chat?[index].document?[0].file?.split("/").last ??
                                                                            "",
                                                                        style: Constants
                                                                            .subtitleFont,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container(
                                            constraints: const BoxConstraints(
                                                maxWidth: 220),
                                            // width: 100,
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            padding: const EdgeInsets.all(8),
                                            // constraints: BoxConstraints(mi),
                                            decoration: BoxDecoration(
                                                color: state
                                                            .response
                                                            ?.data
                                                            ?.chat?[index]
                                                            .adviser ==
                                                        null
                                                    ? const Color.fromARGB(
                                                            255, 185, 184, 180)
                                                        .withOpacity(0.2)
                                                    : Constants.primaryAppColor
                                                        .withOpacity(0.6),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Text(
                                              state.response?.data?.chat?[index]
                                                      .message ??
                                                  "",
                                              style: Constants.subtitleFont,
                                            ),
                                          ),
                                  ),
                                ));
                          } else if (state is ShowAdviceError) {
                            return const Center(
                              child: Text("Error"),
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        },
                      )),
                      widget.openedStatus == true
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              child: Column(
                                children: [
                                  if (isRecording) const Text("recording"),
                                  if (voiceSelected != null)
                                    SvgPicture.asset(voiceShape),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller: _textController,
                                          focusNode: _focusNode,
                                          decoration:
                                              Constants.setTextInputDecoration(
                                            isSuffix: true,
                                            suffixIcon: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                InkWell(
                                                    onTap: () async {
                                                      FilePickerResult? result =
                                                          await FilePicker
                                                              .platform
                                                              .pickFiles();
                                                      // type:
                                                      // FileType.custom;
                                                      // allowedExtensions:
                                                      // ['pdf', 'jpg', 'png', "doc", "docx", "gif"];
                                                      if (result != null) {
                                                        setState(() {
                                                          pickedFile = File(
                                                              result
                                                                  .files
                                                                  .single
                                                                  .path!);
                                                        });
                                                        List<int> imageBytes =
                                                            await File(
                                                                    pickedFile!
                                                                        .path)
                                                                .readAsBytesSync();
                                                        // print(imageBytes);
                                                        fileSelected = base64
                                                            .encode(imageBytes);
                                                      }
                                                      return;
                                                    },
                                                    child: SvgPicture.asset(
                                                        attachFiles)),

                                                // SvgPicture.asset(attachFiles),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                isRecording
                                                    ? InkWell(
                                                        onTap: stopRecord,
                                                        child: const Icon(Icons
                                                            .stop_circle_outlined))
                                                    : InkWell(
                                                        onTap: startRecord,
                                                        child: SvgPicture.asset(
                                                            micee)),
                                                const SizedBox(
                                                  width: 8,
                                                )
                                              ],
                                            ),
                                            hintText: "آكتب رسالتك...",
                                          ).copyWith(
                                            hintStyle: Constants
                                                .subtitleRegularFontHint
                                                .copyWith(
                                                    color: const Color(
                                                        0XFF5C5E6B)),
                                            enabledBorder:
                                                const OutlineInputBorder(
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
                                      isRecording == true
                                          ? const SizedBox()
                                          : BlocBuilder<ShowAdviceCubit,
                                              ShowAdviceState>(
                                              builder: (context, state2) {
                                                return BlocBuilder<
                                                    SendChatCubit,
                                                    SendChatState>(
                                                  builder: (context, state3) {
                                                    return InkWell(
                                                      onTap: () {
                                                        if (state2
                                                                is ShowAdviceLoading ||
                                                            state3
                                                                is SendChatLoading) {
                                                          return;
                                                        }

                                                        MyApplication
                                                            .dismissKeyboard(
                                                                context);

                                                        MyApplication
                                                                .checkConnection()
                                                            .then((value) {
                                                          if (fileSelected !=
                                                              null) {
                                                            context.read<SendChatCubit>().sendChatFunction(
                                                                filee:
                                                                    fileSelected,
                                                                msg:
                                                                    _textController
                                                                        .text,
                                                                typee:
                                                                    pickedFile!
                                                                        .path
                                                                        .split(
                                                                            ".")
                                                                        .last,
                                                                adviceId: widget
                                                                    .adviceId
                                                                    .toString());

                                                            fileSelected = null;
                                                            print("new");
                                                            print(fileSelected);
                                                          } else if (voiceFile !=
                                                              null) {
                                                            context.read<SendChatCubit>().sendChatFunction(
                                                                filee:
                                                                    voiceSelected,
                                                                msg:
                                                                    _textController
                                                                        .text,
                                                                typee:
                                                                    voiceFile!
                                                                        .path
                                                                        .split(
                                                                            ".")
                                                                        .last,
                                                                adviceId: widget
                                                                    .adviceId
                                                                    .toString());
                                                            // isRecording = false;
                                                            setState(() {
                                                              voiceSelected =
                                                                  null;
                                                            });

                                                            print("new");
                                                            print(fileSelected);
                                                          } else if (value) {
                                                            if (_textController
                                                                .text.isEmpty) {
                                                              MyApplication
                                                                  .showToastView(
                                                                      message:
                                                                          "لا يمكن ارسال رسالة فارغة!");
                                                            } else {
                                                              context.read<SendChatCubit>().sendChatFunction(
                                                                  filee:
                                                                      fileSelected,
                                                                  msg:
                                                                      _textController
                                                                          .text,
                                                                  adviceId: widget
                                                                      .adviceId
                                                                      .toString());
                                                            }
                                                          } else {
                                                            MyApplication
                                                                .showToastView(
                                                                    message:
                                                                        "لا يوجد اتصال");
                                                          }
                                                        });
                                                      },
                                                      child:
                                                          //  state is ShowAdviceLoading
                                                          //     ? Center(
                                                          //         child: CircularProgressIndicator(),
                                                          //       )
                                                          //     :
                                                          Container(
                                                              margin:
                                                                  const EdgeInsetsDirectional
                                                                      .only(
                                                                      start: 8),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              height: 40,
                                                              width: 40,
                                                              decoration: state3
                                                                      is SendChatLoading
                                                                  ? BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      color: Colors
                                                                          .grey)
                                                                  : BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      color: const Color(
                                                                          0XFF273043)),
                                                              child:
                                                                  SvgPicture.asset(
                                                                sendChat,
                                                                color: state3
                                                                        is SendChatLoading
                                                                    ? const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        57,
                                                                        53,
                                                                        53)
                                                                    : null,
                                                              )),
                                                    );
                                                  },
                                                );
                                              },
                                            )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              height: 90,
                              width: width(context),
                              color: Constants.primaryAppColor.withOpacity(0.1),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text(
                                    "لا يمكنك التحدث مع هذا الناصح الان",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: Constants.mainFont),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      MyApplication.navigateTo(
                                          context, const UserOrders());
                                    },
                                    child: const Text(
                                      "العودة الي طلباتي",
                                      style: TextStyle(
                                          color: Constants.primaryAppColor,
                                          fontFamily: Constants.mainFont),
                                    ),
                                  )
                                ],
                              ),
                            ),
                    ],
                  ))),
        ),
      ),
    );
  }
}
