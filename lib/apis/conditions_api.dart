import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:icommerce/models/contact_model.dart';
import 'package:icommerce/models/faq_list_model.dart';
import 'package:icommerce/models/privacy_model.dart';
import 'package:icommerce/models/return_policy_model.dart';
import 'package:icommerce/models/termscondition_model.dart';


class ConditionsApi {
  static var client = http.Client();

  static Future<TermsconditionModel> getTermsCondition() async {
    var baseUrl = GlobalConfiguration().get('base_url');

    var response = await client
        .post(Uri.parse('${baseUrl}termscondition/'));

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return termsconditionModelFromJson(jsonString);
    }
    return termsconditionModelFromJson(response.body);
  }

  static Future<PrivacyModel> getPrivacyPolicy() async {
    var baseUrl = GlobalConfiguration().get('base_url');

    var response = await client
        .post(Uri.parse('${baseUrl}privacypolicy/'));

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return privacyModelFromJson(jsonString);
    }
    return privacyModelFromJson(response.body);
  }

  static Future<ReturnPolicyModel> getReturnPolicy() async {
    var baseUrl = GlobalConfiguration().get('base_url');

    var response = await client
        .post(Uri.parse('${baseUrl}returnpolicy/'));

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return returnPolicyModelFromJson(jsonString);
    }
    return returnPolicyModelFromJson(response.body);
  }

  static Future<FaqListModel> getFaq() async {
    var baseUrl = GlobalConfiguration().get('base_url');

    var response = await client
        .post(Uri.parse('${baseUrl}faq/'));

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return faqListModelFromJson(jsonString);
    }
    return faqListModelFromJson(response.body);
  }

  static Future<ContactModel> getContacts() async {
    var baseUrl = GlobalConfiguration().get('base_url');

    var response = await client
        .post(Uri.parse('${baseUrl}contactus/'));

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return contactModelFromJson(jsonString);
    }
    return contactModelFromJson(response.body);
  }
}
