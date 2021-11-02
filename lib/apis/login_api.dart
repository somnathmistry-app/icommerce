import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:icommerce/models/login_model.dart';

class LoginApi {
  static var client = http.Client();

  static Future<LoginModel> loginFunc(
      String email, String password, String fcm, String deviceId) async {
    var baseurl = GlobalConfiguration().get('base_url');

    print('user reg data: email: $email, password: $password');

    //email, password, fcm, deviceid
    var response = await client.post(Uri.parse('${baseurl}userlogin/'), body: {
      'email': email,
      'passwd': password
    });

    print('base url: $baseurl, response: ${response.body}');

    if (response.statusCode == 200) {
      var jsonString = response.body;

      return loginModelFromJson(jsonString);
    }
    return loginModelFromJson(response.body);
  }
}