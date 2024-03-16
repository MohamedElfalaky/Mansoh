import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import 'package:nasooh/app/constants.dart';

import '../../widgets/my_button.dart';

//test
// 5453010000095539
// 12/25
// 300

const String liveAPIKey =
    '4AKjeUD8XRrqm-a46DmWzd_cL-JRkNiaJeG5ZDqLvLoUuPXCY9fQShlkt2yrOktybD4wDfk5GQ4Vxo7VRASXS707yHs5b0nHGaPAiTPC8Uwn1YRav-QUJWS_dQXIuBRess71EKQGkjtytbDvZFuZLw9Aqffkj_KKIWy6qxg4V4fdqVHtf9OHrYDMVupxjCaojG2uEyMOCcmCNUH_1ASR4p2JWeZ3XJcnxRCJrfTkoiEuxkuqxFEQ0FdO7I42ub8_2CMBHYAreGATZUt51nMUcadS6Z4V5_6KJ4xTyAZIgXlugTUuFNzEO4DeEodupVV5JVDUD4p5qHTIlDw_QdmOIpcPob_fQ6W7AKvvXN1EeWQS00ksyPltYWSLBOxPoMgDziGn4QTBMjcKHnlWlwSnanj-24Gz3ng8vKyBOLnG8Coq9YLFNqbqsgsVkiYnhk8XWo7cII2X4gx-K-SOHFuefdTqKayPvFk1HYW3k1pj_wt617cJ0r1iYyG8LL5x-FDlR854dHPjQahJq65Exs-HDrOQ-ydceYxe50Lgfp9N_tSs40pIsuTCIew1lRVi2zZUkcvCAwwENjg1EdtY8fK2HzLqpsQfuslDv5cWYh802c9-BbFW2k1x4wkJQ-X-3VGgnyfmIAakk7xhvLbCpbjdG3kh9jE9ypsgWzfZtdPDo_iHxBAMlvgk4Pu-xSGFBS_LLNM7gA';
const String testApiKey =
    'rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL';

class FatooraScreen extends StatefulWidget {
  const FatooraScreen({super.key, required this.amount});

  final num? amount;

  @override
  State<FatooraScreen> createState() => _FatooraScreenState();
}

class _FatooraScreenState extends State<FatooraScreen> {
  late num amount;
  late MFCardPaymentView mfCardView;
  String? invoiceId;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await MFSDK.init(testApiKey, MFCountry.SAUDIARABIA, MFEnvironment.TEST);
      await initiateSession();
      await initiatePayment();
    });

    amount = widget.amount ?? 0;

    if (kDebugMode) {
      print('HANY HANY HANY ');

      print('amount is $amount');
    }
  }

  initiatePayment() {
    MFInitiatePaymentRequest request = MFInitiatePaymentRequest(
        invoiceAmount: amount, currencyIso: MFCurrencyISO.SAUDIARABIA_SAR);
    MFSDK.initiatePayment(request, MFLanguage.ARABIC);
  }

  @override
  Widget build(BuildContext context) {
    mfCardView = MFCardPaymentView(cardViewStyle: cardViewStyle());

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: customAppBar(context: context, txt: 'إتمام عملية الدفع'),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(2.5),
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 15),
                  child: embeddedCardView()),
            ],
          ),
        ));
  }

  payToFatoorah() async {
    MFExecutePaymentRequest executePaymentRequest =
        MFExecutePaymentRequest(invoiceValue: amount);
    await mfCardView.pay(executePaymentRequest, MFLanguage.ARABIC, (invoiceId) {
      this.invoiceId = invoiceId;
    }).then((value) {
      if (value.invoiceStatus == 'Paid') {

        if (kDebugMode) {
          print('pay function done ${value.invoiceId}');
        }
      }
    }).catchError((error) {
      if (error.message.contains('session')) {
        // CustomSnackBars.showErrorToast(title: 'session expired'.tr());
      } else {
        // CustomSnackBars.showErrorToast(title: '${error.message}'.replaceAll('_', ' ').toLowerCase());
      }
    });
  }

  Widget embeddedCardView() {
    return Column(
      children: [
        SizedBox(height: 220, child: mfCardView),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomElevatedButton(
              onPressedHandler: () {
                payToFatoorah();
              },
              txt: 'قم بالدفع',
              isBold: true,
              txtSize: 15.0,
              btnColor: Constants.primaryAppColor,
              txtColor: Colors.black),
        ),
      ],
    );
  }

  initiateSession() {
    MFInitiateSessionRequest initiateSessionRequest =
        MFInitiateSessionRequest();
    MFSDK
        .initSession(initiateSessionRequest, MFLanguage.ARABIC)
        .then((value) => mfCardView.load(value, (bin) {}));
  }

  MFCardViewStyle cardViewStyle() {
    MFCardViewStyle cardViewStyle = MFCardViewStyle();
    cardViewStyle.hideCardIcons = false;
    cardViewStyle.input?.inputMargin = 3;

    return cardViewStyle;
  }
}
