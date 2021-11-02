import 'package:get/get.dart';
import 'package:icommerce/apis/conditions_api.dart';
import 'package:icommerce/models/contact_model.dart';
import 'package:icommerce/models/faq_list_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ConditionController extends GetxController{
  var isLoading = true.obs;
  var termsconditionStr;
  var privacyStr;
  var returnPolicyStr;
  var faqList = <Faqlist>[].obs;
  var contactData = Contactusdata().obs;

  // @override
  // void onInit() {
  //   getTermsConditions();
  // }

  getTermsConditions() async {
    try {
      isLoading(true);
      var data = await ConditionsApi.getTermsCondition();
      print('termsAndConditions ${data.termscondition}');
      if (data != null) {
        termsconditionStr = data.termscondition;
      }
    } finally {
      isLoading(false);
    }
  }

  getPrivacyPolicy() async {
    try {
      isLoading(true);
      var data = await ConditionsApi.getPrivacyPolicy();
      print('privacyPolicy ${data.privacyPolicy}');
      if (data != null) {
        privacyStr = data.privacyPolicy;
      }
    } finally {
      isLoading(false);
    }
  }

  getReturnPolicy() async {
    try {
      isLoading(true);
      var data = await ConditionsApi.getReturnPolicy();
      print('returnpolicy ${data.returnPolicy}');
      if (data != null) {
        returnPolicyStr = data.returnPolicy;
      }
    } finally {
      isLoading(false);
    }
  }

  getFaq() async {
    try {
      isLoading(true);
      var data = await ConditionsApi.getFaq();
      print('returnpolicy ${data.faqlist}');
      if (data != null) {
        faqList.value = data.faqlist!;
      }
    } finally {
      isLoading(false);
    }
  }

  getContact() async {
    try {
      isLoading(true);
      var data = await ConditionsApi.getContacts();
      print('Contacts ${data.contactusdata}');
      if (data != null) {
        contactData.value = await data.contactusdata!;
      }
    } finally {
      isLoading(false);
    }
  }

  void launchURL(_url) async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
}