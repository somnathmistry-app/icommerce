import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:icommerce/controllers/conditions_controller.dart';
import 'package:icommerce/styles/app_colors.dart';
import 'package:icommerce/styles/commonmodule/app_bar.dart';

class FaqView extends StatelessWidget {
  //const FaqView({Key? key}) : super(key: key);

  ConditionController conditionController = Get.put(ConditionController());
  var box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return

      Scaffold(
      backgroundColor: AppColors.white,
      //bottomNavigationBar:  getCartBarItem(),
      appBar: appBar('FAQ'),
      body:
      SafeArea(
        child: LimitedBox(
            maxHeight: double.infinity,
            child: GetX<ConditionController>(
              initState: (context) {
                conditionController.getFaq();
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
                          'Loading FAQs..',
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  );
                } else {
                  return controller.faqList.isEmpty
                      ? const Center(
                          child: Text('No FAQ available'),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.only(left: 6, right: 6),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.faqList.length,
                          itemBuilder: (context, index) {
                            return getFaqListItem(controller, index);
                          });
                }
              },
            )),
      ),
    );
  }

  Widget getFaqListItem(ConditionController controller, int index) {
    return Card(
      elevation: 6,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            topLeft: Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text('Q.  ${controller.faqList[index].question!}',
                style: const TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            Text('Ans.  ${controller.faqList[index].answer!}',
                style: const TextStyle(fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
