import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasooh/Data/cubit/send_chat_cubit/send_chat_cubit.dart';
import 'package:nasooh/Data/cubit/show_advice_cubit/show_advice_cubit/show_advice_cubit.dart';
import '../../Data/cubit/advisor_profile_cubit/profile_cubit.dart';
import '../../Data/cubit/authentication/category_cubit/category_cubit.dart';
import '../../Data/cubit/authentication/check_code/check_code_cubit.dart';
import '../../Data/cubit/authentication/city_cubit/city_cubit.dart';
import '../../Data/cubit/authentication/country_cubit/country_cubit.dart';
import '../../Data/cubit/authentication/get_by_token_cubit/get_by_token_cubit.dart';
import '../../Data/cubit/authentication/get_user_by_mob_cubit/get_user_cubit.dart';
import '../../Data/cubit/authentication/log_out_cubit/log_out_cubit.dart';
import '../../Data/cubit/authentication/login_cubit/login_cubit.dart';
import 'package:provider/single_child_widget.dart';
import '../../Data/cubit/authentication/new_mob/mob_cubit.dart';
import '../../Data/cubit/authentication/register_cubit/register_cubit.dart';
import '../../Data/cubit/home/advisor_list_cubit.dart';
import '../../Data/cubit/home/home_slider_cubit.dart';
import '../../Data/cubit/orders_cubit/orders_filters_cubit/orders_filters_cubit.dart';
import '../../Data/cubit/orders_cubit/orders_status_cubit/orders_status_cubit.dart';
import '../../Data/cubit/profile/profile_cubit/profile_cubit.dart';
import '../../Data/cubit/profile/update_profile_cubit/update_profile_cubit.dart';
import '../../Data/cubit/send_advice_cubit/send_advise_cubit.dart';
import '../../Data/cubit/settings_cubits/privacy_cubit/privacy_cubit.dart';
import '../../Data/cubit/show_advice_cubit/done_advice_cubit/done_advice_cubit.dart';
import '../../Data/cubit/show_advice_cubit/pay_advice_cubit/pay_advice_cubit.dart';
import '../../Data/cubit/show_advice_cubit/payment_list_cubit/payment_list_cubit.dart';

List<SingleChildWidget> providers = [
  BlocProvider<LoginCubit>(create: (context) => LoginCubit()),
  BlocProvider<MobCubit>(create: (context) => MobCubit()),
  BlocProvider<CheckCodeCubit>(create: (context) => CheckCodeCubit()),
  BlocProvider<CountryCubit>(create: (context) => CountryCubit()
      // ..getNationalities()..getCountries()
      ),
  // BlocProvider<NationalityCubit>(create: (context) => NationalityCubit()),
  BlocProvider<CityCubit>(create: (context) => CityCubit()),
  BlocProvider<RegisterCubit>(create: (context) => RegisterCubit()),
  BlocProvider<ProfileCubit>(
      create: (context) => ProfileCubit()..getDataProfile()),
  BlocProvider<LogOutCubit>(create: (context) => LogOutCubit()),
  BlocProvider<UpdateProfileCubit>(create: (context) => UpdateProfileCubit()),
  BlocProvider<GetUserCubit>(create: (context) => GetUserCubit()),
  BlocProvider<HomeSliderCubit>(create: (context) => HomeSliderCubit()),
  BlocProvider<AdvisorListCubit>(create: (context) => AdvisorListCubit()),
  BlocProvider<AdvisorProfileCubit>(create: (context) => AdvisorProfileCubit()),
  BlocProvider<SendAdviseCubit>(create: (context) => SendAdviseCubit()),
  BlocProvider<PaymentListCubit>(create: (context) => PaymentListCubit()),
  BlocProvider<GetByTokenCubit>(create: (context) => GetByTokenCubit()),
  BlocProvider<ShowAdviceCubit>(create: (context) => ShowAdviceCubit()),
  BlocProvider<PayAdviceCubit>(create: (context) => PayAdviceCubit()),
  BlocProvider<OrdersStatusCubit>(create: (context) => OrdersStatusCubit()),
  BlocProvider<OrdersFiltersCubit>(create: (context) => OrdersFiltersCubit()),
  BlocProvider<CategoryCubit>(create: (context) => CategoryCubit()),
  BlocProvider<PrivacyCubit>(create: (context) => PrivacyCubit()),
  BlocProvider<DoneAdviceCubit>(create: (context) => DoneAdviceCubit()),
  BlocProvider<SendChatCubit>(create: (context) => SendChatCubit()),
];
