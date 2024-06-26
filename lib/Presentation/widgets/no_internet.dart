import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasooh/app/constants.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const Spacer(),
              const Icon(
                CupertinoIcons.wifi_slash,
                color: Constants.primaryAppColor,
                size: 130.0,
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              Text(
                'noInternet'.tr,
                style: const TextStyle(color: Colors.black45, fontSize: 20.0),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
