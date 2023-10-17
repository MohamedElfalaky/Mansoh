import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nasooh/Data/cubit/profile/profile_cubit/profile_cubit.dart';
import 'package:nasooh/app/utils/sharedPreferenceClass.dart';
import '../../../../Data/cubit/authentication/city_cubit/city_cubit.dart';
import '../../../../Data/cubit/authentication/city_cubit/city_state.dart';
import '../../../../Data/cubit/authentication/country_cubit/country_cubit.dart';
import '../../../../Data/cubit/authentication/country_cubit/country_state.dart';
import '../../../../Data/cubit/profile/profile_cubit/profile_state.dart';
import '../../../../Data/cubit/profile/update_profile_cubit/update_profile_cubit.dart';
import '../../../../Data/cubit/profile/update_profile_cubit/update_profile_state.dart';
import '../../../../app/Style/Icons.dart';
import '../../../../app/Style/sizes.dart';
import '../../../../app/constants.dart';
import '../../../../app/utils/myApplication.dart';
import '../../../widgets/row_modal_sheet.dart';
import '../../../widgets/shared.dart';
import '../../AuthenticationScreens/RegisterationPinCodeConfirm/my_drop_list_column.dart';
import 'widgets/shared.dart';

class UserProfileEdit extends StatefulWidget {
  const UserProfileEdit({Key? key}) : super(key: key);

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
    try {
      final myImage = await _picker.pickImage(source: source, imageQuality: 60);
      if (myImage == null) return;

      setState(() {
        regImage = myImage;
      });
      List<int> imageBytes = await File(regImage!.path).readAsBytesSync();
      // print(imageBytes);
      base64NewImage = base64.encode(imageBytes);
      // print("inputImagePhoto!.path  is ${regImage!.path}");
      log("base64Image!  is $base64NewImage");
    } on PlatformException catch (e) {
      // print("platform exeption : $e");
    }
    Navigator.pop(context);
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
    await context.read<ProfileCubit>().getDataProfile();
    await context.read<CountryCubit>().getCountries();
    await context.read<CountryCubit>().getNationalities();

    var profileCubit = ProfileCubit.get(context);
    _nameController.text = profileCubit.profileModel?.data?.fullName ?? "";
    _emailController.text = profileCubit.profileModel?.data?.email ?? "";
    _phoneController.text =
        profileCubit.profileModel?.data?.mobile?.substring(5, 14) ?? "";
    // if (profileCubit.profileModel?.data?.gender != "") {
    setState(() {
      genderValue = profileCubit.profileModel?.data?.gender ?? "";
    });

