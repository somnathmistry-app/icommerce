import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:icommerce/models/notification_model.dart';
import 'package:icommerce/models/status_model.dart';
import 'package:icommerce/models/wish_list_model.dart';

class NotificationApi {
  static var client = http.Client();


  static Future<NotificationListModel> fetchNotificationList(String userId) async {
    var baseUrl = GlobalConfiguration().get('base_url');

    var response = await client.post(Uri.parse('${baseUrl}notificationlist/'), body: {'userid': userId});

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return notificationListModelFromJson(jsonString);
    }
    return notificationListModelFromJson(response.body);
  }
}
