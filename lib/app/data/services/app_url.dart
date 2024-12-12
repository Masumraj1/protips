class ApiUrl {

  // static const baseUrl = "http://192.168.10.11:5050";
  static const baseUrl = "http://103.145.138.200:5050";
  // static const netWorkUrl = "http://192.168.10.11:5050/";
  static const netWorkUrl = "http://103.145.138.200:5050/";

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
  static const createDepositIntend = "/deposit/create-deposit-intent";
  static const stripeDeposit = "/deposit/execute-stripe-deposit";


  ///=======================my Tips==================
  static const myTipHistory = "/tip/my-tips";
  static const sendTip = "/tip/create";
  static const stripeSendTip = "/tip/execute-stipe-payment";
  static const paypalSend = "/tip/execute-paypal-payment-app";

  ///===========================Withdraw=====================
  static const withdrawFunds = "/withdraw/create";

  ///===========================Notification===========================
  static const notification = "/notification/get-notifications";

  ///======================Favorite===================
  static const favoritePlayer = "/player-bookmark/my-bookmark";
  static const favoriteTeam = "/team-bookmark/my-bookmark";
  static const bookMarkPlayer = "/player-bookmark/create";
  static const bookMarkTeam = "/team-bookmark/create";
  static String removePlayerBookmark({required String id}) {
    return "/player-bookmark/delete/$id";
  }

  static String removeTeamBookmark({required String id}) {
    return "/team-bookmark/delete/$id";
  }
  ///=========================Invite=====================
  static const invite = "/invite/invite-friend";

  ///================*********League*************==================
  static const getAllLeague = "/league/get-all";




  ///=========================Player====================
  static const getAllPlayer = "/player/get-all";
  static String selectPlayer({required String id}) {
    return "/player/get-all?league=$id";
  }
  static const searchPlayer = "/player/get-all?searchTerm";





  ///=========================Team==================
  static const getAllTeam = "/team/get-all";
  static String selectTeam({required String id}) {
    return "/team/get-all?league=$id";
  }
  static const searchTeam = "/team/get-all?searchTerm";






  ///======================Reward====================
  static const getReward = "/reward-category/get-all";
  static String selectReward({required String id}) {
    return "/reward/get-all?category=$id";
  }
  static String veryFyRedeemOtp({required String id}) {
    return "/redeem-request/verify-redeem-email/$id";
  }
  static const searchReward = "/reward/get-all?searchTerm";
  static const redeemCreate = "/redeem-request/create";

  ///=======================Google Auth=========================
  static const googleAuth = "/auth/google-login";

  ///======================Paypal =============================
  static const paypalIntend = "/deposit/execute-paypal-deposit-app";

}
