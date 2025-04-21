import 'package:get/get.dart';
import 'package:neurology_clinic/services/notification_service.dart';

class NotificationController extends GetxController {
  late NotificationService notificationService;
  List<NotificationModel> notificationsList = [];
  Future<void> addNotifactions() async {
    notificationsList.addAll(notificationService.notifications);
    update();
  }

  @override
  void onInit() {
    notificationService = Get.find<NotificationService>();
    addNotifactions();

    super.onInit();
  }
}
