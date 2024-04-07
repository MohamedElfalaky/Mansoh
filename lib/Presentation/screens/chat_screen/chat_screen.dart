import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:nasooh/Data/cubit/send_chat_cubit/send_chat_cubit.dart';
import 'package:nasooh/Data/cubit/send_chat_cubit/send_chat_state.dart';
import 'package:nasooh/Data/cubit/show_advice_cubit/show_advice_cubit/show_advice_cubit.dart';
import 'package:nasooh/Data/cubit/show_advice_cubit/show_advice_cubit/show_advice_state.dart';
import 'package:nasooh/Presentation/screens/chat_screen/all_messages.dart';
import 'package:nasooh/Presentation/screens/chat_screen/widgets/send_chat_button.dart';
import 'package:nasooh/Presentation/screens/chat_screen/widgets/voice_shape.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:uuid/uuid.dart';
import '../../../Data/models/advisor_profile_model/advisor_profile.dart';
import '../../../app/style/icons.dart';
import '../../../app/utils/exports.dart';
import 'widgets/can_not_speak.dart';
import 'widgets/close_icon.dart';
import 'widgets/custom_app_bar.dart';
import 'widgets/custom_rounded.dart';

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
  // int countSec = 0;

  final TextEditingController chatController = TextEditingController();
  File? pickedFile;
  String? voiceSelected;
  Timer? countdownTimer;
  late SendChatCubit sendChatCubit;
  late ShowAdviceCubit showAdviceCubit;

  void startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        // countSec++;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    sendChatCubit = context.read<SendChatCubit>();
    showAdviceCubit = context.read<ShowAdviceCubit>();
    sendChatCubit.emitInitial();
    showAdviceCubit.getAdviceFunction(adviceId: widget.adviceId);
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
    // countSec = 0;

    isRecording = false;
    if (voiceFile!.existsSync()) {
      List<int> imageBytes = File(voiceFile!.path).readAsBytesSync();
      voiceSelected = base64.encode(imageBytes);
    } else {}

    setState(() {});
  }

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      final status = await Permission.microphone.request();
      if (status != PermissionStatus.granted && await record.hasPermission()) {
        throw Exception('Microphone permission not granted');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SendChatCubit, SendChatState>(
      listener: (context, state) {
        if (state is SendChatLoaded) {
          showAdviceCubit.getAdviceFunction(adviceId: widget.adviceId);
          chatController.clear();
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
                  adviserProfileData: widget.adviserProfileData,
                  isClickable: widget.statusClickable,
                ),
              ),
              const ShowMessagesWidget(),
              widget.openedStatus == true
                  ? Padding(
                      padding: const EdgeInsets.all(14),
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
                                      Flexible(
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

  writeMessage() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: chatController,
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
                    ? " جار التسجيل...  ${countdownTimer?.tick} ثواني "
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
                  builder: (context, sendChatState) {
                    return GestureDetector(
                      onTap: () async {
                        if (state2 is ShowAdviceLoading ||
                            sendChatState is SendChatLoading) {
                          return;
                        }
                        MyApplication.dismissKeyboard(context);

                        if (fileSelected != null) {
                          var fileLength = await pickedFile?.length();
                          debugPrint('file length is $fileLength');
                          if (fileLength! >= 5242880 == true) {
                            MyApplication.showToastView(
                                message: ' 5 MB لا يمكن ان يتعدي الملف');
                            return;
                          }

                          sendChatCubit.sendChatFunction(
                              filee: fileSelected,
                              msg: chatController.text,
                              typee: pickedFile!.path.split(".").last,
                              adviceId: widget.adviceId.toString());

                          setState(() {
                            fileSelected = null;
                            pickedFile = null;
                          });
                        } else if (voiceFile != null) {
                          countdownTimer?.cancel();
                          // countSec = 0;
                          sendChatCubit.sendChatFunction(
                              filee: voiceSelected,
                              msg: chatController.text,
                              typee: voiceFile!.path.split(".").last,
                              adviceId: widget.adviceId.toString());
                          setState(() {
                            voiceSelected = null;
                            voiceFile = null;
                          });
                        } else if (chatController.text.isNotEmpty &&
                            chatController.text != '') {
                          String text = chatController.text;
                          chatController.clear();
                          setState(() {});
                          sendChatCubit.sendChatFunction(
                              filee: fileSelected,
                              msg: text,
                              adviceId: widget.adviceId.toString());
                        }
                      },
                      child: sendMessageButton(sendChatState),
                    );
                  },
                );
              },
            )
        ],
      ),
    );
  }
}
