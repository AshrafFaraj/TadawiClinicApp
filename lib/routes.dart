import 'package:neurology_clinic/core/middleware/my_middleware.dart';
import 'package:neurology_clinic/data/datasource/static/appRouteName.dart';
import 'package:neurology_clinic/view/screen/onboardingAndAuth/auth/signup/checkEmailScreen.dart';
import 'package:neurology_clinic/view/screen/onboardingAndAuth/auth/forgetPassword/forgetPasswordScreen.dart';
import 'package:neurology_clinic/view/screen/onboardingAndAuth/auth/forgetPassword/resetPasswordScreen.dart';
import 'package:neurology_clinic/view/screen/onboardingAndAuth/auth/forgetPassword/successResetPasswordScreen.dart';
import 'package:neurology_clinic/view/screen/onboardingAndAuth/auth/signup/successSignupScreen.dart';
import 'package:neurology_clinic/view/screen/onboardingAndAuth/auth/forgetPassword/verfiyCodeScreen.dart';
import 'package:neurology_clinic/view/screen/language/language_screen.dart';
import 'package:get/get.dart';
import 'package:neurology_clinic/view/screen/onboardingAndAuth/onboarding/onboardingScreen.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(
      name: AppRouteName.language,
      page: () => const AppLanguage(),
      middlewares: [
        MyMiddleWare(),
      ]),
  // GetPage(name: "/", page: () => TestVeiw()),
  // GetPage(name: AppRouteName.onBoarding, page: () => const Onboarding()),
  GetPage(name: AppRouteName.onBoarding, page: () => const OnboardingScreen()),
  GetPage(name: AppRouteName.checkEmail, page: () => const CheckEmail()),
  GetPage(
      name: AppRouteName.forgetPassword, page: () => const ForgetPassword()),
  GetPage(name: AppRouteName.verfiyCode, page: () => const VerfiyCode()),
  GetPage(name: AppRouteName.resetPassword, page: () => const ResetPassword()),
  GetPage(
      name: AppRouteName.successResetPassword,
      page: () => const SuccessResetPassword()),
  GetPage(name: AppRouteName.successSignUp, page: () => const SuccessSignUp()),
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
