import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:icommerce/models/cart_list.dart';
import 'package:icommerce/models/cart_list.dart';
import 'package:icommerce/models/status_model.dart';

class CartApi {
  static var client = http.Client();

  //prdid:8
  // userid:9
  // qty:2
  static Future<CartListModel> addToCart(
      String productId, String userId, String qty) async {
    var baseUrl = GlobalConfiguration().get('base_url');
    var response = await client.post(Uri.parse('${baseUrl}addtocart/'),
        body: {'prdid': productId, 'userid': userId, 'qty': qty});

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return cartListModelFromJson(jsonString);
    } else {
      return cartListModelFromJson(response.body);
    }
  }

  //
  static Future<StatusModel> deleteCart(
          String productId, String userId, String cartId) async {
        var baseUrl = GlobalConfiguration().get('base_url');

        // prdid:4
        // userid:9
        // cartid:270920214612
        var response = await client.post(Uri.parse('${baseUrl}removefromcart/'),
            body: {'prdid': productId, 'userid': userId, 'cartid': cartId});

        if (response.statusCode == 200) {
          var jsonString = response.body;
          return statusModelFromJson(jsonString);
        } else {
          return statusModelFromJson(response.body);
    }
  }

  // static Future<ResponseModel> removeFromWishList(
  //     String productId, String userId) async {
  //   var baseUrl = GlobalConfiguration().get('base_url');
  //
  //   var response = await client.post('${baseUrl}removeWishlist',
  //       body: {'user_id': userId, 'product_id': productId});
  //
  //   if (response.statusCode == 200) {
  //     var jsonString = response.body;
  //     return responseModelFromJson(jsonString);
  //   } else
  //     return responseModelFromJson(response.body);
  // }

  static Future<CartListModel> fetchCartList(String userId) async {
    var baseUrl = GlobalConfiguration().get('base_url');

    var response = await client
        .post(Uri.parse('${baseUrl}cartlist/'), body: {'userid': userId});

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return cartListModelFromJson(jsonString);
    }
    return cartListModelFromJson(response.body);
  }


  // prdid:7
  // userid:9
  // qty:-3
  // cartid:21020212630
  static Future<CartListModel> updateToCart(
      String productId, String userId, String qty, cartId) async {
    var baseUrl = GlobalConfiguration().get('base_url');
    var response = await client.post(Uri.parse('${baseUrl}updatecart/'),
        body: {'prdid': productId, 'userid': userId, 'qty': qty, 'cartid':cartId});

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return cartListModelFromJson(jsonString);
    } else {
      return cartListModelFromJson(response.body);
    }
  }
}
