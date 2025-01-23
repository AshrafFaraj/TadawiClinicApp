import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:neurology_clinic/core/class/status_request.dart';
import 'package:http/http.dart' as http;

class Curd {
  Future<Either<StatusRequest, Map>> postData(String myUrl, Map data) async {
    try {
      // if (await checkInternet()) {
      var response = await http.post(Uri.parse(myUrl), body: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map responseBody = jsonDecode(response.body);
        return Right(responseBody);
      } else {
        return const Left(StatusRequest.serverFailure);
      }
      // } else {
      //   return const Left(StatusRequest.offllineFailure);
      // }
    } catch (_) {
      return const Left(StatusRequest.serverExption);
    }
  }
}
