import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nasooh/Presentation/widgets/my_button.dart';
import 'package:nasooh/app/Style/icons.dart';
import '../../../../Data/cubit/authentication/new_mob/mob_cubit.dart';
import '../../../../Data/cubit/authentication/new_mob/mob_state.dart';
import '../../../../app/Style/sizes.dart';
import '../../../../app/constants.dart';
import '../../../../app/utils/my_application.dart';
import '../../../widgets/phone_text_field.dart';

String sendPhone = "";

class CheckMobScreen extends StatefulWidget {
  const CheckMobScreen({Key? key}) : super(key: key);

  @override
  State<CheckMobScreen> createState() => _CheckMobScreenState();
}

class _CheckMobScreenState extends State<CheckMobScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late AnimationController _fadeController;
  final TextEditingController _phoneController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));
    _animationController.forward();

    _fadeController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    _fadeController.forward();
  }


  bool termsVal = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
    _fadeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MyApplication.dismissKeyboard(context);
      },
      child: Stack(
        children: [
          Center(
            child: Image.asset(
              onBoardingPNGbk,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          Scaffold(
            backgroundColor: const Color.fromARGB(0, 168, 46, 46),
            resizeToAvoidBottomInset: false,
            body: Form(
              key: _formKey,
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.only(
                  top: 16,
                  right: 16,
                  left: 16,
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: BlocBuilder<MobCubit, MobState>(
                      builder: (context, state) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SlideTransition(
                            position: Tween<Offset>(
                                    begin: const Offset(0, -3),
                                    end: const Offset(0, 0.1))
                                .animate(_animationController),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 24, top: 44),
                              child: Center(
                                child: SvgPicture.asset(
                                  "assets/images/SVGs/soNew.svg",
                                  width: 148,
                                  height: 148,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: height(context) * 0.08),
                          Text(
                            "phone_number".tr,
                            textAlign: TextAlign.right,
                            style: Constants.mainTitleRegularFont,
                          ),
                          FadeTransition(
                            opacity: _fadeController,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: MyIntlPhoneField(
                                countries: const ['SA'],
                                controller: _phoneController,
                                showDropdownIcon: true,
                                dropdownIcon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.transparent,
                                  size: 6,
                                ),
                                style: Constants.subtitleFont1,
                                // dropdownIconPosition: IconPosition.trailing,
                                textAlign: TextAlign.right,
                                decoration: InputDecoration(
                                  hintText: "رقم الجوال...",
                                  hintStyle: Constants.subtitleRegularFontHint,
                                  errorStyle: Constants.subtitleFont1.copyWith(
                                    color: Colors.red,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    gapPadding: 0,
                                    borderSide: const BorderSide(
                                      color: Color(0xff808488),
                                    ),
                                  ),
                                ),
                                initialCountryCode: 'SA',
                                onChanged: (phone) {
                                  // print(phone.completeNumber);
                                  sendPhone = phone.completeNumber;
                                },
                                invalidNumberMessage:
                                    "invalid_number".tr,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 24,
                                  width: 30,
                                  child: Checkbox(
                                    value: termsVal,
                                    onChanged: (value) {
                                      setState(() {
                                        termsVal = !termsVal;
                                      });
                                    },
                                  ),
                                ),
                                const Text(
                                  "أوافق علي جميع الشروط و الأحكام",
                                  style: Constants.secondaryTitleRegularFont,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          state is MobLoading
                              ? const Center(child: CircularProgressIndicator.adaptive())
                              : FadeTransition(
                                  opacity: _fadeController,
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 48,
                                    child: MyButton(
                                      isBold: true,
                                      txt: "التالي",
                                      onPressedHandler: () {
                                        if (!termsVal) {
                                          MyApplication.showToastView(
                                              message:
                                                  "فضلا وافق علي الشروط و الأحكام");
                                        } else if (_formKey.currentState!
                                            .validate()) {
                                          context
                                              .read<MobCubit>()
                                              .checkMobMethod(
                                                  context: context,
                                                  phone: sendPhone);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: height(context) * 0.2,
                          ),

                          FadeTransition(
                            opacity: _fadeController,
                            child: Center(
                              child: SizedBox(
                                width: width(context) * 0.36,
                                height: 48,
                                child: MyButton(
                                  isBold: true,
                                  txt: "login_guest".tr,
                                  onPressedHandler: () {},
                                ),
                              ),
                            ),
                          ),

                          // Center(
                          //   child: SizedBox(
                          //     width: MediaQuery.of(context).size.width * 0.3,
                          //     child: ElevatedButton(
                          //       onPressed: () {},
                          //       child: Center(
                          //         child: Text(
                          //           "login_guest")!,
                          //           style: Constants.secondaryTitleRegularFont.copyWith(
                          //             color: Colors.white,
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:password_text_field/password_text_field.dart';
//
// import '../../../../app/constants.dart';
// import '../../../../app/utils/lang/language_constants.dart';
// import '../../../../app/utils/my_application.dart';
// import '../../../widgets/shared.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.ltr,
//       child: GestureDetector(
//         onTap: () {
//           MyApplication.dismissKeyboard(context);
//         },
//         child: Scaffold(
//           resizeToAvoidBottomInset: false,
//           body: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Center(
//                 child: Padding(
//               padding: EdgeInsets.only(
//                 bottom: MediaQuery.of(context).viewInsets.bottom,
//               ),
//               child: SingleChildScrollView(
//                   keyboardDismissBehavior:
//                       ScrollViewKeyboardDismissBehavior.onDrag,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       // SvgPicture.asset(
//                       //   'assets/images/SVGs/logo.svg',
//                       //   width: 24,
//                       //   height: 24,
//                       // ),
//                       Text(
//                         "phone_number")!,
//                         textAlign: TextAlign.right,
//                         style: Constants.mainTitleRegularFont,
//                       ),
//                       IntlPhoneField(
//                         controller: _phoneController,
//                         showDropdownIcon: true,
//                         dropdownIcon: const Icon(Icons.arrow_drop_down,
//                             color: Colors.transparent),
//                         style: Constants.subtitleFont1,
//                         dropdownIconPosition: IconPosition.leading,
//                         textAlign: TextAlign.right,
//                         decoration: InputDecoration(
//                           errorStyle: Constants.subtitleFont1.copyWith(
//                             color: Colors.red,
//                           ),
//                           suffixIcon: MyPrefixWidget(
//                               svgString: "assets/images/SVGs/phone.svg"),
//                           // labelText: 'Phone Number',
//                           border: const OutlineInputBorder(
//                             gapPadding: 0,
//                             borderSide: BorderSide(),
//                           ),
//                         ),
//                         initialCountryCode: 'SA',
//                         onChanged: (phone) {
//                           print(phone.completeNumber);
//                         },
//                         invalidNumberMessage:
//                             "invalid_number")!,
//                       ),
//                       const SizedBox(
//                         height: 16,
//                       ),
//                       Text(
//                         "password")!,
//                         textAlign: TextAlign.right,
//                         style: Constants.mainTitleRegularFont,
//                       ),
//                       Directionality(
//                         textDirection: TextDirection.rtl,
//                         child: PasswordTextFormField(
//                           style: Constants.subtitleFont1,
//                           autovalidateMode: AutovalidateMode.onUserInteraction,
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return getTranslated(
//                                   context, "password_required")!;
//                             }
//                             if (value.length < 6) {
//                               return "password_length")!;
//                             }
//                             return null;
//                           },
//                           decoration: InputDecoration(
//                             errorStyle: Constants.subtitleFont1.copyWith(
//                               color: Colors.red,
//                             ),
//                             prefixIcon: MyPrefixWidget(
//                                 svgString: "assets/images/SVGs/key.svg"),
//                             // labelText: 'Password',
//                             border: const OutlineInputBorder(
//                               borderSide: BorderSide(),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 32,
//                       ),
//                       SizedBox(
//                         width: double.infinity,
//                         height: 48,
//                         child: ElevatedButton(
//                           onPressed: () {},
//                           child: Text(
//                             "login")!,
//                             style: Constants.secondaryTitleFont.copyWith(
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 16,
//                       ),
//                       Center(
//                         child: Text("forgot_password")!,
//                             textAlign: TextAlign.center,
//                             style: Constants.subtitleFont),
//                       ),
//                       const SizedBox(
//                         height: 30,
//                       ),
//                       SizedBox(
//                           width: double.infinity,
//                           child: Text("no_account")!,
//                               textAlign: TextAlign.center,
//                               style: Constants.subtitleRegularFontHint)),
//                       SizedBox(
//                         width: double.infinity,
//                         child: TextButton(
//                             onPressed: (() {}),
//                             child: Text(
//                               "create_new_account")!,
//                               style: Constants.mainTitleFont,
//                             )),
//                       ),
//                       const SizedBox(
//                         height: 30,
//                       ),
//                       Center(
//                         child: SizedBox(
//                           width: MediaQuery.of(context).size.width * 0.3,
//                           child: ElevatedButton(
//                             onPressed: () {},
//                             child: Center(
//                               child: Text(
//                                 "login_guest")!,
//                                 style: Constants.secondaryTitleRegularFont
//                                     .copyWith(
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   )),
//             )),
//           ),
//         ),
//       ),
//     );
//   }
// }