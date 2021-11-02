import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icommerce/controllers/conditions_controller.dart';
import 'package:icommerce/styles/commonmodule/app_bar.dart';

class PrivacyPolicy extends StatelessWidget {
  ConditionController conditionController = Get.put(ConditionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Privacy & Policy'),
      body:

      Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 20),
          child: GetX<ConditionController>(
            initState: (context) {
              conditionController.getPrivacyPolicy();
            },
            builder: (controller) {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return controller.privacyStr == null ||
                        controller.privacyStr == ""
                    ? const Center(
                        child: Text('Privacy Policy coming soon'),
                      )
                    : ListView(
                        children: [
                          const SizedBox(height: 30),
                          const Text(
                            'Please Read Our Privacy Policy',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                                color: Colors.lightBlue),
                          ),
                          const SizedBox(height: 25),
                          Text(
                            controller.privacyStr,
                            style: const TextStyle(fontSize: 13),
                            textAlign: TextAlign.justify,
                          )
                        ],
                      );
              }
            },
          )),
    );
  }
}
