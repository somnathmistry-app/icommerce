import 'package:get/get.dart';
import 'package:icommerce/apis/product_details_api.dart';
import 'package:icommerce/models/product_details.dart';

class ProductDetailsController extends GetxController {
  var isLoading = true.obs;
  var productDetailsData = Prddata();
  var similarProduct = <Prddata>[];
  var productImgList = <Prdimglist>[];
  var productReviewList = <Reviewlist>[];
  static var selectedProductId = '0'.obs;
  static var selectedProductName = 'Product Details'.obs;

  List<String> getQuantity() {
    List<String> quantityList = [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10'
    ];
    return quantityList;
  }

  fetchProductDetails(String productId) async {
    try {
      isLoading(true);
      var productsData = await ProductDetailsApi.fetchProductDetails(productId);
      print('productDetails $productsData');

      if (productsData != null) {
        productDetailsData = productsData.prddata!;
        similarProduct.assignAll(productsData.similarprdlist!);
        productImgList.assignAll(productsData.prdimglist!);
        productReviewList.assignAll(productsData.reviewlist!);
        update();
      }
    } finally {
      isLoading(false);
    }
  }


}
