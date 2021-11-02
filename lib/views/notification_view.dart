import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:icommerce/controllers/notification_list.dart';
import 'package:icommerce/controllers/productdetails_controller.dart';
import 'package:icommerce/styles/app_colors.dart';
import 'package:icommerce/views/product_details_view.dart';
import 'package:icommerce/views/product_view.dart';

class NotificationView extends StatelessWidget {
  NotificationController notificationController =
      Get.put(NotificationController());
  GlobalConfiguration globalConfiguration = GlobalConfiguration();
  var imageUrl = GlobalConfiguration().get('image_url');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: LimitedBox(
            maxHeight: double.infinity,
            child: GetX<NotificationController>(
              initState: (context) {
                notificationController.getNotificationList();
              },
              builder: (controller) {
                if (controller.isLoading.value) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Center(child: CircularProgressIndicator()),
                        // HeartbeatProgressIndicator(
                        //   child: Icon(Icons.shopping_cart,
                        //       color: AppColors.themeColorTwo),
                        // ),
                        SizedBox(height: 10),
                        Text(
                          'Loading..',
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  );
                } else {
                  return controller.notificationList.isEmpty
                      ? const Center(
                          child: Text('No Notifications'),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.only(left: 6, right: 6),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.notificationList.length,
                          itemBuilder: (context, index) {
                            return notificationsListItem(controller, index);
                          });
                }
              },
            )),
      ),
    );
  }

  Widget notificationsListItem(NotificationController controller, int index) =>
      InkWell(
        onTap: () {
          if (controller.notificationList[index].ntype == 'product') {
            ProductDetailsController.selectedProductName.value =
                controller.notificationList[index].catprdname!;
            Get.to(ProductDetailsView(
                controller.notificationList[index].catprdid!));
          } else {
            Get.to(ProductView(controller.notificationList[index].catprdid!,
                controller.notificationList[index].catprdname!));
          }
        },
        child: Card(
          elevation: 1,
          shadowColor: AppColors.themeColor,
          margin: const EdgeInsets.all(4),
          child: Container(
            //height: 140,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 10),
                    Container(
                      width: 60,
                      child: FadeInImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              '$imageUrl${controller.notificationList[index].catprdimg}'),
                          placeholder:
                              const AssetImage('assets/images/loading.gif')),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 2, bottom: 2, left: 6, right: 4),
                          child: Text(
                            '${controller.notificationList[index].heading} on ${controller.notificationList[index].catprdname}',
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 2, bottom: 4, left: 6, right: 4),
                          child: Text(
                            '${controller.notificationList[index].fromdate} from ${controller.notificationList[index].todate}',
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 2, bottom: 15, left: 6, right: 4),
                          child: Text(
                            '${controller.notificationList[index].shortdesc}',
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 11),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
