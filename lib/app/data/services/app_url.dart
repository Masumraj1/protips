class ApiUrl {

  static const baseUrl = "http://192.168.10.11:5050";
  static const netWorkUrl = "http://192.168.10.11:5050/";

  ///================================= User Authentication url==========================
  static const signupAuth = "/user/register-user";
  static const veryFyCode = "/user/verify-code";
  static const signIn = "/auth/login";
  static const changePassword = "/auth/change-password";
  static const forgotPassword = "/auth/forget-password";
  static const forgetOtp = "/auth/verify-reset-otp";
  static const resetPassword = "/auth/reset-password";
  static const getProfile = "/user/get-my-profile";


}
