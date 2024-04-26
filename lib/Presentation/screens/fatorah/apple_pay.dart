import 'package:flutter/material.dart';
import 'package:nasooh/layout/home.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../app/utils/my_application.dart';

class ApplePayWebViewScreen extends StatefulWidget {
  final num amount;
  final num adviceId;
  final String url;

  const ApplePayWebViewScreen({
    super.key,
    required this.amount,
    required this.adviceId,
    required this.url,
  });

  @override
  State<ApplePayWebViewScreen> createState() => _ApplePayWebViewScreenState();
}

class _ApplePayWebViewScreenState extends State<ApplePayWebViewScreen> {
  WebViewController? _controller;

  initApplePay({required BuildContext context}) {
    final WebViewController controller = WebViewController();
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onUrlChange: (UrlChange change) async {
            if (change.url!.contains('-success')) {
              MyApplication.navigateToReplaceAllPrevious(
                  context, const HomeLayout(currentIndex: 0));
              MyApplication.showToastView(
                  message: 'تمت عملية الدفع بنجاح', color: Colors.green);
            } else if (change.url!.contains('-fail')) {
              MyApplication.showToastView(
                  message: 'فشل في عملية الدفع', color: Colors.red);
              Navigator.pop(context);
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));

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
