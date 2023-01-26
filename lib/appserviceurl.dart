class AppUrl {
  static const String liveBaseURL = "https://demoapi.ppleapp.com/bexit-flutter-docs/#/User";

  static const String baseURL = liveBaseURL;
  static  String login = "$baseURL/post_login_user";
  static const String register = "$baseURL/post_create_user";
  static const String verifyuser = "$baseURL/get_verify_user";
  static const String changepassword = "$baseURL/post_change_password";
  static const String getuser = "${baseURL}post_user_profile_by_id";
  static const String avataredit = "${baseURL}post_edit_profile_avatar";
  static const String deleteaccount = "${baseURL}get_delete_account";
}