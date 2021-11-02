import 'package:http/http.dart' as http;
import 'package:global_configuration/global_configuration.dart';
import 'package:icommerce/models/product_details.dart';

class ProductDetailsApi {
  static var client = http.Client();

  static Future<ProductDetailsModel> fetchProductDetails(String productId) async {
    var baseUrl = GlobalConfiguration().get('base_url');

    // box.write('schoolId', schoolId);
    //        box.write('teacherId', teacherId);
//productList

    var response =
        await client.post(Uri.parse('${baseUrl}productdetailsbyid/'), body: {'prdid': productId});

    print('response ProductsApi: ' + baseUrl);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      //return productListModelFromJson(jsonString).data.collection.products.edges;
      return productDetailsModelFromJson(jsonString);
    }
    else {
      return productDetailsModelFromJson(response.body);
    }
  }
}
