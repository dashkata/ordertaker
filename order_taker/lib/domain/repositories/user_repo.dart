abstract class UserRepo {
  Future<String> fetchMobileNumber(String uid);

  Future<String> setMobileNumber(String uid, String mobileNumber);

  Future<void> setUserType(String type, String uid);

  Future<String> fetchUserType(String uid);

  Future<bool> fetchOnBoarding(String uid);

  Future<void> setOnBoarding(String uid, {required bool onBoarding});
}
