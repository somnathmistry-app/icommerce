import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:icommerce/models/home_model.dart';

class HomeApi {
  static var client = http.Client();

  static Future<HomeModel> fetchHome(String userId) async {
    var baseUrl = GlobalConfiguration().get('base_url');

    // box.write('schoolId', schoolId);
    //        box.write('teacherId', teacherId);

    var response = await client
        .post(Uri.parse('${baseUrl}fetchhomedata/'), body: {'userid': userId});

    print('response categories: ' + baseUrl);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return homeModelFromJson(jsonString);
    }
    return homeModelFromJson(response.body);
  }
}
