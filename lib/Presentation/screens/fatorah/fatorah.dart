import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
 import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';

import '../../widgets/my_button.dart';

const String liveAPIKey =
    '4AKjeUD8XRrqm-a46DmWzd_cL-JRkNiaJeG5ZDqLvLoUuPXCY9fQShlkt2yrOktybD4wDfk5GQ4Vxo7VRASXS707yHs5b0nHGaPAiTPC8Uwn1YRav-QUJWS_dQXIuBRess71EKQGkjtytbDvZFuZLw9Aqffkj_KKIWy6qxg4V4fdqVHtf9OHrYDMVupxjCaojG2uEyMOCcmCNUH_1ASR4p2JWeZ3XJcnxRCJrfTkoiEuxkuqxFEQ0FdO7I42ub8_2CMBHYAreGATZUt51nMUcadS6Z4V5_6KJ4xTyAZIgXlugTUuFNzEO4DeEodupVV5JVDUD4p5qHTIlDw_QdmOIpcPob_fQ6W7AKvvXN1EeWQS00ksyPltYWSLBOxPoMgDziGn4QTBMjcKHnlWlwSnanj-24Gz3ng8vKyBOLnG8Coq9YLFNqbqsgsVkiYnhk8XWo7cII2X4gx-K-SOHFuefdTqKayPvFk1HYW3k1pj_wt617cJ0r1iYyG8LL5x-FDlR854dHPjQahJq65Exs-HDrOQ-ydceYxe50Lgfp9N_tSs40pIsuTCIew1lRVi2zZUkcvCAwwENjg1EdtY8fK2HzLqpsQfuslDv5cWYh802c9-BbFW2k1x4wkJQ-X-3VGgnyfmIAakk7xhvLbCpbjdG3kh9jE9ypsgWzfZtdPDo_iHxBAMlvgk4Pu-xSGFBS_LLNM7gA';

class FatooraScreen extends StatefulWidget {
  const FatooraScreen({super.key});

  @override
  State<FatooraScreen> createState() => _FatooraScreenState();
}

class _FatooraScreenState extends State<FatooraScreen> {
  late num amount = 1;
  late MFCardPaymentView mfCardView;
  String? invoiceId;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await MFSDK.init(liveAPIKey, MFCountry.SAUDIARABIA, MFEnvironment.LIVE);
      await initiateSession();
      await initiatePayment();
    });
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
        appBar: PreferredSize(
            preferredSize: const Size(double.infinity, 76),
            child: AppBar(title: Text('بوابة الدفع  ($amount SR)'))),
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
        // CustomSnackBars.showErrorToast(
        //     title: 'انتهت مدة صلاحية الجلسة حاول مجددا');
      } else {
        // CustomSnackBars.showErrorToast(
        //     title: '${error.message}'.replaceAll('_', ' ').toLowerCase());
      }
    });
  }

  Widget embeddedCardView() {
    return Column(
      children: [
        SizedBox(height: 220, child: mfCardView),
        MyButton(
            onPressedHandler: () {
              payToFatoorah();
            },
            txt: 'قم بالدفع',
            btnColor: Colors.black),
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
