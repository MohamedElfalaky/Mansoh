import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nasooh/Data/cubit/profile/profile_cubit/profile_cubit.dart';
import 'package:nasooh/app/utils/shared_preference_class.dart';
import '../../../../Data/cubit/authentication/city_cubit/city_cubit.dart';
import '../../../../Data/cubit/authentication/city_cubit/city_state.dart';
import '../../../../Data/cubit/authentication/country_cubit/country_cubit.dart';
import '../../../../Data/cubit/authentication/country_cubit/country_state.dart';
import '../../../../Data/cubit/profile/profile_cubit/profile_state.dart';
import '../../../../Data/cubit/profile/update_profile_cubit/update_profile_cubit.dart';
import '../../../../Data/cubit/profile/update_profile_cubit/update_profile_state.dart';
import '../../../../app/Style/icons.dart';
import '../../../../app/Style/sizes.dart';
import '../../../../app/constants.dart';
import '../../../../app/utils/my_application.dart';
import '../../../widgets/row_modal_sheet.dart';
import '../../../widgets/shared.dart';
import '../../AuthenticationScreens/RegisterationPinCodeConfirm/my_drop_list_column.dart';
import 'widgets/shared.dart';

class UserProfileEdit extends StatefulWidget {
  const UserProfileEdit({super.key});

  @override
  State<UserProfileEdit> createState() => _UserProfileEditState();
}

