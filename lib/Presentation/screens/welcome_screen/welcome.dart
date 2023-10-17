import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/Data/cubit/authentication/login_cubit/login_cubit.dart';
import 'package:nasooh/Data/cubit/authentication/login_cubit/login_state.dart';
import 'package:nasooh/Presentation/screens/AuthenticationScreens/LoginScreen/check_mob_screen.dart';
import 'package:nasooh/Presentation/widgets/MyButton.dart';
import 'package:nasooh/app/Style/Icons.dart';
import '../../../../app/Style/sizes.dart';
import '../../../../app/constants.dart';
import '../../../../app/utils/myApplication.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late AnimationController _fadeController;

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
                    child: BlocBuilder<LoginCubit, LoginState>(
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
                          SizedBox(height: height(context) * 0.04),
                          Center(
                              child: SizedBox(
                                  height: 150, child: Image.asset(welcomePNG))),
                          SizedBox(height: height(context) * 0.06),
                          SizedBox(
                              width: double.infinity,
                              child: Text("تبغى نصيحة ممتازة من شخص فاهم",
                                  textAlign: TextAlign.center,
                                  style: Constants.subtitleFontBold
                                      .copyWith(fontSize: 18))),
                          SizedBox(
                              width: double.infinity,
                              child: Text(
                                  " بمجاله بسعر أنت تحدده ويرد عليك بسرعة؟",
                                  textAlign: TextAlign.center,
                                  style: Constants.subtitleFontBold
                                      .copyWith(fontSize: 18))),
                          SizedBox(height: height(context) * 0.015),
                          SizedBox(
                              width: double.infinity,
                              child: Text(
                                  "تطبيق نصوح يساعدك في الحصول على إجابة وافية لكل سؤال",
                                  textAlign: TextAlign.center,
                                  style: Constants.subtitleFont.copyWith(
                                      fontSize: 15,
                                      color: Colors.grey.shade600))),
                          SizedBox(height: height(context) * 0.12),
                          FadeTransition(
                            opacity: _fadeController,
                            child: SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: MyButton(
                                isBold: true,
                                txt: "ابدأ الان",
                                onPressedHandler: () {
                                  MyApplication.navigateTo(
                                      context, const CheckMobScreen());
                                },
                              ),
                            ),
                          ),
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
