import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:icommerce/models/product_model.dart';

class ProductApi {
  static var client = http.Client();

  static Future<ProductModel> fetchPrductList(String catId, String userId) async {
    var baseUrl = GlobalConfiguration().get('base_url');

    // box.write('schoolId', schoolId);
    //        box.write('teacherId', teacherId);

    var response = await client
        .post(Uri.parse('${baseUrl}categorywiseproduct/'), body: {'catid': catId, 'userid': userId});

    print('response categories: ' + baseUrl);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return productModelFromJson(jsonString);
    }
    return productModelFromJson(response.body);
  }

  static Future<ProductModel> fetchAllPrductList() async {
    var baseUrl = GlobalConfiguration().get('base_url');

    // box.write('schoolId', schoolId);
    //        box.write('teacherId', teacherId);

    var response = await client
        .post(Uri.parse('${baseUrl}productlist/'));

    print('response all productlist: ' + baseUrl);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return productModelFromJson(jsonString);
    }
    return productModelFromJson(response.body);
  }

  static Future<ProductModel> fetchsearchPrductList(String query) async {
    var baseUrl = GlobalConfiguration().get('base_url');

    // box.write('schoolId', schoolId);
    //        box.write('teacherId', teacherId);

    var response = await client
        .post(Uri.parse('${baseUrl}productlist/'), body: {'serchvalue': query});

    print('response all productlist: ' + baseUrl);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return productModelFromJson(jsonString);
    }
    return productModelFromJson(response.body);
  }
}
