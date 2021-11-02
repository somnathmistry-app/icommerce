import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icommerce/controllers/conditions_controller.dart';
import 'package:icommerce/styles/commonmodule/app_bar.dart';

class TermsAndConditionView extends StatelessWidget {
  ConditionController conditionController = Get.put(ConditionController());

  @override
  Widget build(BuildContext context) {
    return

      Scaffold(
      appBar: appBar('Terms and Condition'),
      body:

      Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 20),
          child: GetX<ConditionController>(
            initState: (context) {
              conditionController.getTermsConditions();
            },
            builder: (controller) {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return controller.termsconditionStr == null
                    ? const Center(
                        child: Text('Terms and condition not available now'),
                      )
                    : ListView(
                        children: [
                          const SizedBox(height: 30),
                          const Text(
                            'Our Terms and Condition',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                                color: Colors.lightBlue),
                          ),
                          const SizedBox(height: 25),
                          Text(controller.termsconditionStr,
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
