import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:icommerce/models/status_model.dart';
import 'package:icommerce/models/wish_list_model.dart';

class WishListApi {
  static var client = http.Client();

  static Future<StatusModel> addToWishList(
      String productId, String userId) async {
    var baseUrl = GlobalConfiguration().get('base_url');

    var response = await client.post(Uri.parse('${baseUrl}addtowishlist/'),
        body: {'userid': userId, 'prdid': productId});

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return statusModelFromJson(jsonString);
    } else {
      return statusModelFromJson(response.body);
    }
  }

  static Future<StatusModel> deleteWishlistItem(String wishlistId) async {
    var baseUrl = GlobalConfiguration().get('base_url');

    // prdid:4
    // userid:9
    // cartid:270920214612
    var response = await client.post(Uri.parse('${baseUrl}removetowishlist/'),
        body: {'wishlistid': wishlistId});

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return statusModelFromJson(jsonString);
    } else {
      return statusModelFromJson(response.body);
    }
  }

  static Future<WishListModel> fetchWishList(String userId) async {
    var baseUrl = GlobalConfiguration().get('base_url');

    var response = await client.post(Uri.parse('${baseUrl}wishlist/'), body: {'userid': userId});

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return wishListModelFromJson(jsonString);
    }
    return wishListModelFromJson(response.body);
  }
}
