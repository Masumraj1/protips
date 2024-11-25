class ApiUrl {

  static const baseUrl = "http://192.168.10.11:5050";
  static const netWorkUrl = "http://192.168.10.11:5050/";

  ///================================= User Authentication url==========================
  static const signupAuth = "/user/register-user";
  static const veryFyCode = "/user/verify-code";
  static const signIn = "/auth/login";
  static const forgotPassword = "/auth/forget-password";
  static const forgetOtp = "/auth/verify-reset-otp";
  static const resetPassword = "/auth/reset-password";
  static const signUpResendOtp = "/user/resend-verify-code";
  ///=======================Profile======================
  static const getProfile = "/user/get-my-profile";
  static const deleteAccount = "/user/delete-account";
  static const changePassword = "/auth/change-password";
  static const profileUpdate = "/normal-user/update-profile";


  ///===============================General api=========================
  static const getPrivacyPolicy = "/manage/get-privacy-policy";
  static const getTermsAndConditions = "/manage/get-terms-conditions";
  static const faqList = "/manage/get-faq";
  static const contactUs = "/contact-us";


  ///=========================payment=========================
  static const myTransactionLog = "/transaction/my-transactions";


  ///=======================Tipz History==================
  static const myTipHistory = "/tip/my-tips";

  ///======================Favorite===================
  static const favoritePlayer = "/player/get-all";
  static const favoriteTeam = "/team/get-all";

  ///=======================Leage==================
  static const getAllLeague = "/league/get-all";


  ///======================Reward====================
  static const getReward = "/reward-category/get-all";


}
