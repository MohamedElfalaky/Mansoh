import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:nasooh/Presentation/screens/FilterScreen/Components/CompleteAdvisorCard.dart';
import 'package:nasooh/Presentation/screens/FilterScreen/Components/PaymentCard.dart';
import 'package:nasooh/Presentation/widgets/MyButton.dart';
import 'package:nasooh/Presentation/widgets/noInternet.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/myApplication.dart';
import '../../../app/utils/lang/language_constants.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  // AdvisorController AdvisorController = AdvisorController();
  late StreamSubscription<ConnectivityResult> _subscription;
  bool? isConnected;

  @override
  void initState() {
    super.initState();

    MyApplication.checkConnection().then((value) {
      if (value) {
        //////
        // todo recall data
        ///
        ///
        ///
        ///
      } else {
        MyApplication.showToastView(
            message: '${getTranslated(context, 'noInternet')}');
      }
    });

    // todo subscribe to internet change
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (mounted) {
        setState(() {
          result == ConnectivityResult.none
              ? isConnected = false
              : isConnected = true;
        });
      }

      /// if internet comes back
      if (result != ConnectivityResult.none) {
        /// call your apis
        // todo recall data
        ///
        ///
        ///
        ///
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // todo if not connected display nointernet widget else continue to the rest build code
    final sizee = MediaQuery.of(context).size;
    if (isConnected == null) {
      MyApplication.checkConnection().then((value) {
        setState(() {
          isConnected = value;
        });
      });
    } else if (!isConnected!) {
      MyApplication.showToastView(
          message: '${getTranslated(context, 'noInternet')}');
      return NoInternetWidget(size: sizee);
    }

    return GestureDetector(
      onTap: () {
        MyApplication.dismissKeyboard(context);
      }, // hide keyboard on tap anywhere

      child: Scaffold(
          floatingActionButton: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              child: const MyButton(
                txt: "إتمام الطلب",
                isBold: true,
              )),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          resizeToAvoidBottomInset: false,
          backgroundColor: Constants.whiteAppColor,
          appBar: AppBar(
            toolbarHeight: 75,
            backgroundColor: Constants.whiteAppColor,
            elevation: 0,
            title: Row(
              children: [
                const Card(
                    child: BackButton(
                  color: Colors.black,
                )),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "تصفية",
                    style: Constants.headerNavigationFont,
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text("مسح", style: Constants.secondaryTitleRegularFont),
                    SizedBox(
                      width: 4,
                    ),
                    Icon(
                      Icons.delete_outline_sharp,
                      color: Colors.black,
                    )
                  ],
                ),
              ],
            ),
          ),
          body: Container(
              color: Constants.whiteAppColor,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 32,
                      ),
                      child: Text(
                        "المجالات",
                        style: Constants.mainTitleFont,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 16,
                      ),
                      child: Text(
                        "جميع المجالات",
                        style: Constants.secondaryTitleRegularFont,
                      ),
                    ),
                    InkWell(
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            scrollable: true,
                            content: Container(
                              height: 300,
                              width: MediaQuery.of(context).size.width,
                              child: ListView(
                                children: [
                                  ExpansionPanelList(),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      child: TextField(
                        enabled: false,
                        decoration: Constants.setTextInputDecoration(
                            prefixIcon: MyPrefixWidget(),
                            suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
                            hintText: "اختر المجال أو التخصص..."),
                      ),
                    )
                  ],
                ),
              ))),
    );
  }
}
