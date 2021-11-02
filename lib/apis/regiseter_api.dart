import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:icommerce/models/register_model.dart';

class RegisterApi {
  static var client = http.Client();

  static Future<RegisterModel> regisetrFunc(String email, String password, String firstName, String lastName, String mobile) async {
    var baseurl = GlobalConfiguration().get('base_url');

    print('user reg data: firstname: $firstName, lastname $lastName, mobile: $mobile, email: $email, password: $password');

    //email:sam2@gmail.com
    // passwd:123456
    // FName:Sam2
    // LName:Smith
    // phno:9876543210
    var response = await client.post(Uri.parse('${baseurl}saveuser/'), body: {
      'email':email,
      'passwd':password,
      'FName':firstName,
      'LName':lastName,
      'phno':mobile
    });

    print('base url: $baseurl, response: $response');

    if (response.statusCode == 200) {
      var jsonString = response.body;

      return registerModelFromJson(jsonString);
    }
    return registerModelFromJson(response.body);
  }
}
