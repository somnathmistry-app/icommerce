import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:icommerce/controllers/order_controller.dart';
import 'package:icommerce/styles/app_colors.dart';
import 'package:icommerce/styles/commonmodule/app_bar.dart';
import 'package:icommerce/views/order_detail_view.dart';

class OrderListView extends StatelessWidget {
  //const OrderListView({Key? key}) : super(key: key);
  OrderController orderController = Get.put(OrderController());
  var imageUrl = GlobalConfiguration().get('image_url');
  var box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return

      Scaffold(
      backgroundColor: AppColors.offWhiteGray,
      //bottomNavigationBar:  getCartBarItem(),
      appBar: appBar('My Order'),
      body: SafeArea(
        child: LimitedBox(
            maxHeight: double.infinity,
            child: GetX<OrderController>(
              initState: (context) {
                orderController.fetchOrderListProducts();
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
                          'Loading order..',
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  );
                } else {
                  return controller.orderListProducts.isEmpty
                      ? const Center(
                          child: Text('No Orders available'),
                        )
                      : ListView(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                    height: 50,
                                    child:
                                        Image.asset('assets/images/tdg.gif')),
                                const SizedBox(width: 10),
                                Expanded(
                                    child: Text(
                                  'Hi, ${box.read('name')} here is your orderlist',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12),
                                ))
                              ],
                            ),
                            ListView.builder(
                              padding: EdgeInsets.only(left: 6, right: 6),
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.orderListProducts.length,
                                itemBuilder: (context, index) {
                                  return getOrderListItem(controller, index);
                                }),
                          ],
                        );
                }
              },
            )),
      ),
    );
  }

  Widget getOrderListItem(OrderController controller, int index) {
    return InkWell(
      onTap: () {
        Get.to(OrderDetailsView(controller, index));
      },
      child:

      Card(
        elevation: 1,
        shadowColor: AppColors.themeColor,
        margin: const EdgeInsets.all(4),
        child: Container(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 100,
                child: FadeInImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        '$imageUrl${controller.orderListProducts[index].prdimg}'),
                    placeholder: const AssetImage('assets/images/loading.gif')),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //controller.orderListProducts[index].deliverystatus!
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 2, bottom: 4, left: 6, right: 8),
                    child: Row(
                      children: [
                        //Image.asset('assets/images/sucgif.gif', scale: 6)
                        orderController.orderListProducts[index].deliverystatus == "Pending"?
                        Image.asset('assets/images/dv.gif', scale: 6):Image.asset('assets/images/sucgif.gif', scale: 6.5),
                        const SizedBox(width: 10),
                        Text(orderController.orderListProducts[index].deliverystatus!,
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 13),
                        ),
                        // Image.asset('assets/images/tdg.gif', scale: 8,),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 2, bottom: 6, left: 6, right: 8),
                    child: Text(
                      '${controller.orderListProducts[index].productname}',
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 6, bottom: 4, left: 6, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:  [
                        const Text(
                          'View Details',
                          style: TextStyle(fontSize: 10, color: Colors.blue),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: Colors.blue,
                        ),
                        Text(orderController.orderListProducts[index].orderstatus!,
                          style: const TextStyle(fontSize: 10, color: Colors.black45),
                        ),
                        //orderstatus
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
