import 'package:audioplayers/audioplayers.dart';
import 'package:nasooh/Presentation/screens/chat_screen/widgets/audio_widget.dart';
import 'package:nasooh/Presentation/screens/chat_screen/widgets/image_message_view.dart';
import 'package:nasooh/Presentation/screens/chat_screen/widgets/text_message_view.dart';
import 'package:nasooh/app/utils/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Data/cubit/show_advice_cubit/show_advice_cubit/show_advice_cubit.dart';
import '../../../Data/cubit/show_advice_cubit/show_advice_cubit/show_advice_state.dart';
import '../../../app/utils/exports.dart';
import '../../widgets/show_image_dialog.dart';

class ShowMessagesWidget extends StatefulWidget {
  const ShowMessagesWidget({super.key});

  @override
  State<ShowMessagesWidget> createState() => _ShowMessagesWidgetState();
}

class _ShowMessagesWidgetState extends State<ShowMessagesWidget> {
  final player = AudioPlayer();

  int playingIndex = -1;

  Future<void> playAudioFromUrl(String url, int index) async {
    if (playingIndex == index) {
      await player.stop();
      setState(() {
        playingIndex = -1;
      });
    } else {
      await player.play(UrlSource(url));
      player.onPlayerComplete.listen((event) {
        setState(() {
          playingIndex = -1;
        });
      });
      setState(() {
        playingIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      final chatItem = state.response?.data?.chat?[index];
                      final document = chatItem?.document;

                      bool isNotEmptyList = document?.isNotEmpty ?? false;
                      bool isVoice = isNotEmptyList && (document?[0].file?.isVoice ?? false);
                      return Align(
                        alignment:
                        chatItem?.adviser == null
                            ? AlignmentDirectional.centerStart
                            : AlignmentDirectional.centerEnd,
                        child: chatItem?.mediaType == "1" && isNotEmptyList
                            ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (chatItem?.message != null)
                              buildTextViewWidget(state, index),
                            GestureDetector(
                              onTap: () {
                                final message = document?[0].file;
                                if (message != null) {
                                  if (message.isImg) {
                                    showImageDialogWidget(context, '$message');
                                  } else {
                                    launchUrl(Uri.parse('$message'));
                                  }
                                }
                              },
                              child: FittedBox(
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10),
                                  padding: const EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.grey.shade400)),
                                  child: isVoice
                                      ? voiceMessageViewWidget(
                                      '${document?[0].file}', index)
                                      : imageMessageViewWidget('${document?[0].file}'),
                                ),
                              ),
                            ),
                          ],
                        )
                            : textMessageWidget(state, index),
                      );
                    },
                  ));
            } else if (state is ShowAdviceError){
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            return const SizedBox.shrink();
          },
        ));
  }

  GestureDetector voiceMessageViewWidget(String voiceFile, int index) {
    return GestureDetector(
      onTap: () {
        player.stop();
        playAudioFromUrl(voiceFile, index);
      },
      child:
      playingIndex == index ? audioPlayingWidget() : audioStoppedWidget(),
    );
  }
}
