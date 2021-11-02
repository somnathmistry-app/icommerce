import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:icommerce/apis/product_api.dart';
import 'package:icommerce/models/product_model.dart';

class ProductController extends GetxController{
  var isLoading = true.obs;
  var productList = <Productlist>[].obs;
  var box = GetStorage();

  getProductList(String catId) async {
    try {
      isLoading(true);
      var products = await ProductApi.fetchPrductList(catId, box.read('userId').toString());
      print('products $products');

      if (products != null) {
        productList.assignAll(products.productlist!);

        // categoryListStatic.assignAll(categories);
      }
    } finally {
      isLoading(false);
    }
  }

  getAllProductList() async {
    try {
      isLoading(true);
      var products = await ProductApi.fetchAllPrductList();
      print('all products $products');

      if (products != null) {
        productList.assignAll(products.productlist!);
        // final products = productList.value.where((product) {
        //   final titleLower = product.productname!.toLowerCase();
        //   final authorLower = product.businessname!.toLowerCase();
        //   final searchLower = query.toLowerCase();
        //
        //   return titleLower.contains(searchLower) ||
        //       authorLower.contains(searchLower);
        // }).toList();
        // categoryListStatic.assignAll(categories);
      }
    } finally {
      isLoading(false);
    }
  }

  getSearchProductList(String query) async {
    try {
      isLoading(true);
      var products = await ProductApi.fetchsearchPrductList(query);
      print('all products $products');

      if (products != null) {
        productList.assignAll(products.productlist!);
        // final products = productList.value.where((product) {
        //   final titleLower = product.productname!.toLowerCase();
        //   final authorLower = product.businessname!.toLowerCase();
        //   final searchLower = query.toLowerCase();
        //
        //   return titleLower.contains(searchLower) ||
        //       authorLower.contains(searchLower);
        // }).toList();
        // categoryListStatic.assignAll(categories);
      }
    } finally {
      isLoading(false);
    }
  }
}