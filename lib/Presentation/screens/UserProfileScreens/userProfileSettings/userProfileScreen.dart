import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:nasooh/app/utils/myApplication.dart';
import '../../../../../app/utils/lang/language_constants.dart';
import '../../../../Data/cubit/authentication/log_out_cubit/log_out_cubit.dart';
import '../../../../Data/cubit/authentication/log_out_cubit/log_out_state.dart';
import '../../../../app/constants.dart';
import '../../../widgets/shared.dart';
import '../../Home/Home.dart';
import 'widgets/userInfoCard.dart';
import 'widgets/userInfoMenu.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: customABarNoIcon(
            txt: getTranslated(context, "personal_profile")!,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 16),
            child: SingleChildScrollView(
                // physics: const NeverScrollableScrollPhysics(),
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const UserInfoCard(),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => buildMenuItem(
                      SettingsMenuItems.all[index],
                    ),
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.grey[300],
                      height: 1,
                      thickness: 1,
                    ),
                    itemCount: SettingsMenuItems.all.length,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                BlocBuilder<LogOutCubit, LogOutState>(
                  builder: (context, state) => state is LogOutLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ListTile(
                          minLeadingWidth: 0,
                          onTap: () {
                            context.read<LogOutCubit>().logOut(
                                  context: context,
                                );
                          },
                          title: Text(
                            getTranslated(context, "signout")!,
                            style: Constants.mainTitleFont,
                          ),
                          leading: SvgPicture.asset(
                            logoutIcon,
                          ),
                        ),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    width: MediaQuery.of(context).size.width * 0.42,
                    height: 40,
                    decoration: BoxDecoration(color: Constants.primaryAppColor , borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.share, color: Colors.white,),
                        label: Text(
                          getTranslated(context, "share_app")!,
                          style: Constants.subtitleFont1.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text("إذا كنت مختص أو خبير وأردت التسجيل كناصح  حمل تطبيق الناصحين",
                      style: Constants.subtitleRegularFontHint.copyWith(
                        color: Colors.grey[700],
                      )),
                ),
                const SizedBox(height: 15,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  LimitedBox(
                    maxHeight: 35,
                    maxWidth: 35,
                    child: Image.asset(appStoreIcon,fit: BoxFit.fill, width: 35, height: 35,),
                  ),
                  SizedBox(width: 50,),
                  LimitedBox(
                    maxHeight: 35,
                    maxWidth: 35,
                    child: Image.asset(googlePlayIcon,fit: BoxFit.fill, width: 35, height: 35,),
                  ),

                ],)
              ],
            )),
          ),
        ),
      ),
    );
  }
}
