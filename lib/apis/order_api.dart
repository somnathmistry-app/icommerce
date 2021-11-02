import 'package:global_configuration/global_configuration.dart';
import 'package:icommerce/models/buynow_model.dart';
import 'package:icommerce/models/order_list_model.dart';
import 'package:icommerce/models/status_model.dart';
import 'package:http/http.dart' as http;

class OrderApi {
  static var client = http.Client();

  //cartid:51020211507
  // deliveraddressid:32
  // userid:9

  static Future<StatusModel> codCartOrder(
      String cartid, String deliveraddressid, String userId) async {
    var baseUrl = GlobalConfiguration().get('base_url');
    var response = await client.post(Uri.parse('${baseUrl}CreateOrderCOD/'),
        body: {
          'cartid': cartid,
          'deliveraddressid': deliveraddressid,
          'userid': userId
        });
    print(
        'Cod cart order-- cartId: $cartid, deliveryaddressId: $deliveraddressid');

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return statusModelFromJson(jsonString);
    } else {
      return statusModelFromJson(response.body);
    }
  }

  static Future<StatusModel> onlineCartOrder(String cartid,
      String deliveraddressid, String userId, String txnid) async {
    var baseUrl = GlobalConfiguration().get('base_url');
    var response =
        await client.post(Uri.parse('${baseUrl}CreateOrderOnline/'), body: {
      'cartid': cartid,
      'deliveraddressid': deliveraddressid,
      'userid': userId,
      'txnid': txnid
    });

    print(
        'Online cart order-- cartId: $cartid, deliveryaddressId: $deliveraddressid, txnId: $txnid');
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return statusModelFromJson(jsonString);
    } else {
      return statusModelFromJson(response.body);
    }
  }

  //userid:9
  // productid:9
  // qty:2
  static Future<BuyNowModel> buyNowOrder(
      String userid, String productid, String qty) async {
    var baseUrl = GlobalConfiguration().get('base_url');
    var response = await client.post(Uri.parse('${baseUrl}addtobuynow/'),
        body: {'userid': userid, 'prdid': productid, 'qty': qty});
    print(
        'Buy now cart order-- userid: $userid, productid: $productid, qty:$qty');

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return buyNowModelFromJson(jsonString);
    } else {
      return buyNowModelFromJson(response.body);
    }
  }

  static Future<OrderListModel> fetchOrderList(String userId) async {
    var baseUrl = GlobalConfiguration().get('base_url');

    var response = await client
        .post(Uri.parse('${baseUrl}userorderlist/'), body: {'userid': userId});

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return orderListModelFromJson(jsonString);
    }
    return orderListModelFromJson(response.body);
  }

  //userid:9
  // review:Awsome product
  // star:2
  // productid:8
  static Future<StatusModel> addReview(
      String userid, String review, String star, String productid) async {
    var baseUrl = GlobalConfiguration().get('base_url');
    var response = await client.post(Uri.parse('${baseUrl}adduserreview'),
        body: {
          'userid': userid,
          'review': review,
          'star': star,
          'productid': productid
        });

    print(
        'review-- userid: $userid, review: $review, star: $star, productid : $productid');

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return statusModelFromJson(jsonString);
    } else {
      return statusModelFromJson(response.body);
    }
  }

  static Future<StatusModel> cancelOrder(String userid, String idd) async {
    var baseUrl = GlobalConfiguration().get('base_url');
    var response = await client.post(Uri.parse('${baseUrl}cancelorder/'),
        body: {'userid': userid, 'idd': idd});

    print('review-- userid: $userid, idd: $idd');

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return statusModelFromJson(jsonString);
    } else {
      return statusModelFromJson(response.body);
    }
  }

  static Future<StatusModel> returnOrder(String userid, String idd) async {
    var baseUrl = GlobalConfiguration().get('base_url');
    var response = await client.post(Uri.parse('${baseUrl}returnorder/'),
        body: {'userid': userid, 'idd': idd});

    print('review-- userid: $userid, idd: $idd');

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return statusModelFromJson(jsonString);
    } else {
      return statusModelFromJson(response.body);
    }
  }
}
