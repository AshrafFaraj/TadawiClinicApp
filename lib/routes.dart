import 'package:get/get.dart';
import 'package:neurology_clinic/doctors_page/doctors_page.dart';
import 'package:neurology_clinic/view/screens/notifications/notifications_page.dart';
import 'package:neurology_clinic/view/screens/prescription/all_prescriptions_page.dart';
import '/view/screens/doctor_details/doctor_details.dart';
import '/view/screens/appointment_page/appointment_page.dart';
import '/view/screens/help_center/help_center_page.dart';
import '/view/screens/prescription/prescription_page.dart';
import '/view/screens/profile/edit_profile/edit_profile.dart';
import '/view/screens/profile/privacy_policy/privacy_policy_page.dart';
import '/view/screens/profile/profile_page/profile_page.dart';
import '/view/screens/profile/settings/settings_page.dart';
import 'middleware/my_middleware.dart';
import 'view/screens/app_layout.dart';
import 'core/constants/app_route_name.dart';
import 'view/screens/home/home_view.dart';
import 'view/screens/ai_chat/ai_chat_page.dart';
import 'view/screens/book_appointment/book_appointment_page.dart';
import 'view/screens/onboarding_and_auth/auth/forget_password/forget_password_screen.dart';
import 'view/screens/onboarding_and_auth/auth/forget_password/reset_password_screen.dart';
import 'view/screens/onboarding_and_auth/auth/forget_password/success_reset_password_screen.dart';
import 'view/screens/onboarding_and_auth/auth/forget_password/verfiy_code_screen.dart';
import 'view/screens/onboarding_and_auth/auth/signup/check_email_screen.dart';
import 'view/screens/onboarding_and_auth/auth/signup/success_signup_screen.dart';
import 'view/screens/onboarding_and_auth/onboarding/onboarding_screen.dart';

List<GetPage<dynamic>>? routes = [
  // GetPage(
  //     name: AppRouteName.language,
  //     page: () => const AppLanguage(),
  //     middlewares: [
  //       MyMiddleWare(),
  //     ]),
  GetPage(name: AppRouteName.onBoarding, page: () => const OnboardingScreen()),
  GetPage(name: AppRouteName.editProfile, page: () => EditProfile()),
  GetPage(name: AppRouteName.profilePage, page: () => const ProfilePage()),
  GetPage(name: AppRouteName.settingsPage, page: () => SettingsPage()),
  GetPage(name: AppRouteName.checkEmail, page: () => const CheckEmail()),
  GetPage(name: AppRouteName.privacy, page: () => const PrivacyPolicyPage()),
  GetPage(name: AppRouteName.helpCenter, page: () => const HelpCenterPage()),
  GetPage(
      name: AppRouteName.forgetPassword, page: () => const ForgetPassword()),
  GetPage(name: AppRouteName.verfiyCode, page: () => const VerfiyCode()),
  GetPage(name: AppRouteName.resetPassword, page: () => ResetPassword()),
  GetPage(
      name: AppRouteName.successResetPassword,
      page: () => const SuccessResetPassword()),
  GetPage(name: AppRouteName.successSignUp, page: () => const SuccessSignUp()),
  GetPage(
      name: AppRouteName.appointmentPage, page: () => const AppointmentPage()),
  GetPage(name: AppRouteName.aiChat, page: () => AiPage()),
  GetPage(
      name: AppRouteName.bookAppointmentPage,
      page: () => BookAppointmentPage(),
      middlewares: [
        // MyMiddleWare(),
      ]),

  GetPage(
      name: AppRouteName.layout,
      page: () => const AppLayout(),
      middlewares: [
        MyMiddleWare(),
      ]),

  GetPage(
      name: AppRouteName.layout,
      page: () => const AppLayout(),
      middlewares: [MyMiddleWare()]),
  GetPage(name: AppRouteName.home, page: () => HomeView()),
  // GetPage(name: AppRouteName.test, page: () => TestPage()),
  GetPage(
      name: AppRouteName.prescription, page: () => const PrescriptionPage()),
  GetPage(
      name: AppRouteName.allPrescriptions,
      page: () => const AllPrescriptionsPage()),
  GetPage(name: AppRouteName.doctorDetails, page: () => DoctorDetails()),
  // GetPage(name: AppRouteName.tokenTest, page: () => TokenSenderScreen()),
  GetPage(name: AppRouteName.doctorsPage, page: () => DoctorsPage()),
  GetPage(
      name: AppRouteName.notificationsPage, page: () => NotificationsPage()),
];

// Map<String, Widget Function(BuildContext)> routes = {
//   AppRouteName.language: (context) => const AppLanguage(),
//   AppRouteName.onBoarding: (context) => const Onboarding(),
//   AppRouteName.login: (context) => const Login(),
//   AppRouteName.signUp: (context) => const SignUp(),
//   AppRouteName.checkEmail: (context) => const CheckEmail(),
//   AppRouteName.forgetPassword: (context) => const ForgetPassword(),
//   AppRouteName.verfiyCode: (context) => const VerfiyCode(),
//   AppRouteName.resetPassword: (context) => const ResetPassword(),
//   AppRouteName.successResetPassword: (context) => const SuccessResetPassword(),
//   AppRouteName.successSignUp: (context) => const SuccessSignUp(),
//   AppRouteName.test: (context) => Test(),
// };
