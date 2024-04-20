import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

import '../../../app/keys.dart';
import '../../../app/utils/my_application.dart';
import '../../../app/utils/shared_preference.dart';

class ApplePayWebViewScreen extends StatefulWidget {
  final num amount;
  final num adviceId;

  const ApplePayWebViewScreen(
      {super.key,
      required this.amount,
      required this.adviceId,
       });

  @override
  State<ApplePayWebViewScreen> createState() => _ApplePayWebViewScreenState();
}

class _ApplePayWebViewScreenState extends State<ApplePayWebViewScreen> {

  late String url ='https://uat.nasoh.app/Admin/apple-pay-test?advice_id=${widget.adviceId}';

  WebViewController? _controller;

  initApplePay({required BuildContext context}) {
    final WebViewController controller = WebViewController();
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onUrlChange: (UrlChange change) async {
            if (change.url!

                .contains('https://system.okhtboot.com/payment/callback')) {
              http.Response response = await http.get(
                  Uri.parse('${Keys.baseUrl}/client/coredata/comment/list'),
                  headers: {
                    'Accept': 'application/json',
                    'lang': Get.locale?.languageCode ?? "ar",
                    'Authorization': 'Bearer ${sharedPrefs.getToken()}',
                  });
              Map<String, dynamic> responseMap = json.decode(response.body);
              if (response.statusCode == 200 && responseMap["status"] == 1) {
              } else {
                // debugPrint("request is $phone & $pass");
                MyApplication.showToastView(message: responseMap["message"]);
              }
            } else if (change.url!
                .contains('https://system.okhtboot.com/payment/error')) {
              // Toast.(title: 'لم يتم الدفع');
              Navigator.pop(context);
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(url));

    _controller = controller;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initApplePay(context: context);
  }

  @override
  Widget build(BuildContext _) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 118),
        child: Container(
          padding: const EdgeInsets.only(right: 16, left: 16, top: 50),
          height: 118,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: Row(
            children: [
              const SizedBox(width: 16),
              Text(
                '${widget.amount.toStringAsFixed(1)} ريال سعودي',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
      body: _controller == null
          ? const CircularProgressIndicator.adaptive()
          : WebViewWidget(controller: _controller!),
    );
  }
}
