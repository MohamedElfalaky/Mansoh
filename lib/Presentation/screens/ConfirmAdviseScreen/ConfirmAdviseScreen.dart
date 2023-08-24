import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import 'package:nasooh/Presentation/screens/ConfirmAdviseScreen/Components/OutlinedAdvisorCard.dart';
import 'package:nasooh/Presentation/widgets/MyButton.dart';
import 'package:nasooh/Presentation/widgets/noInternet.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/myApplication.dart';
import '../../../Data/cubit/send_advice_cubit/send_advise_cubit.dart';
import '../../../Data/cubit/send_advice_cubit/send_advise_state.dart';
import '../../../app/utils/lang/language_constants.dart';
import '../Advisor/AdvisorScreen.dart';
import '../CompleteAdviseScreen/CompleteAdviseScreen.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ConfirmAdviseScreen extends StatefulWidget {
  const ConfirmAdviseScreen(
      {super.key,
      required this.id,
      required this.name,
      required this.imagePhoto});

  final int id;
  final String name;
  final String imagePhoto;

  @override
  State<ConfirmAdviseScreen> createState() => _ConfirmAdviseScreenState();
}

class _ConfirmAdviseScreenState extends State<ConfirmAdviseScreen> {
  final TextEditingController requestTitle = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // AdvisorController AdvisorController = AdvisorController();
  late StreamSubscription<ConnectivityResult> _subscription;
  String? fileSelected;
  bool? isConnected;
  final _formKey = GlobalKey<FormState>();
  File? pickedFile;

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
          floatingActionButton: BlocConsumer<SendAdviseCubit, SendAdviseState>(
              listener: (context, state) {
                if (state is SendAdviseLoaded) {
                  MyApplication.navigateTo(
                      context,
                      CompleteAdviseScreen(
                        adviceId: state.response!.data!.id!,
                        // imagePhoto: widget.imagePhoto,
                        // name: widget.name,
                        // id: widget.id,
                      ));
                }
              },
              builder: (context, state) => state is SendAdviseLoading
                  ? const CircularProgressIndicator()
                  : Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      height: 50,
                      child: MyButton(
                        txt: "تأكيد الطلب",
                        isBold: true,
                        onPressedHandler: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<SendAdviseCubit>().sendAdviseMethod(
                                context: context,
                                adviserId: widget.id,
                                name: requestTitle.text,
                                description: descriptionController.text,
                                price: priceController.text,
                                documentsFile: fileSelected);
                          }
                        },
                      ))),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          resizeToAvoidBottomInset: false,
          backgroundColor: Constants.whiteAppColor,
          appBar: customAppBar(
            context: context,
            txt: "طلب نصيحة",
          ),
          body: Container(
              color: Constants.whiteAppColor,
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  top: 15),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(height: 15,),
                      OutlinedAdvisorCard(
                          isClickable: false,
                          name: widget.name,
                          imagePhoto: widget.imagePhoto),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8, top: 8),
                        child: Text(
                          "عنوان الطلب",
                          style: Constants.secondaryTitleRegularFont,
                        ),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "يجب ادخال عنوان الطلب";
                          } else if (value.length < 5) {
                            return "عنوان الطلب يجب الا يقل عن 5 أحرف";
                          }
                          return null;
                        },
                        controller: requestTitle,
                        decoration: Constants.setTextInputDecoration(
                            prefixIcon: MyPrefixWidget(),
                            hintText: "ادخل عنوان الطلب..."),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "مثال: تشققات في الجدران .. أفضل وجهات في العلا",
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: Constants.mainFont,
                              color: Constants.primaryAppColor),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          bottom: 8,
                        ),
                        child: Text(
                          "كم مستعد تدفع مقابل النصيحة؟",
                          style: Constants.secondaryTitleRegularFont,
                        ),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "المبلغ مطلوب";
                          }
                          return null;
                        },
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        decoration: Constants.setTextInputDecoration(
                            prefixIcon: MyPrefixWidget(),
                            hintText: "0.00",
                            suffixIcon: const Text(
                              "ريال سعودي",
                              style: Constants.secondaryTitleRegularFont,
                            )),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text(
                            "يحق للناصح رفض الطلب في حال كان المبلغ لا يتناسب مع قيمة النصيحة حسب تقديره",
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: Constants.mainFont,
                                color: Constants.primaryAppColor)),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text(
                          "تفاصيل الطلب",
                          style: Constants.secondaryTitleRegularFont,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "يجب ادخال تفاصيل الطلب";
                            } else if (value.length < 5) {
                              return "تفاصيل الطلب يجب الا تقل عن 5 أحرف";
                            }
                            return null;
                          },
                          controller: descriptionController,
                          maxLength: 700,
                          maxLines: 5,
                          decoration: Constants.setTextInputDecoration(
                            isParagraphTextField: true,
                            fillColor: const Color(0XFFF5F4F5),
                            hintText:
                                "اشرح طلبك بوضوح وإيجاز وزود الناصح بمعلومات كافيةللحصول على إجابة وافية ...",
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles();
                          type:
                          FileType.custom;
                          allowedExtensions:
                          ['pdf', 'jpg', 'png', "doc", "docx", "gif"];
                          if (result != null) {
                            setState(() {
                              pickedFile = File(result.files.single.path!);
                            });
                            List<int> imageBytes =
                                await File(pickedFile!.path).readAsBytesSync();
                            print(imageBytes);
                            fileSelected = base64.encode(imageBytes);
                          }
                          return;
                        },
                        child: DottedBorder(
                          dashPattern: const [10, 6],
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(8),
                          color: const Color(0XFF80848866),
                          child: SizedBox(
                            height: 56,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.upload,
                                  color: Color(0xFF0076FF),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "رفع الملفات الخاصة بالطلب",
                                  style: Constants.subtitleFont,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (pickedFile != null)
                            pickedFile!.path.endsWith('.pdf')
                                ? Container(
                                    height: 100,
                                    width: 100,
                                    child: SfPdfViewer.file(
                                      pickedFile!,
                                    ),
                                  )
                                : Container(
                                    height: 100,
                                    width: 100,
                                    child: Image.file(pickedFile!)),
                          SizedBox(
                            width: 20,
                          ),
                          if (pickedFile != null)
                            IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                setState(() {
                                  pickedFile = null;
                                });
                              },
                            ),
                        ],
                      ),

                      const SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                ),
              ))),
    );
  }
}
