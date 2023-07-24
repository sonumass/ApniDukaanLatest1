import 'package:shared_preferences/shared_preferences.dart';

import 'app_preference_key.dart';

class AppPreferences {
  final SharedPreferences sharedPreferences;

  AppPreferences({required this.sharedPreferences});

  Future<bool> _saveString(String key, String? value) {
    return sharedPreferences.setString(key, value ?? "");
  }

  Future<bool> _saveStringList(String key, List<String> value) {
    return sharedPreferences.setStringList(key, value);
  }

  List<String>? _getListString(
    String key,
  ) {
    return sharedPreferences.getStringList(key) ?? [];
  }

  String? _getString(String key, {String defaultValue = ""}) {
    return sharedPreferences.getString(key) ?? defaultValue;
  }

  Future<bool> _saveBoolean(String key, bool value) {
    return sharedPreferences.setBool(key, value);
  }

  bool getBoolean(String key, {bool defaultValue = false}) {
    return sharedPreferences.getBool(key) ?? false;
  }

  int _getInt(String key, {int defaultValue = 0}) {
    final str = _getString(key, defaultValue: defaultValue.toString());
    final value = int.tryParse(str!);
    if (value != null) {
      return value;
    }
    return defaultValue;
  }

  Future<void> saveEmail(String email) {
    return _saveString(AppPreferenceKey.keyEmail, email);
  }

  String get email {
    return _getString(AppPreferenceKey.keyEmail, defaultValue: "")!;
  }

  Future<void> saveAuthToken(String toke) {
    return _saveString(AppPreferenceKey.authToken, toke);
  }

  String get authToken {
    return _getString(AppPreferenceKey.authToken, defaultValue: "")!;
  }

  Future<void> saveUserId(String userId) {
    return _saveString(AppPreferenceKey.userId, userId);
  }

  String get userId {
    return _getString(AppPreferenceKey.userId, defaultValue: "")!;
  }

  Future<void> saveUserImage(String userImage) {
    return _saveString(AppPreferenceKey.userImage, userImage);
  }

  String get userImage {
    return _getString(AppPreferenceKey.userImage, defaultValue: "")!;
  }

  Future<void> saveUserName(String userName) {
    return _saveString(AppPreferenceKey.userName, userName);
  }

  String get userName {
    return _getString(AppPreferenceKey.userName, defaultValue: "")!;
  }

  Future<void> saveAddress(String address) {
    return _saveString(AppPreferenceKey.address, address);
  }

  String get address {
    return _getString(AppPreferenceKey.address, defaultValue: "")!;
  }

  Future<void> saveImg(String img) {
    return _saveString(AppPreferenceKey.img, img);
  }

  String get profileImage {
    return _getString(AppPreferenceKey.img, defaultValue: "")!;
  }

  Future<void> saveMobile(String mobile) {
    return _saveString(AppPreferenceKey.mobile, mobile);
  }

  String get mobile {
    return _getString(AppPreferenceKey.mobile, defaultValue: "")!;
  }

  Future<void> saveReferralCode(String refferalCode) {
    return _saveString(AppPreferenceKey.refferalCode, refferalCode);
  }

  String get refferalCode {
    return _getString(AppPreferenceKey.refferalCode, defaultValue: "")!;
  }

  Future<void> saveLoggedIn(bool loggedIn) {
    return _saveBoolean(AppPreferenceKey.loggedIn, loggedIn);
  }

  bool get isLoggedIn {
    return getBoolean(AppPreferenceKey.loggedIn);
  }

  Future<void> saveUserExit(bool userExist) {
    return _saveBoolean(AppPreferenceKey.userExist, userExist);
  }

  bool get isUserExist {
    return getBoolean(AppPreferenceKey.userExist);
  }
  Future<void> savePopUp(bool showPopUp) {
    return _saveBoolean(AppPreferenceKey.showPopUp, showPopUp);
  }

  bool get isShow {
    return getBoolean(AppPreferenceKey.showPopUp);
  }

  /*bool get userName {
    return _getInt(AppPreferenceKey.loggedIn,defaultValue: false)!;
  }*/
  Future<void> saveStoreId(String userId) {
    return _saveString(AppPreferenceKey.storeId, userId);
  }

  String get storeId {
    return _getString(AppPreferenceKey.storeId, defaultValue: "0")!;
  }

  Future<void> saveBanner(List<String> banner) {
    return _saveStringList(AppPreferenceKey.banner, banner);
  }

  List<String> get banner {
    return _getListString(AppPreferenceKey.banner)!;
  }

  Future<void> saveTutorialShow(bool tutorialShow) {
    return _saveBoolean(AppPreferenceKey.tutorialShow, tutorialShow);
  }

  bool get isTutorialShow {
    return getBoolean(AppPreferenceKey.tutorialShow);
  }

  void logOut() {
    saveLoggedIn(false);
    saveUserName("");
    saveUserImage("");
    saveEmail("");
  }
}