    // print(profileCubit.profileModel?.data?.gender);
    // }
    // nationalityValue = 1;
    if (profileCubit.profileModel?.data?.nationalityId != null) {
      nationalityValue =
          profileCubit.profileModel?.data?.nationalityId?.id.toString();
    }
    if (profileCubit.profileModel?.data?.countryId != null) {
      countryValue = profileCubit.profileModel?.data?.countryId?.id.toString();
      // context.read<CityCubit>().getCities(
      //     profileState.response!.data!.countryId!.id.toString());
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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () {
          MyApplication.dismissKeyboard(context);
        },
        child: SafeArea(
            child: Scaffold(
          floatingActionButton:
              BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
                  builder: (context, state) => state is UpdateProfileLoading
                      ? const CircularProgressIndicator()
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
                            // print(phoneNumber);
                            // print("base64NewImage is $base64NewImage");
                            // print("+966${_phoneController.text}");
                            // print("${_emailController.text}");
                            // print("${_nameController.text}");
                            // print("$cityValue");
                            // print("$countryValue");
                            // print("$nationalityValue");
                            // print(" gender value send $genderValue");
                          })),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          resizeToAvoidBottomInset: false,
          body: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, profileState) {
            if (profileState is ProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (profileState is ProfileLoaded) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Back(header: "Update Profile"),
                          const SizedBox(
                            height: 15,
                          ),
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
                                              backgroundColor:
                                                  Colors.transparent,
                                              backgroundImage:

                                                  sharedPrefs.getUserPhoto() ==
                                                          "" && regImage == null
                                                      ? const AssetImage(
                                                          'assets/images/PNG/no_profile_photo.png')
                                                      :
                                                  regImage == null
                                                          ? NetworkImage(
                                                              sharedPrefs
                                                                  .getUserPhoto())
                                                          :
                                                  FileImage(
                                                              File(regImage!
                                                                  .path),
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
                                            // <-- SEE HERE
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(25.0),
                                            ),
                                          ),
                                          builder: (ctx) {
                                            return Container(
                                                padding:
                                                    const EdgeInsets.all(18),
                                                // height: 100,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    RowModalSheet(
                                                        txt: "كاميرا",
                                                        imageIcon: cameraIcon,
                                                        onPressed: () {
                                                          pickImage(
                                                              ImageSource
                                                                  .camera,
                                                              ctx,
                                                              setState);
                                                          // inputImageName =
                                                          //     RegistrationController
                                                          //         .regImage!.path;
                                                          // inputImagePhoto =
                                                          //     RegistrationController
                                                          //         .regImage;
                                                          // print(
                                                          //     "Image PAth is $inputImageName");
                                                        }),
                                                    const Divider(),
                                                    RowModalSheet(
                                                      txt: "الاستديو",
                                                      imageIcon: galleryIcon,
                                                      onPressed: () {
                                                        pickImage(
                                                            ImageSource.gallery,
                                                            ctx,
                                                            setState);
                                                        // inputImageName =
                                                        //     RegistrationController
                                                        //         .regImage!.path;
                                                        // inputImagePhoto =
                                                        //     RegistrationController
                                                        //         .regImage;
                                                        // print(
                                                        //     "Image path is ${inputImagePhoto!.path}");
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
                          Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                              child: Text(
                                   "Personal Information".tr,
                                  textAlign: TextAlign.end,
                                  style: Constants.subtitleFontBold
                                      .copyWith(fontSize: 16))),
                          const SizedBox(height: 8),
                          TitleTxt(
                            txt:  "Name".tr,
                          ),
                          InputTextField(
                            keyboardType: TextInputType.text,
                            hintTxt:  "Name".tr,
                            imageTxt: "assets/images/SVGs/name_icon.svg",
                            controller: _nameController,
                            onChanged: (val) {
                              // print(_nameController.toString());
                            },
                          ),

                          ///===============
                          // TitleTxt(
                          //   txt:  "phone_number".tr,
                          // ),
                          // FadeTransition(
                          //   opacity: _fadeController,
                          //   child: Padding(
                          //     padding:
                          //         const EdgeInsets.only(top: 10, bottom: 10),
                          //     child: MyIntlPhoneField(
                          //       countries: ['SA'],
                          //       controller: _phoneController,
                          //       showDropdownIcon: true,
                          //       dropdownIcon: const Icon(
                          //         Icons.arrow_drop_down,
                          //         color: Colors.transparent,
                          //         size: 6,
                          //       ),
                          //       style: Constants.subtitleFont1,
                          //       textAlign: TextAlign.right,
                          //       decoration: InputDecoration(
                          //         hintText: "رقم الجوال...",
                          //         hintStyle: Constants.subtitleRegularFontHint,
                          //         errorStyle: Constants.subtitleFont1.copyWith(
                          //           color: Colors.red,
                          //         ),
                          //         contentPadding: const EdgeInsets.symmetric(
                          //             vertical: 10, horizontal: 10),
                          //         border: OutlineInputBorder(
                          //           borderRadius: BorderRadius.circular(20),
                          //           gapPadding: 0,
                          //           borderSide: const BorderSide(
                          //             color: Color(0xff808488),
                          //           ),
                          //         ),
                          //       ),
                          //       initialCountryCode: 'SA',
                          //       onChanged: (phone) {
                          //         print(phone.completeNumber);
                          //         phoneNumber = phone.completeNumber;
                          //       },
                          //       invalidNumberMessage:
                          //            "invalid_number".tr,
                          //     ),
                          //   ),
                          // ),

                          /// =======================

                          TitleTxt(
                            txt:  "email".tr,
                          ),
                          InputTextField(
                            keyboardType: TextInputType.emailAddress,
                            hintTxt: "example@example.com",
                            imageTxt: "assets/images/SVGs/email_icon.svg",
                            controller: _emailController,
                            onChanged: (val) {
                              // print(_emailController.toString());
                            },
                          ),
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: MySeparator(),
                          ),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              child: Text(
                                   "Additional Information".tr,
                                  textAlign: TextAlign.end,
                                  style: Constants.subtitleFontBold
                                      .copyWith(fontSize: 16))),
                          const SizedBox(
                            height: 16,
                          ),
                          TitleTxt(
                            txt:
                                 "nationality_optional".tr,
                          ),
                          BlocBuilder<CountryCubit, CountryState>(
                              builder: (context, newState) {
                            if (newState is NationalityLoaded) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 24),
                                      child: CusDropData(
                                          hintData: "",
                                          value: nationalityValue,
                                          items: newState.response!.data!
                                              .map(
                                                (e) => DropdownMenuItem(
                                                    value: e.id.toString(),
                                                    child: Text(e.name!)),
                                              )
                                              .toList(),
                                          onChanged: (val) {
                                            setState(() {
                                              nationalityValue = val;
                                            });
                                          },
                                          prefixIcon: SvgPicture.asset(
                                            'assets/images/SVGs/flag.svg',
                                            height: 24,
                                          ))),
                                  TitleTxt(
                                    txt:  "resident_country".tr,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 24),
                                    child: CusDropData(
                                        hintData: "السعودية",
                                        value: countryValue,
                                        onChanged: (val) {
                                          setState(() {
                                            countryValue = val;
                                          });

                                          context.read<CityCubit>().getCities(
                                              countryValue!.toString());
                                        },
                                        items: newState.response!.data!
                                            .map((e) => DropdownMenuItem(
                                                value: e.id.toString(),
                                                child: Text(e.name!)))
                                            .toList(),
                                        prefixIcon: SvgPicture.asset(
                                          "assets/images/SVGs/country.svg",
                                          height: 24,
                                        )),
                                  )
                                ],
                              );
                            } else if (newState is NationalityError) {
                              return const Center(child: SizedBox());
                            } else {
                              return const Center(child: SizedBox());
                            }
                          }),

                          BlocBuilder<CityCubit, CityState>(
                              builder: (context, cityState) {
                            if (cityState is CityLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (cityState is CityLoaded) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TitleTxt(
                                    txt:  "resident_city".tr,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 24),
                                    child: CusDropData(
                                        hintData: "جدة",
                                        value: cityValue,
                                        onChanged: (val) {
                                          setState(() {
                                            cityValue = val;
                                          });
                                          // print("$cityValue is CityChosen");
                                        },
                                        items: cityState.response!.data!
                                            .map(
                                              (e) => DropdownMenuItem(
                                                  value: e.id.toString(),
                                                  child: Text(e.name!)),
                                            )
                                            .toList(),
                                        prefixIcon: SvgPicture.asset(
                                          'assets/images/SVGs/city1.svg',
                                          height: 24,
                                        )),
                                  ),
                                ],
                              );
                            } else if (cityState is CityError) {
                              return const SizedBox();
                            } else {
                              return const SizedBox();
                            }
                          }),
                          TitleTxt(
                            txt:  "gender".tr,
                          ),
                          // StatefulBuilder(
                          //     builder: (context, StateSetter setState) =>
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text( "female".tr,
                                  style: Constants.secondaryTitleRegularFont),
                              Radio(
                                  value: "0",
                                  groupValue: genderValue,
                                  onChanged: (s) {
                                    setState(() {
                                      genderValue = s;
                                    });
                                    // print(genderValue);
                                  }),
                              const SizedBox(
                                width: 48,
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
                                    // print(genderValue);
                                  }),
                            ],
                            // )
                          ),
                          const SizedBox(
                            height: 64,
                          ),
                        ],
                      )),
                ),
              );
            } else if (profileState is ProfileError) {
              return const Center(child: SizedBox());
            } else {
              return const Center(child: SizedBox());
            }
          }),
        )),
      ),
    );
  }
}
