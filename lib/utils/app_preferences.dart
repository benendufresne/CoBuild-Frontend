import 'package:cobuild/models/location_model/location_model.dart';
import 'package:cobuild/models/user_model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static late AppPreferences _appPreferences;
  static late SharedPreferences sharedPreferences;

  static const String _isTutorialSeen = '_isTutorialSeen';
  static const String _isLoggedIn = "_isLoggedIn";
  static const String _accessToken = '_accessToken';
  static const String _signProcessCompleted = '_signProcessCompleted';
  static const String _deviceId = '_deviceId';
  static const String _deviceToken = '_deviceToken';

  /// User data
  static const String _name = '_name';
  static const String _email = '_email';
  static const String _phone = '_phone';
  static const String _countryCode = '_countryCode';
  static const String _userId = '_userId';
  static const String _address = '_address';
  static const String _lat = 'lat';
  static const String _long = '_long';
  static const String _jobAddress = '_jobAddress';
  static const String _searchJobLat = '_searchJobLat';
  static const String _searchJobLong = '_searchJobLong';

  // Apple login :- first time email
  static const String _appleEmail = '_appleEmail';

  AppPreferences._internal() {
    init();
  }

  factory AppPreferences() {
    _appPreferences = AppPreferences._internal();
    return _appPreferences;
  }

  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  /// Set data at the time of lgin and sign up :-
  static Future setUserLoginData({required UserModel model}) async {
    if (model.isProfileCompleted ?? false) {
      await setLogInStatus();
    }
    if (model.accessToken?.isNotEmpty ?? false) {
      await setAccessToken(model.accessToken ?? "");
    }
    if (model.location?.coordinates?.isNotEmpty ?? false) {
      await setLat(model.location?.coordinates![1] ?? 0);
      await setLong(model.location?.coordinates![0] ?? 0);
    }
    if (model.userId?.isNotEmpty ?? false) {
      setUserId(model.userId ?? '');
    }
    await setName(model.name ?? "");
    await setEmail(model.email ?? "");
    await setPhoneNumber(model.mobileNo ?? "");
    await setCountryCode(model.countryCode ?? "");
    await setAddress(model.location?.address ?? "");
  }

  /// Set User data
  static Future<void> setName(String name) async {
    await sharedPreferences.setString(_name, name);
  }

  static Future<void> setEmail(String email) async {
    await sharedPreferences.setString(_email, email);
  }

  static Future<void> setPhoneNumber(String phone) async {
    await sharedPreferences.setString(_phone, phone);
  }

  static Future<void> setCountryCode(String countryCode) async {
    await sharedPreferences.setString(_countryCode, countryCode);
  }

  /// Set user addess data
  static Future<void> setAddress(String address) async {
    await sharedPreferences.setString(_address, address);
  }

  static Future<void> setLat(double lat) async {
    await sharedPreferences.setDouble(_lat, lat);
  }

  static Future<void> setLong(double long) async {
    await sharedPreferences.setDouble(_long, long);
  }

  static Future<void> setUserId(String id) async {
    await sharedPreferences.setString(_userId, id);
  }

  // --------------- //

  /// Social login => Apple ///
  static Future<void> setAppleLoginData(String data) async {
    await sharedPreferences.setString(_appleEmail, data);
  }

  static String get appleLoginData =>
      sharedPreferences.getString(_appleEmail) ?? '';
  //  -----  //

  /// Get User data
  static String get name => sharedPreferences.getString(_name) ?? '';

  static String get email => sharedPreferences.getString(_email) ?? '';

  static String get phone => sharedPreferences.getString(_phone) ?? '';
  static String get countryCode =>
      sharedPreferences.getString(_countryCode) ?? '';

  /// Get address data
  static String get address => sharedPreferences.getString(_address) ?? '';
  static double get latitude => sharedPreferences.getDouble(_lat) ?? 0;
  static double get longitude => sharedPreferences.getDouble(_long) ?? 0;

  // --------------- //

  // Job Data

  static Future<void> updateJobAddress(LocationModel model) async {
    if (model.address?.isNotEmpty ?? false) {
      _setJobAddress(model.address ?? '');
    }
    if (model.coordinates?.isNotEmpty ?? false) {
      _setJobLong(model.coordinates![0]);
      _setJobLat(model.coordinates![1]);
    }
  }

  static Future<void> _setJobAddress(String address) async {
    await sharedPreferences.setString(_jobAddress, address);
  }

  static Future<void> _setJobLat(double lat) async {
    await sharedPreferences.setDouble(_searchJobLat, lat);
  }

  static Future<void> _setJobLong(double long) async {
    await sharedPreferences.setDouble(_searchJobLong, long);
  }

  static double? get jobsLatitude => sharedPreferences.getDouble(_searchJobLat);
  static double? get jobsLongitude =>
      sharedPreferences.getDouble(_searchJobLong);
  static String? get jobsAddress => sharedPreferences.getString(_jobAddress);

  // --------------- //

  static Future setLogInStatus({bool isLoggedIn = true}) async {
    await sharedPreferences.setBool(_isLoggedIn, isLoggedIn);
  }

  static Future<void> setAccessToken(String token) async {
    await sharedPreferences.setString(_accessToken, token);
  }

  static Future<void> setSignProcessCompleted() async {
    await sharedPreferences.setBool(_signProcessCompleted, true);
  }

  static Future<void> logout() async {
    //On logout
    String deviceId = AppPreferences.deviceId;
    String deviceToken = AppPreferences.deviceToken;
    String appleCreds = appleLoginData;
    await sharedPreferences.clear();
    await setPreferenceFixedData(
        deviceId: deviceId, deviceToken: deviceToken, appleCreds: appleCreds);
  }

  static Future<void> setPreferenceFixedData(
      {required String deviceId,
      required String deviceToken,
      required String appleCreds}) async {
    await setTutorialSeen();
    await setDeviceToken(deviceToken);
    await setDeviceId(deviceId);
    await setAppleLoginData(appleCreds);
  }

  static Future setTutorialSeen() async {
    await sharedPreferences.setBool(_isTutorialSeen, true);
  }

  static Future<void> setDeviceId(String id) async {
    await sharedPreferences.setString(_deviceId, id);
  }

  static Future<void> setDeviceToken(String token) async {
    await sharedPreferences.setString(_deviceToken, token);
  }

  bool getOnboardingViewed() {
    final res = sharedPreferences.getBool(_isTutorialSeen);
    return res ?? false;
  }

  String getUserToken() {
    final res = sharedPreferences.getString(_accessToken);
    return res ?? '';
  }

  static bool get isLoggedIn => sharedPreferences.getBool(_isLoggedIn) ?? false;

  static bool get isSignupProcessCompleted =>
      sharedPreferences.getBool(_signProcessCompleted) ?? false;

  static bool get isTutorialSeen =>
      sharedPreferences.getBool(_isTutorialSeen) ?? false;

  static String get deviceId =>
      sharedPreferences.getString(_deviceId) ?? 'device_id';

  static String get deviceToken =>
      sharedPreferences.getString(_deviceToken) ?? 'device_token';

  static String get userId => sharedPreferences.getString(_userId) ?? '';
}
