class AppLink {
  // static String  baseUrl {
  //   if (kIsWeb) {
  //     return "http://127.0.0.1:8000/api";
  //   } else if (Platform.isAndroid) {
  //     // استخدم عنوان محاكي Android الافتراضي
  //     return "http://10.0.2.2:8000/api";
  //   } else if (Platform.isIOS) {
  //     return "http://127.0.0.1:8000/api";
  //   } else {
  //     // في حالة الجهاز الحقيقي، ضع عنوان IP لجهاز الكمبيوتر
  //     return "http://192.168.43.100:8000/api"; // عدل هذا العنوان حسب شبكتك
  //   }
  // }

  // static const String _baseUrl = "http://10.0.2.2:8000/api/v1";
  static const String _baseUrl = "http://192.168.164.234:8000/api/v1";
  static const String register = "$_baseUrl/register";
  static const String pastAppointments =
      "$_baseUrl/bookings?filter[status]=completed&filter[patient_id]=1&include=doctor";
  static const String upcomingAppointments =
      "$_baseUrl/filter[status]=pending&filter[patient_id]=1&include=doctor";
  static const String getBookings = "$_baseUrl/bookings/getBookings";
  static const String verifyOtpCode = "$_baseUrl/verify-otp";
  static const String login = "$_baseUrl/login";
  static const String sendResetOtp = "$_baseUrl/send-reset-otp";
  static const String resetPassword = "$_baseUrl/reset-password";
  static const String doctorsDetails = "$_baseUrl/doctorsDetails";
  static const String isOnline = "http://10.0.2.2";
}
