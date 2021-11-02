import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:icommerce/apis/wishlist_api.dart';
import 'package:icommerce/models/wish_list_model.dart';


class WishListController extends GetxController {
  var box = GetStorage();
  var isLoading = true.obs;
  var wishListProducts = <Wishlist>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    fetchWishlistProducts();
    super.onInit();
  }

  addToWishList(String productId) async {
    //MyAlertDialog.circularProgressDialog();
    var response =
        await WishListApi.addToWishList(productId, box.read('userId'));

    if (response != null) {
      if (response.status == 'success') {
       // Get.back();
        // MySnackbar.successSnackBar(
        //     'Successfully added', 'Product added to wishList');
      }
      else if (response.status == 'exists') {
        //Get.back();
        // MySnackbar.infoSnackBar(
        //     'Already in List', 'Your Product is already in wishlist');
      }
      else {
       // Get.back();
       // MySnackbar.errorSnackBar('Server down!', 'Please try again later');
      }
    }
  }

  deleteWishlist(String wishListId) async {
    //MyAlertDialog.circularProgressDialog();
    var response = await WishListApi.deleteWishlistItem(wishListId);

    print('response in cart delete: ${response.status}');
    if (response != null) {
      if (response.status == 'success') {
        //Get.back();
        // //Get.to(CartView());
        // MySnackbar.successSnackBar(
        //     'Successfully deleted', 'Product deleted from cart');
        print('wishlist item deleted');
      } else {
        // Get.back();
        //MySnackbar.errorSnackBar('Server down!', 'Please try again later');
      }
    }
  }

  fetchWishlistProducts() async {
    try {
      isLoading(true);
      var products = await WishListApi.fetchWishList(box.read('userId'));
      print('wishListProducts $products');

      if (products != null) {
        wishListProducts.assignAll(products.wishlist!);
        update();
      }
    } finally {
      isLoading(false);
    }
  }
}
