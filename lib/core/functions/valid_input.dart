import 'package:get/get.dart';

_isMin(String val, min) {
  if (val.length < min) {
    return false;
  } else {
    return true;
  }
}

_isMax(String val, max) {
  if (val.length > max) {
    return false;
  } else {
    return true;
  }
}

_checkLength(String val, int min, int max) {
  if (_isMin(val, min)) {
    if (!_isMax(val, max)) {
      return "Can't be larger than $max ";
    }
  } else {
    return "Can't be less than $min ";
  }
}

validInput(String val, int min, int max, String type) {
  if (val.isNotEmpty) {
    if (type == "username") {
      if (GetUtils.isUsername(val)) {
        return _checkLength(val, min, max);
      } else {
        return "not valid username";
      }
    } else if (type == "email") {
      if (GetUtils.isEmail(val)) {
        return _checkLength(val, min, max);
      } else {
        return "not valid email";
      }
    } else if (type == "phone") {
      if (GetUtils.isPhoneNumber(val)) {
        return _checkLength(val, min, max);
      } else {
        return "not valid phone number";
      }
    } else if (type == "password") {
      return _checkLength(val, min, max);
    }
  } else {
    return "$type can't be empty";
  }
}
