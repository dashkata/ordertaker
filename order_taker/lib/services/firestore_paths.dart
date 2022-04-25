class FirestorePath {
  static String restaurants(String uid, String jobId) => 'Restaurants';
  static String orders(String uid) => 'users/$uid/jobs';
}
