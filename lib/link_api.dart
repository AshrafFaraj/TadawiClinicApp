class AppLink {
  static const String _baseUrl = "http://10.0.2.2:8000/api/v1";
  // static const String _baseUrl = "http://192.168.57.234:8000/api/v1";
  static const String register = "$_baseUrl/register";
  static const String verifyOtpCode = "$_baseUrl/verify-otp";
  static const String login = "$_baseUrl/login";
  static const String storeToken = "$_baseUrl/store-token";
  static const String logout = "$_baseUrl/logout";
  static const String uploadImage = "$_baseUrl/patients/upload-image";
  static const String getImage = "$_baseUrl/patients/get-image";
  static const String sendResetOtp = "$_baseUrl/send-reset-otp";
  static const String sendResetPasswordOtp =
      "$_baseUrl/send-password-reset-otp";
  static const String resetPassword = "$_baseUrl/reset-password";
  static const String getAllPrescriptions = "$_baseUrl/prescriptions/get-all";
  static const String changePassword = "$_baseUrl/change-password";
  static const String doctorsDetails = "$_baseUrl/doctorsDetails";
  static const String pastAppointments = '$_baseUrl/bookings/past';
  static const String upcomingAppointments = "$_baseUrl/bookings/upcoming";
  static const String updateAppointments = "$_baseUrl/bookings/upcoming";
  static const String deleteAppointments = "$_baseUrl/bookings/";
  static const String bookAppointment = "$_baseUrl/bookings/";

  static const String isOnline = "http://10.0.2.2";
}
