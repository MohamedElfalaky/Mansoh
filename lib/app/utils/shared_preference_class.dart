import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? sharedPrefs;

  Future<void> init() async {
    sharedPrefs = await SharedPreferences.getInstance();
  }

  String get fCMToken => sharedPrefs!.getString(fcmkey) ?? "";

  String get getUserName {
    return sharedPrefs!.getString(keyUserName) ?? "";
  }

  String get getUserNationality {
    return sharedPrefs!.getString(userNationality) ?? "";
  }

  String get getUserCountry {
    return sharedPrefs!.getString(userCountry) ?? "";
  }
  String get getUserCity {
    return sharedPrefs!.getString(userCity) ?? "";
  }

  String getUserPhoto() {
    return sharedPrefs!.getString(keyUserPhoto) ?? "";
  }

  setIsUnBoarded(bool value) {
    sharedPrefs!.setBool(keyUnBoarded, value);
  }

  setPickDialogHasBeenShown(bool value) {
    sharedPrefs!.setBool(keyShowPickDialog, value);
  }

  setUserName(String value) {
    sharedPrefs!.setString(keyUserName, value);
  }

  setUserNationality(String value) {
    sharedPrefs!.setString(userNationality, value);
  }


  setUserCountry(String value) {
    sharedPrefs!.setString(userCountry, value);
  }

  setUserCity(String value) {
    sharedPrefs!.setString(userCity, value);
  }  setUserType(String value) {
    sharedPrefs!.setString(userType, value);
  }
  setUserPhoto(String value) {
    sharedPrefs!.setString(keyUserPhoto, value);
  }

  setIsSignedIn(bool value) {
    sharedPrefs!.setBool(keySignedIn, value);
  }

  String getToken() {
    return sharedPrefs!.getString(keyToken) ?? '';
  }

  setToken(String value) {
    sharedPrefs!.setString(keyToken, value);
  }

  setId(int value) {
    sharedPrefs!.setInt(idKey, value);
  }

  getId() {
    return sharedPrefs!.getInt(idKey);
  }

  dynamic getReceiveMethod() {
    return sharedPrefs!.getInt(receiveMethodKey);
  }

  setReceiveMethod(int value) {
    sharedPrefs!.setInt(receiveMethodKey, value);
  }

  setAmount(int value) {
    sharedPrefs!.setInt(cartamount, value);
  }

  void removeamount() {
    sharedPrefs!.remove(cartamount);
  }

  setFCM(String value) {
    sharedPrefs!.setString(fcmkey, value);
  }

  setIscurrentAddress(bool value) {
    sharedPrefs!.setBool(currentAddredd, value);
  }

  void removeToken() {
    sharedPrefs!.remove(keyToken);
  }

  void removeFCM() {
    sharedPrefs!.remove(fcmkey);
  }

  void removeAmount() {
    sharedPrefs!.remove(cartAmount);
  }

  String getLanguage() {
    return sharedPrefs!.getString(langCode) ?? '';
  }

  setLanguage(String value) {
    sharedPrefs!.setString(langCode, value);
  }

  setIsCurrentAddress(bool value) {
    sharedPrefs!.setBool(currentAddress, value);
  }

  bool getCurrentAddress() {
    return sharedPrefs!.getBool(currentAddredd) ?? true;
  }

  setIsNotification(int value) {
    sharedPrefs!.setInt("isNotification", value);
  }

  int getIsNotification() {
    return sharedPrefs!.getInt("isNotification") ?? 0;
  }
}

final sharedPrefs = SharedPrefs();

const String langCode = 'languageCode';

const String keyToken = "key_token";
String pickupMethod = "pickupMethod_key";
String keySignedIn = "signed_in";
String keyUnBoarded = "key_unBoarded";
String keyShowPickDialog = "key_show_pick_dialog";
String keyUserName = "key_user_name";
String cartAmount = "cartAmount";
String keyUserPhoto = "key_user_photo";
String currentAddress = 'currentAddress';
String receiveMethodKey = 'receive_method_key';
String cartamount = "amountcart";
String currentAddredd = 'currentAddress';
String fcmkey = "Fcm_key";
String idKey = "idKey";
String userNationality = "userNationality";
String userCountry = "userCountry";
String userCity = "userCity";
String userType = "userType";
