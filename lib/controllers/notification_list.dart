import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:icommerce/apis/notification_api.dart';
import 'package:icommerce/models/notification_model.dart';

class NotificationController extends GetxController{
  var box = GetStorage();
  var isLoading = true.obs;
  var notificationList = <Notificationlist>[].obs;

  getNotificationList() async {
    try {
      isLoading(true);
      var notifications = await NotificationApi.fetchNotificationList(box.read('userId'));
      print('notification $notifications');

      if (notifications != null) {
        notificationList.assignAll(notifications.notificationlist!);
        update();
      }
    } finally {
      isLoading(false);
    }
  }
}