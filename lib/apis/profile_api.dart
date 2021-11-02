import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:icommerce/models/login_model.dart';

class ProfileApi {
  static var client = http.Client();

  static changePasswordApi(read, String trim) {}

  static Future<LoginModel> userUpdate(
      String userId,
      String fname,
      String lname,
      String email,
      String profilePic,
      String phone,
      String dob) async {
    var baseurl = GlobalConfiguration().get('base_url');

    print(
        'user update data: fname:$fname, lname:$lname, email: $email, pic: $profilePic, phon:$phone, dob: $dob');

    //email, password, fcm, deviceid
    var response =
        await client.post(Uri.parse('${baseurl}profileupdate/'), body: {
      'srno': userId,
      'FName': fname,
      'LName': lname,
      'email': email,
      'profpic': profilePic,
      'phno': phone,
      'dob': dob
    });

    print('base url: $baseurl, response: ${response.body}');

    if (response.statusCode == 200) {
      var jsonString = response.body;

      return loginModelFromJson(jsonString);
    }
    return loginModelFromJson(response.body);
  }
}
