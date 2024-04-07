import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../Data/cubit/show_advice_cubit/show_advice_cubit/show_advice_state.dart';
import '../../../../app/constants.dart';

Container textMessageWidget(ShowAdviceLoaded state, int index) {
  return Container(
    constraints: const BoxConstraints(maxWidth: 220),
    // width: 100,
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
        color: state.response?.data?.chat?[index].adviser == null
            ? const Color.fromARGB(255, 185, 184, 180).withOpacity(0.2)
            : Constants.primaryAppColor.withOpacity(0.6),
        borderRadius: BorderRadius.circular(20)),
    child: Linkify(
      onOpen: (text) {
        launchUrl(Uri.parse(text.url));
      },
      text: state.response?.data?.chat?[index].message ?? "",
      style: Constants.subtitleFont,
    ),
  );
}
