import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icommerce/controllers/conditions_controller.dart';
import 'package:icommerce/styles/commonmodule/app_bar.dart';

class ReturnPolicy extends StatelessWidget {
  ConditionController conditionController = Get.put(ConditionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Return Policy'),
      body:

      Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 20),
          child: GetX<ConditionController>(
            initState: (context) {
              conditionController.getReturnPolicy();
            },
            builder: (controller) {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return controller.returnPolicyStr == null ||
                    controller.returnPolicyStr == ""
                    ? const Center(
                  child: Text('Privacy Policy coming soon'),
                )
                    : ListView(
                  children: [
                    const SizedBox(height: 30),
                    const Text(
                      'Want to return ?',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                          color: Colors.lightBlue),
                    ),
                    const SizedBox(height: 25),
                    Text(
                      controller.returnPolicyStr,
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
