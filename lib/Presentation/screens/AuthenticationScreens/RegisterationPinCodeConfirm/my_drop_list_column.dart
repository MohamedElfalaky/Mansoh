import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nasooh/Data/cubit/authentication/country_cubit/country_state.dart';
import '../../../../Data/cubit/authentication/city_cubit/city_cubit.dart';
import '../../../../Data/cubit/authentication/city_cubit/city_state.dart';
import '../../../../Data/cubit/authentication/country_cubit/country_cubit.dart';
import '../../../../app/constants.dart';

String? inputCountry;
String? inputCity;
String? inputNationality;

class CusDropData<T> extends StatelessWidget {
  final dynamic value;
  final String hintData;
  final List<DropdownMenuItem<String>>? items;
  final void Function(dynamic)? onChanged;
  final Widget? prefixIcon;

  const CusDropData({
    Key? key,
    this.prefixIcon,
    required this.value,
    required this.hintData,
    required this.onChanged,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
          height: MediaQuery.of(context).size.height * 0.06,
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFBDBDBD)),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: DropdownButtonHideUnderline(
            child: DropdownButtonFormField<dynamic>(
              menuMaxHeight: 300.0,
              decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  prefixIcon: Padding(
                    padding: const EdgeInsetsDirectional.only(
                        start: 12, end: 6, top: 10, bottom: 10),
                    child: Container(
                      width: 30,
                      decoration: const BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  width: 1, color: Color(0xFFBDBDBD)))),
                      margin: const EdgeInsetsDirectional.only(end: 8),
                      padding: const EdgeInsetsDirectional.only(end: 8),
                      child: prefixIcon,
                    ),
                  ),
                  hintText: hintData,
                  hintStyle: const TextStyle(
                    fontFamily: Constants.mainFont,
                    fontSize: 14,
                    color: Constants.fontHintColor,
                  )),
              icon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Icon(Icons.keyboard_arrow_down_rounded,
                    color: Color(0xFFBDBDBD)),
              ),
              isExpanded: true,
              value: value,
              items: items,
              onChanged: onChanged,
            ),
          )),
    );
  }
}

class MyColumnData extends StatefulWidget {
  const MyColumnData({super.key});

  @override
  State<MyColumnData> createState() => _MyColumnDataState();
}

class _MyColumnDataState extends State<MyColumnData> {
  String? countryValue;
  String? cityValue;
  String? nationalityValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TitleTxt(
          txt: "nationality_optional".tr,
        ),
        BlocBuilder<CountryCubit, CountryState>(builder: (context, newState) {
          if (newState is NationalityLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 24),
                    child: CusDropData(
                        hintData: "سعودي",
                        value: nationalityValue,
                        items: newState.response!.data!
                            .map(
                              (e) => DropdownMenuItem(
                                  value: e.id.toString(), child: Text(e.name!)),
                            )
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            nationalityValue = val;
                            inputNationality = nationalityValue;
                          });
                        },
                        prefixIcon: SvgPicture.asset(
                          'assets/images/SVGs/flag.svg',
                          height: 24,
                        ))),
                TitleTxt(
                  txt: "resident_country".tr,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 24),
                  child: CusDropData(
                      hintData: "السعودية",
                      value: countryValue,
                      onChanged: (val) {
                        setState(() {
                          countryValue = val;
                          inputCountry = countryValue;
                        });

                        context.read<CityCubit>().getCities(inputCountry!);
                      },
                      items: newState.response!.data!
                          .map((e) => DropdownMenuItem(
                              value: e.id.toString(), child: Text(e.name!)))
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
        TitleTxt(
          txt: "resident_city".tr,
        ),
        BlocBuilder<CityCubit, CityState>(builder: (context, cityState) {
          if (cityState is CityLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (cityState is CityLoaded) {
            return Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 24),
              child: CusDropData(
                  hintData: "جدة",
                  value: cityValue,
                  onChanged: (val) {
                    setState(() {
                      cityValue = val;
                      inputCity = cityValue;
                    });
                    // print("$inputCity is CityChosen");
                  },
                  items: cityState.response!.data!
                      .map(
                        (e) => DropdownMenuItem(
                            value: e.id.toString(), child: Text(e.name!)),
                      )
                      .toList(),
                  prefixIcon: SvgPicture.asset(
                    'assets/images/SVGs/city1.svg',
                    height: 24,
                  )),
            );
          } else if (cityState is CityError) {
            return const SizedBox();
          } else {
            return const SizedBox();
          }
        }),
      ],
    );
  }
}

class InputTextField extends StatelessWidget {
  const InputTextField(
      {super.key,
      this.controller,
      this.keyboardType,
      this.validator,
      this.onChanged,
      required this.imageTxt,
      required this.hintTxt});

  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String imageTxt;
  final String hintTxt;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20, top: 10),
        child: TextFormField(
          validator: validator ??
              (val) {
                return null;
              },
          controller: controller,
          onChanged: onChanged,
          keyboardType: keyboardType,
          decoration: Constants.setRegistrationTextInputDecoration(
              hintText: hintTxt,
              prefixIcon: SvgPicture.asset(
                imageTxt,
                height: 24,
              )).copyWith(),
        ),
      ),
    );
  }
}

class TitleTxt extends StatelessWidget {
  const TitleTxt({super.key, required this.txt});

  final String txt;

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      textAlign: TextAlign.right,
      style: Constants.secondaryTitleRegularFont,
    );
  }
}