class _UserProfileEditState extends State<UserProfileEdit>
    with TickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String? nationalityValue;
  String? countryValue;
  String? cityValue;
  String? genderValue;
  String? phoneNumber;
  static final ImagePicker _picker = ImagePicker();
  static XFile? regImage;

  String base64NewImage = "";

  Future pickImage(ImageSource source, BuildContext context, setState) async {
    final myImage = await _picker.pickImage(source: source, imageQuality: 60);
    if (myImage == null) return;

    setState(() {
      regImage = myImage;
    });
    List<int> imageBytes = File(regImage!.path).readAsBytesSync();
    base64NewImage = base64.encode(imageBytes);
    log("base64Image!  is $base64NewImage");

    if (mounted) {
      Navigator.pop(context);
    }
  }

  late AnimationController _animationController;
  late AnimationController _fadeController;
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _fadeController.dispose();
  }

  Future<void> getDataFromApi() async {
    if (mounted) {
      await context.read<ProfileCubit>().getDataProfile();
    }
    if (mounted) {
      await context.read<CountryCubit>().getCountries();
    }

    late ProfileCubit profileCubit;
    if (mounted) {
      profileCubit = ProfileCubit.get(context);
    }
    _nameController.text = profileCubit.profileModel?.data?.fullName ?? "";
    _emailController.text = profileCubit.profileModel?.data?.email ?? "";
    _phoneController.text =
        profileCubit.profileModel?.data?.mobile?.substring(5, 14) ?? "";
    setState(() {
      genderValue = profileCubit.profileModel?.data?.gender ?? "";
    });

    if (profileCubit.profileModel?.data?.nationalityId != null) {
      nationalityValue =
          profileCubit.profileModel?.data?.nationalityId?.id.toString();
    }
    if (profileCubit.profileModel?.data?.countryId != null) {
      countryValue = profileCubit.profileModel?.data?.countryId?.id.toString();
    }
    if (profileCubit.profileModel?.data?.cityId != null) {
      cityValue = profileCubit.profileModel?.data?.cityId!.id.toString();
    }
  }

  @override
  void initState() {
    getDataFromApi();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));
    _animationController.forward();

    _fadeController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    _fadeController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MyApplication.dismissKeyboard(context);
      },
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size(double.infinity, 100),
          child: Padding(
            padding: EdgeInsets.only(top: 40, right: 20),
            child: Back(header: "Update Profile"),
          ),
        ),
        bottomNavigationBar:
            BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
                builder: (context, state) => state is UpdateProfileLoading
                    ? const CircularProgressIndicator.adaptive()
                    : buildSaveButton(
                        label: "save",
                        onPressed: () {
                          context.read<UpdateProfileCubit>().updateMethod(
                              context: context,
                              nationalityId: nationalityValue ?? "",
                              gender: genderValue,
                              fullName: _nameController.text,
                              email: _emailController.text,
                              cityId: cityValue ?? "",
                              countryId: countryValue ?? "",
                              avatar: base64NewImage,
                              mobile: phoneNumber ??
                                  "+966${_phoneController.text}");
                        })),
        resizeToAvoidBottomInset: false,
        body: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, profileState) {
          if (profileState is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (profileState is ProfileLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                      height: 190,
                      width: 190,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Center(
                            child: DottedBorder(
                                color: Constants.outLineColor,
                                borderType: BorderType.Circle,
                                radius: const Radius.circular(20),
                                dashPattern: const [10, 6],
                                child: Padding(
                                    padding: const EdgeInsets.all(6),
                                    child: CircleAvatar(
                                      radius: width(context) * 0.19,
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: sharedPrefs
                                                      .getUserPhoto() ==
                                                  "" &&
                                              regImage == null
                                          ? const AssetImage(
                                              'assets/images/PNG/no_profile_photo.png')
                                          : regImage == null
                                              ? NetworkImage(
                                                  sharedPrefs.getUserPhoto())
                                              : FileImage(
                                                  File(regImage!.path),
                                                ) as ImageProvider,
                                    ))),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(25.0),
                                    ),
                                  ),
                                  builder: (ctx) {
                                    return Container(
                                        padding: const EdgeInsets.all(18),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            RowModalSheet(
                                                txt: "كاميرا",
                                                imageIcon: cameraIcon,
                                                onPressed: () {
                                                  pickImage(ImageSource.camera,
                                                      ctx, setState);
                                                }),
                                            const Divider(),
                                            RowModalSheet(
                                              txt: "الاستديو",
                                              imageIcon: galleryIcon,
                                              onPressed: () {
                                                pickImage(ImageSource.gallery,
                                                    ctx, setState);
                                              },
                                            ),
                                            const Divider(),
                                            RowModalSheet(
                                              txt: "الغاء",
                                              imageIcon: closeIcon,
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            )
                                          ],
                                        ));
                                  },
                                );
                              },
                              child: const CircleAvatar(
                                backgroundColor: Color(0XFF444444),
                                radius: 20,
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      child: Text("Personal Information".tr,
                          textAlign: TextAlign.end,
                          style: Constants.subtitleFontBold
                              .copyWith(fontSize: 16))),
                  const SizedBox(height: 8),
                  TitleTxt(
                    txt: "Name".tr,
                  ),
                  InputTextField(
                    keyboardType: TextInputType.text,
                    hintTxt: "Name".tr,
                    imageTxt: "assets/images/SVGs/name_icon.svg",
                    controller: _nameController,
                  ),
                  TitleTxt(
                    txt: "email".tr,
                  ),
                  InputTextField(
                    keyboardType: TextInputType.emailAddress,
                    hintTxt: "example@example.com",
                    imageTxt: "assets/images/SVGs/email_icon.svg",
                    controller: _emailController,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: MySeparator(),
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Text("Additional Information".tr,
                          textAlign: TextAlign.end,
                          style: Constants.subtitleFontBold
                              .copyWith(fontSize: 16))),
                  const SizedBox(
                    height: 16,
                  ),
                  TitleTxt(
                    txt: "nationality_optional".tr,
                  ),
                  BlocBuilder<CountryCubit, CountryState>(
                      builder: (context, newState) {
                    if (newState is CountryLoaded) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 24),
                              child: CusDropData(
                                  hintData: "برجاء اختيار الجنسية",
                                  value: nationalityValue,
                                  items: newState.response!.data!.nationailties!
                                      .map(
                                        (e) => DropdownMenuItem(
                                            value: e.id.toString(),
                                            child: Text(
                                              e.name!,
                                              style: const TextStyle(
                                                  fontFamily: 'Cairo',
                                                  fontSize: 14),
                                            )),
                                      )
                                      .toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      nationalityValue = val;
                                    });
                                  },
                                  prefixIcon: SvgPicture.asset(
                                      'assets/images/SVGs/flag.svg',
                                      height: 24))),
                          TitleTxt(txt: "resident_country".tr),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 24),
                            child: CusDropData(
                                hintData: "السعودية",
                                value: countryValue,
                                onChanged: (val) {
                                  setState(() {
                                    countryValue = val;
                                  });

                                  context
                                      .read<CityCubit>()
                                      .getCities(countryValue!.toString());
                                },
                                items: newState.response!.data!.countries!
                                    .map((e) => DropdownMenuItem(
                                        value: e.id.toString(),
                                        child: Text(e.name!,
                                            style: const TextStyle(
                                                fontFamily: 'Cairo',
                                                fontSize: 14))))
                                    .toList(),
                                prefixIcon: SvgPicture.asset(
                                  "assets/images/SVGs/country.svg",
                                  height: 24,
                                )),
                          )
                        ],
                      );
                    }
                    return const Center(child: SizedBox());
                  }),
                  BlocBuilder<CityCubit, CityState>(
                      builder: (context, cityState) {
                    if (cityState is CityLoading) {
                      return const Center(
                          child: CircularProgressIndicator.adaptive());
                    } else if (cityState is CityLoaded) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleTxt(
                            txt: "resident_city".tr,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 24),
                            child: CusDropData(
                                hintData: "جدة",
                                value: cityValue,
                                onChanged: (val) {
                                  setState(() {
                                    cityValue = val;
                                  });
                                },
                                items: cityState.response!.data!
                                    .map(
                                      (e) => DropdownMenuItem(
                                          value: e.id.toString(),
                                          child: Text(e.name!,
                                              style: const TextStyle(
                                                  fontFamily: 'Cairo',
                                                  fontSize: 14))),
                                    )
                                    .toList(),
                                prefixIcon: SvgPicture.asset(
                                  'assets/images/SVGs/city1.svg',
                                  height: 24,
                                )),
                          ),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  }),
                  TitleTxt(txt: "gender".tr),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("female".tr,
                          style: Constants.secondaryTitleRegularFont),
                      Radio(
                          value: "0",
                          groupValue: genderValue,
                          onChanged: (s) {
                            setState(() {
                              genderValue = s;
                            });
                          }),
                      const SizedBox(
                        width: 40,
                      ),
                      Text(
                        "male".tr,
                        style: Constants.secondaryTitleRegularFont,
                      ),
                      Radio(
                          value: "1",
                          groupValue: genderValue,
                          onChanged: (s) {
                            setState(() {
                              genderValue = s;
                            });
                          }),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              )),
            );
          }
          return const SizedBox.shrink();
        }),
      ),
    );
  }
}
