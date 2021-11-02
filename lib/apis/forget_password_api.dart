import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:icommerce/models/forgetpass_otp.dart';

class ForgetPasswordApi{
  static var client = http.Client();

  static Future<ForgetpassOtpModel> forgetPassOtpSend(
      String email) async {
    var baseurl = GlobalConfiguration().get('base_url');

    print('user forgot data: email: $email');

    //email, password, fcm, deviceid
    var response = await client.post(Uri.parse('${baseurl}forgotpasswordotp/'), body: {
      'email': email
    });

    print('base url: $baseurl, response: ${response.body}');

    if (response.statusCode == 200) {
      var jsonString = response.body;

      return forgetpassOtpModelFromJson(jsonString);
    }
    return forgetpassOtpModelFromJson(response.body);
  }
}