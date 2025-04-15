import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:neurology_clinic/controller/connection_controller.dart';
import 'package:neurology_clinic/link_api.dart';

import '../../data/datasource/model/prescription_model.dart';
import '../../services/services.dart';

enum AllPrescriptionsStatus { initial, loading, failure, success }

class AllPrescriptionsController extends GetxController {
  AllPrescriptionsStatus status = AllPrescriptionsStatus.initial;
  List<Prescription> allPrescriptions = [];
  late MyServices myServices;
  String _token = "";
  final ConnectionController _connectionController =
      Get.find<ConnectionController>();
  static const String _allKey = 'allPrescriptions';

  Future<void> fetchAllPrescriptions() async {
    status = AllPrescriptionsStatus.loading;
    update();
    final list = await getAllPrescriptions();
    status = AllPrescriptionsStatus.success;
    allPrescriptions = list;
    update();
  }

  Future<List<Prescription>> getAllPrescriptions() async {
    if (_connectionController.isConnected.value) {
      final fetchedList = await fetchAllPrescriptionsApi();
      if (fetchedList.isNotEmpty) {
        await savePrescriptionPage(list: fetchedList);
        return fetchedList;
      }
    }

    // fallback to cache if offline or fetch failed
    return loadPrescriptionPage();
  }

  Future<List<Prescription>> fetchAllPrescriptionsApi() async {
    try {
      final response = await http.get(
        Uri.parse(AppLink.getAllPrescriptions),
        headers: {
          'Authorization': 'Bearer $_token', // Add Bearer token
          'Content-Type': 'application/json', // Optional but good to specify
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body)['data'];
        final l =
            (responseData as List).map((e) => Prescription.fromMap(e)).toList();
        return l;
      } else if (response.statusCode == 404) {
        // API returns 404 when there's no more data
        return [];
      } else {
        print("Error: ${response.statusCode}");
        update();
      }
    } catch (e) {
      print("Error during request: $e");
    }
    return [];
  }

  List<Prescription> loadPrescriptionPage() {
    final jsonList = myServices.getData(_allKey);

    return jsonList != null
        ? (jsonList as List).map((e) => Prescription.fromRawJson(e)).toList()
        : [];
  }

  Future<bool> savePrescriptionPage({
    required List<Prescription> list,
  }) {
    final jsonList = list.map((e) => e.toRawJson()).toList();
    return myServices.storeDataBool(_allKey, jsonList);
  }

  @override
  void onInit() {
    myServices = Get.find<MyServices>();
    _token = myServices.userData['token'];
    // myServices.clearData(_allKey);
    ever<bool>(_connectionController.isConnected, (connected) {
      if (connected) {
        fetchAllPrescriptions();
      }
    });

    // تحميل من الانترنت عند الاتصال
    fetchAllPrescriptions();
    super.onInit();
  }
}
