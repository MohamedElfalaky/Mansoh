import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:nasooh/Data/cubit/send_chat_cubit/send_chat_cubit.dart';
import 'package:nasooh/Data/cubit/send_chat_cubit/send_chat_state.dart';
import 'package:nasooh/Data/cubit/show_advice_cubit/show_advice_cubit/show_advice_cubit.dart';
import 'package:nasooh/Data/cubit/show_advice_cubit/show_advice_cubit/show_advice_state.dart';
import 'package:nasooh/Presentation/screens/chat_screen/voice_shape.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import '../../../Data/models/advisor_profile_model/advisor_profile.dart';
import '../../../app/utils/exports.dart';
import 'can_not_speak.dart';
import 'close_icon.dart';
import 'custom_app_bar.dart';
import 'custom_rounded.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {super.key,
      this.adviserProfileData,
      required this.adviceId,
      required this.description,
      this.openedStatus = false,
      this.labelToShow = false,
      this.statusClickable = false});

  final AdviserProfileData? adviserProfileData;
  final int adviceId;
  final bool labelToShow;
  final bool? openedStatus;
  final bool statusClickable;
  final String description;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String? fileSelected;
  int countSec = 0;

  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  File? pickedFile;
  String? voiceSelected;
  Timer? countdownTimer;
  late SendChatCubit sendChatCubit;

  void startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        countSec++;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    sendChatCubit = context.read<SendChatCubit>();
    sendChatCubit.emitInitial();

    context
        .read<ShowAdviceCubit>()
        .getAdviceFunction(adviceId: widget.adviceId);
  }

  @override
  void dispose() {
    super.dispose();
    _textController.clear();
    _focusNode.dispose();
    player.dispose();
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
    startTimer();

    String uniqueKey = const Uuid().v4() +
        DateTime.now().toIso8601String().replaceAll('.', '-');
    Directory tempDir = await getApplicationDocumentsDirectory();
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

    countdownTimer?.cancel();
    countSec = 0;

    isRecording = false;
    if (voiceFile!.existsSync()) {
      List<int> imageBytes = File(voiceFile!.path).readAsBytesSync();
      voiceSelected = base64.encode(imageBytes);
    } else {}

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

  int playingIndex = -1;

  Future<void> playAudioFromUrl(String url, int index) async {
    if (playingIndex == index) {
      await player.stop();
      setState(() {
        playingIndex = -1; // Reset playingIndex
      });
    } else {
      await player.play(UrlSource(url));
      player.onPlayerComplete.listen((event) {
        setState(() {
          playingIndex = -1; // Reset playingIndex
        });
      });
      setState(() {
        playingIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SendChatCubit, SendChatState>(
      listener: (context, state) {
        if (state is SendChatLoaded) {
          context
              .read<ShowAdviceCubit>()
              .getAdviceFunction(adviceId: widget.adviceId);
          _textController.clear();
        }
      },
      child: Scaffold(
          appBar: customChatAppBar(context),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 18),
                child: OutlinedAdvisorCard(
                  description: widget.description,
                  labelToShow: widget.labelToShow,
                  adviceId: widget.adviceId,
                  adviserProfileData: widget.adviserProfileData!,
                  isClickable: widget.statusClickable,
                ),
              ),
              showMessagesWidget(),
              widget.openedStatus == true
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (voiceSelected != null)
                            Row(
                              children: [
                                VoiceShaped(
                                    showClose: voiceFile != null,
                                    onPressed: () => setState(() {
                                          voiceFile = null;
                                          voiceSelected = null;
                                        })),
                              ],
                            ),
                          if (pickedFile != null)
                            Row(
                              children: [
                                CustomRoundedWidget(
                                  color: Colors.grey.shade300,
                                  child: Row(
                                    children: [
                                      // const Spacer(),
                                      Flexible(
                                        // width: 200,
                                        child: Text(
                                          pickedFile!.path.replaceRange(
                                              0,
                                              (pickedFile!.path.length) ~/ 2.4,
                                              ""),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      SvgPicture.asset(
                                        filePdf,
                                        width: 20,
                                        height: 20,
                                      ),
                                      CloseIcon(
                                        onPressed: () {
                                          setState(() {
                                            pickedFile = null;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          // : closeFileIconWidget(),
                          const SizedBox(width: 20),
                          writeMessage()
                        ],
                      ),
                    )
                  : const CanNotSpeak()
            ],
          )),
    );
  }

  closeFileIconWidget() {
    return CustomRoundedWidget(
        child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(child: Text(pickedFile!.path.replaceRange(0, 50, ""))),
        const SizedBox(width: 10),
        SvgPicture.asset(fileImage, width: 20, height: 20),
        if (pickedFile != null)
          CloseIcon(
            onPressed: () {
              setState(() {
                pickedFile = null;
              });
            },
          ),
      ],
    ));
  }

  Expanded showMessagesWidget() {
    return Expanded(
        child: BlocBuilder<ShowAdviceCubit, ShowAdviceState>(
      buildWhen: (previous, current) {
        return current is! ShowAdviceLoading;
      },
      builder: (context, state) {
        if (state is ShowAdviceLoaded) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                reverse: true,
                itemCount: state.response?.data?.chat?.length,
                itemBuilder: (context, index) {
                  bool isNotEmptyList =
                      state.response?.data?.chat?[index].document?.isNotEmpty ??
                          false;
                  bool photoEnd = isNotEmptyList == true &&
                          state.response?.data?.chat?[index].document?[0].file
                                  ?.endsWith("png") ==
                              true ||
                      isNotEmptyList == true &&
                          state.response?.data?.chat?[index].document?[0].file
                                  ?.endsWith("jpg") ==
                              true ||
                      isNotEmptyList == true &&
                          state.response?.data?.chat?[index].document?[0].file
                                  ?.endsWith("jpeg") ==
                              true;

                  bool mp3End = isNotEmptyList == true &&
                      state.response?.data?.chat?[index].document?[0].file
                              ?.endsWith("mp3") ==
                          true;
                  bool m4aEnd = isNotEmptyList == true &&
                      state.response?.data?.chat?[index].document?[0].file
                              ?.endsWith("m4a") ==
                          true;
                  bool mp4End = isNotEmptyList == true &&
                      state.response?.data?.chat?[index].document?[0].file
                              ?.endsWith("mp4") ==
                          true;

                  bool pdfEnd = isNotEmptyList &&
                      state.response?.data?.chat?[index].document?[0].file
                              ?.endsWith("pdf") ==
                          true;

                  return Align(
                    alignment:
                        state.response?.data?.chat?[index].adviser == null
                            ? AlignmentDirectional.centerStart
                            : AlignmentDirectional.centerEnd,
                    child: state.response?.data?.chat?[index].mediaType == "1"
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              state.response?.data?.chat?[index].message == null
                                  ? const SizedBox()
                                  : Container(
                                      constraints:
                                          const BoxConstraints(maxWidth: 220),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: state.response?.data
                                                      ?.chat?[index].adviser ==
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
                                      )),
                              GestureDetector(
                                onTap: () {
                                  if (state.response?.data?.chat?[index]
                                              .document?[0].file
                                              ?.contains('png') ==
                                          true ||
                                      state.response?.data?.chat?[index]
                                              .document?[0].file
                                              ?.contains('jpg') ==
                                          true ||
                                      state.response?.data?.chat?[index]
                                              .document?[0].file
                                              ?.contains('jpeg') ==
                                          true) {
                                    showAdaptiveDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (context) {
                                          return AlertDialog(
                                            contentPadding: EdgeInsets.zero,
                                            content: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Image.network(
                                                '${state.response?.data?.chat?[index].document?[0].file}',
                                              ),
                                            ),
                                          );
                                        });
                                  } else {
                                    launchUrl(Uri.parse(state.response?.data
                                            ?.chat?[index].document?[0].file ??
                                        ""));
                                  }
                                },
                                child: FittedBox(
                                  child: Container(
                                    // width: mp3End || m4aEnd ? 280 : 250,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    padding: const EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.grey.shade400)),
                                    child: mp3End || m4aEnd
                                        ? GestureDetector(
                                            onTap: () {
                                              player.stop();
                                              playAudioFromUrl(
                                                  state
                                                          .response
                                                          ?.data
                                                          ?.chat?[index]
                                                          .document?[0]
                                                          .file ??
                                                      "",
                                                  index);
                                            },
                                            child: playingIndex == index
                                                ? Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                        SizedBox(
                                                          height: 40,
                                                          width: 210,
                                                          child: Image.asset(
                                                              'assets/images/gifnasoh.gif',
                                                              fit: BoxFit.fill),
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        const CircleAvatar(
                                                            backgroundColor:
                                                                Constants
                                                                    .primaryAppColor,
                                                            child: Icon(
                                                                Icons.pause,
                                                                color: Colors
                                                                    .white)),
                                                      ])
                                                : Row(
                                                    children: [
                                                      SizedBox(
                                                        height: 40,
                                                        width: 210,
                                                        child: SvgPicture.asset(
                                                            voiceShape,
                                                            fit: BoxFit.fill),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      CircleAvatar(
                                                          backgroundColor:
                                                              Constants
                                                                  .primaryAppColor,
                                                          child:
                                                              SvgPicture.asset(
                                                                  voice)),
                                                    ],
                                                  ),
                                          )
                                        : Row(
                                            children: [
                                              photoEnd
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            '${state.response?.data?.chat?[index].document?[0].file}',
                                                        width: 50,
                                                        height: 50,
                                                        placeholder:
                                                            (context, string) {
                                                          return SvgPicture
                                                              .asset(photo);
                                                        },
                                                        errorWidget: (context,
                                                            string, object) {
                                                          return Image.asset(
                                                              Constants
                                                                  .imagePlaceHolder);
                                                        },
                                                      ),
                                                    )
                                                  : pdfEnd
                                                      ? SvgPicture.asset(pdf)
                                                      : mp4End
                                                          ? SvgPicture.asset(
                                                              mp4Icon)
                                                          : const SizedBox(),
                                              const SizedBox(width: 7),

                                              Text(
                                                'click_to_see_full_image'.tr,
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              // Expanded(
                                              //   child: Text(
                                              //       state
                                              //               .response
                                              //               ?.data
                                              //               ?.chat?[index]
                                              //               .document?[0]
                                              //               .file
                                              //               ?.split("/")
                                              //               .last ??
                                              //           "",
                                              //       style:
                                              //           Constants.subtitleFont),
                                              // ),
                                            ],
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(
                            constraints: const BoxConstraints(maxWidth: 220),
                            // width: 100,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: state.response?.data?.chat?[index]
                                            .adviser ==
                                        null
                                    ? const Color.fromARGB(255, 185, 184, 180)
                                        .withOpacity(0.2)
                                    : Constants.primaryAppColor
                                        .withOpacity(0.6),
                                borderRadius: BorderRadius.circular(20)),
                            child: Linkify(
                              onOpen: (text) {
                                launchUrl(Uri.parse(text.url));
                              },
                              text:
                                  state.response?.data?.chat?[index].message ??
                                      "",
                              style: Constants.subtitleFont,
                            ),
                          ),
                  );
                },
              ));
        } else if (state is ShowAdviceError) {
          return const Center(
            child: Text("Error"),
          );
        } else {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
      },
    ));
  }

  writeMessage() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: Constants.setTextInputDecoration(
                isSuffix: true,
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                        onTap: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles();
                          if (result != null) {
                            setState(() {
                              pickedFile = File(result.files.single.path!);
                            });
                            List<int> imageBytes =
                                File(pickedFile!.path).readAsBytesSync();
                            fileSelected = base64.encode(imageBytes);
                          }
                          return;
                        },
                        child: SvgPicture.asset(attachFiles)),
                    const SizedBox(width: 8),
                    isRecording
                        ? GestureDetector(
                            onTap: stopRecord,
                            child: const Icon(Icons.stop_circle_outlined))
                        : GestureDetector(
                            onTap: () {
                              startRecord();
                            },
                            child: SvgPicture.asset(micee)),
                    const SizedBox(width: 8)
                  ],
                ),
                hintText: isRecording
                    ? " جار التسجيل...  $countSec ثواني "
                    : "آكتب رسالتك...",
              ).copyWith(
                hintStyle: Constants.subtitleRegularFontHint
                    .copyWith(color: const Color(0XFF5C5E6B)),
                enabledBorder: const OutlineInputBorder(
                  gapPadding: 0,
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                filled: true,
                fillColor: const Color(0xffF5F4F5),
              ),
            ),
          ),
          if (!isRecording)
            BlocBuilder<ShowAdviceCubit, ShowAdviceState>(
              builder: (context, state2) {
                return BlocBuilder<SendChatCubit, SendChatState>(
                  builder: (context, state3) {
                    return GestureDetector(
                      onTap: () async {
                        if (state2 is ShowAdviceLoading ||
                            state3 is SendChatLoading) {
                          return;
                        }
                        MyApplication.dismissKeyboard(context);

                        if (fileSelected != null) {
                          var fileLength = await pickedFile?.length();
                          debugPrint('file length is $fileLength');
                          if (fileLength! >= 5000000 == true) {
                            MyApplication.showToastView(
                                message: ' 5 MB لا يمكن ان يتعدي الملف');
                            return;
                          }

                          sendChatCubit.sendChatFunction(
                              filee: fileSelected,
                              msg: _textController.text,
                              typee: pickedFile!.path.split(".").last,
                              adviceId: widget.adviceId.toString());

                          setState(() {
                            fileSelected = null;
                            pickedFile = null;
                          });
                        } else if (voiceFile != null) {
                          countdownTimer?.cancel();
                          countSec = 0;
                          sendChatCubit.sendChatFunction(
                              filee: voiceSelected,
                              msg: _textController.text,
                              typee: voiceFile!.path.split(".").last,
                              adviceId: widget.adviceId.toString());
                          setState(() {
                            voiceSelected = null;
                            voiceFile = null;
                          });
                        } else if (_textController.text.isNotEmpty &&
                            _textController.text != '') {
                          String text = _textController.text;
                          _textController.clear();
                          setState(() {});
                          sendChatCubit.sendChatFunction(
                              filee: fileSelected,
                              msg: text,
                              adviceId: widget.adviceId.toString());
                        }
                      },
                      child: sendMessageButton(state3),
                    );
                  },
                );
              },
            )
        ],
      ),
    );
  }

  Container sendMessageButton(SendChatState state3) {
    return Container(
        margin: const EdgeInsetsDirectional.only(start: 8),
        padding: const EdgeInsets.all(10),
        height: 40,
        width: 40,
        decoration: state3 is SendChatLoading
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.grey)
            : BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(0XFF273043)),
        child: state3 is SendChatLoading
            ? const CircularProgressIndicator.adaptive()
            : SvgPicture.asset(
                sendChat,
                color: state3 is SendChatLoading
                    ? const Color.fromARGB(255, 57, 53, 53)
                    : null,
              ));
  }
}
