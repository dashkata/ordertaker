class CustomUser {
  final String uid;
  final String username;
  final String email;
  final String mobileNumber;

  CustomUser(
      {required this.uid,
      required this.username,
      required this.email,
      required this.mobileNumber});

  Map<String, dynamic> toMap() {
    return ({
      'uid': uid,
      'username': username,
      'email': email,
      'mobileNumber': mobileNumber,
    });
  }
}
