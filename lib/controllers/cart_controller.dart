import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:icommerce/apis/cart_api.dart';
import 'package:icommerce/apis/order_api.dart';
import 'package:icommerce/models/cart_list.dart';
import 'package:icommerce/styles/commonmodule/my_alert_dilog.dart';
import 'package:icommerce/styles/commonmodule/my_snack_bar.dart';
import 'package:icommerce/views/address_view.dart';
import 'package:icommerce/views/cart_views.dart';

class CartController extends GetxController {
  var box = GetStorage();
  var isLoading = true.obs;

  //var cartListProductsList = List<ListElement>().obs;
  var cartListProducts = <Cartlist>[].obs;
  var totalPrice = 0.0.obs;
  var totalMrp = 0.0.obs;
  var totalSaving = 0.0.obs;
  var selectedQuantity = '1'.obs;
  static var cartItem = '0'.obs;

  @override
  void onInit() {
    fetchCartListProducts();
  }

  addToCart(String productId) async {
    MyAlertDialog.circularProgressDialog();
    //String productId, String userId, String qty
    var response = await CartApi.addToCart(
        productId, box.read('userId'), selectedQuantity.value.toString());

    if (response != null) {
      if (response.status == 'success') {
        Get.back();
        Get.to(CartView());
        MySnackbar.successSnackBar(
            'Successfully added', 'Product added to cart');
      } else if (response.status == 'exists') {
        Get.back();
        Get.to(CartView());
        MySnackbar.infoSnackBar('Already in cart', 'Product already in cart');
      } else {
        Get.back();
        MySnackbar.errorSnackBar('Server down!', 'Please try again later');
      }
    }
  }

  fetchCartListProducts() async {
    try {
      isLoading(true);
      var products = await CartApi.fetchCartList(box.read('userId'));
      print('cartlistProduct $products');
      if (products != null) {
        cartListProducts.assignAll(products.cartlist!);
        totalPrice.value = products.totprice!;
        totalMrp.value = products.totmrp!;
        totalSaving.value = products.tosavings!;
        cartItem.value = products.cartlist!.length.toString();
        print('cart item: ${cartItem.value}');
        update();
      }
    } finally {
      isLoading(false);
    }
  }

  //String productId, String userId,
  deleteCart(String productId, String cartId) async {
    MyAlertDialog.circularProgressDialog();
    var response = await CartApi.deleteCart(
      productId,
      box.read('userId'),
      cartId,
    );

    print('response in cart delete: ${response.status}');
    if (response != null) {
      if (response.status == 'success') {
        Get.back();
        // //Get.to(CartView());
        fetchCartListProducts();
        print('cart item deleted');
      } else {
        Get.back();
        //MySnackbar.errorSnackBar('Server down!', 'Please try again later');
      }
    }
  }

  // prdid:7
  // userid:9
  // qty:-3
  // cartid:21020212630
  updateCart(String productId, String qty, String cartId) async {
    MyAlertDialog.circularProgressDialog();
    //String productId, String userId, String qty
    var response =
        await CartApi.updateToCart(productId, box.read('userId'), qty, cartId);

    if (response != null) {
      if (response.status == 'updated') {
        Get.back();
        fetchCartListProducts();
        //Get.to(CartView());
        // MySnackbar.successSnackBar(
        //     'Successfully updated', 'Product updated successfully');
      } else {
        Get.back();
        //MySnackbar.errorSnackBar('Server down!', 'Please try again later');
      }
    }
  }

  buyNow(String productid) async {
    MyAlertDialog.circularProgressDialog();
    //String productId, String userId, String qty
    var response = await OrderApi.buyNowOrder(
        box.read("userId"), productid, selectedQuantity.value.toString());

    if (response != null) {
      if (response.status == 'success') {
        Get.back();
        print('cartId in pdetails: ${response.cartid}');
        Get.to(AddressView(response.cartid));
      } else {
        Get.back();
        //MySnackbar.errorSnackBar('Server down!', 'Please try again later');
      }
    }
  }
}
