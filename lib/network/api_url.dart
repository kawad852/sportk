class ApiUrl {
  static const String mainUrl = 'https://dev.varvox.com';

  ///intro
  static const String intro = '/api/intro';

  ///auth
  static const String login = '/api/login';
  static const String account = '/api/user';
  static const String checkEmail = '/api/verify_email';
  static const String checkPhoneNum = '/api/verify_phone_number';
  static const String resetPassword = '/api/reset_password';
  static const String updateProfile = '/api/user-update';
  static const String verifyEmail = '/api/verify_email';
  static const String verifyPhone = '/api/verify_phone_number';
  static const String sendEmailVerification = '/api/send_email_verification';
  static const String socialLogin = '/api/social_media_customer_registration';
  static const String privacyPolicy = '/api/policy';
  static const String updateDeviceToken = '/api/store_fcm_token';

  ///inquiry
  static const String inquiry = '/api/order';
  static const String inquiries = '/api/get_customer_orders';
  static const String inquiryInvoice = '/api/print_order';

  static const String homeSlider = '/api/slider';

  ///common
  static const String areas = '/api/areas';
}
