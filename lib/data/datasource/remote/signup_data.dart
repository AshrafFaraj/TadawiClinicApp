
import '../../../core/class/curd.dart';
import '../../../link_api.dart';

class SignUpData {
  Curd curd;
  SignUpData(this.curd);

  signUpData(
      String username, String password, String email, String phone) async {
    var response = await curd.postData(AppLink.signUp, {
      "username": username,
      "password": password,
      "email": email,
      "phone": phone,
    });
    return response.fold((l) => l, (r) => r);
  }
}
