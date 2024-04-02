
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nasooh/Presentation/widgets/my_button.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/my_application.dart';

import '../../../Data/cubit/rejections_cubit/reject_cubit/post_reject_cubit.dart';
import '../../../Data/cubit/rejections_cubit/reject_cubit/post_reject_state.dart';
import '../../../Data/cubit/rejections_cubit/rejection_list_cubit/rejection_list_cubit.dart';
import '../../../Data/cubit/rejections_cubit/rejection_list_cubit/rejection_list_state.dart';
import '../../widgets/alerts.dart';
import '../Home/home.dart';

class RejectScreen extends StatefulWidget {
  const RejectScreen({super.key, required this.adviceId});

  final int adviceId;

  @override
  State<RejectScreen> createState() => _RejectScreenState();
}

class _RejectScreenState extends State<RejectScreen> {
  final TextEditingController rejectController = TextEditingController();
   bool? isConnected;
  final _formKey = GlobalKey<FormState>();
  String? idSelected;

  @override
  void initState() {
    super.initState();

    context.read<ListRejectionCubit>().getDataListRejection();

  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      floatingActionButton: BlocConsumer<PostRejectCubit, PostRejectState>(
        listener: (context, state) {
          if (state is PostRejectLoaded) {
            Alert.alert(
                context: context,
                action: () {
                  MyApplication.navigateToReplaceAllPrevious(
                      context,
                      const HomeLayout(
                        currentIndex: 0,
                      ));
                },
                content: "تم ارسال اعتراضك بنجاح",
                titleAction: "الرئيسية");
          }
        },
        builder: (context, state) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 50,
            child: state is PostRejectLoading
                ? const Center(child: CircularProgressIndicator.adaptive())
                : CustomElevatedButton(
                    txt: "ارسال الاعتراض",
                    isBold: true,
                    onPressedHandler: () {
                      if (_formKey.currentState!.validate()) {
                        // print(widget.adviceId);
                        // print(idSelected);

                        context.read<PostRejectCubit>().postRejectMethod(
                              adviceId: widget.adviceId.toString(),
                              // adviceId: 1,
                              commentId: idSelected,
                              commentOther: "",
                            );
                      }
                    },
                  )),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
      resizeToAvoidBottomInset: false,
      backgroundColor: Constants.whiteAppColor,
      appBar: customAppBar(
        context: context,
        txt: "الاعتراض علي النصيحة",
      ),
      body: BlocBuilder<ListRejectionCubit, ListRejectionState>(
          builder: (context, homeState) {
        if (homeState is ListRejectionLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (homeState is ListRejectionLoaded) {
          return Container(
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
                          const Padding(
                            padding: EdgeInsets.only(bottom: 8, top: 4),
                            child: Text(
                              "حدد سبب رفض النصيحة",
                              style: Constants.headerNavigationFont,
                            ),
                          ),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Container(
                                height: MediaQuery.of(context).size.height *
                                    0.06,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xFFBDBDBD)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5))),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField<dynamic>(
                                    menuMaxHeight: 300.0,
                                    decoration: const InputDecoration(
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintText: "أسباب الاعتراض",
                                        hintStyle: TextStyle(
                                          fontFamily: Constants.mainFont,
                                          fontSize: 14,
                                          color: Constants.fontHintColor,
                                        )),
                                    icon: const Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: Color(0xFFBDBDBD)),
                                    isExpanded: true,
                                    value: idSelected,
                                    items: homeState.response!.data!
                                        .map((e) => DropdownMenuItem(
                                            value: e.id.toString(),
                                            child: Text(e.name!)))
                                        .toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        idSelected = val;
                                      });
                                    },
                                  ),
                                )),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 4, top: 25),
                            child: Text(
                              "أضف ملاحظة".tr,
                              style: Constants.secondaryTitleRegularFont,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: TextFormField(
                              controller: rejectController,
                              // maxLength: 700,
                              maxLines: 5,
                              decoration: Constants.setTextInputDecoration(
                                isParagraphTextField: true,
                                fillColor: const Color(0XFFF5F4F5),
                                hintText: "اكتب ما تريد ....".tr,
                                // isSuffix: false
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 80,
                          ),
                        ],
                      ))));
        } else if (homeState is ListRejectionError) {
          return const SizedBox();
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
