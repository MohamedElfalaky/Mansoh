import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../Data/cubit/send_chat_cubit/send_chat_state.dart';
import '../../../../app/style/icons.dart';

Container sendMessageButton(SendChatState sendChatState) {
  return Container(
      margin: const EdgeInsetsDirectional.only(start: 8),
      padding: const EdgeInsets.all(10),
      height: 40,
      width: 40,
      decoration: sendChatState is SendChatLoading
          ? BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.grey)
          : BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0XFF273043)),
      child: sendChatState is SendChatLoading
          ? const CircularProgressIndicator.adaptive()
          : SvgPicture.asset(sendChat));
}
