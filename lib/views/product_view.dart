import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:icommerce/controllers/login_controller.dart';
import 'package:icommerce/controllers/product_controller.dart';
import 'package:icommerce/controllers/productdetails_controller.dart';
import 'package:icommerce/controllers/wishlist_controller.dart';
import 'package:icommerce/models/product_model.dart';
import 'package:icommerce/styles/app_colors.dart';
import 'package:icommerce/styles/commonmodule/app_bar.dart';
import 'package:icommerce/styles/commonmodule/my_snack_bar.dart';
import 'package:icommerce/views/login_view.dart';
import 'package:icommerce/views/product_details_view.dart';

class ProductView extends StatelessWidget {
  String categoryId;
  String categoryName;

  ProductView(this.categoryId, this.categoryName, {Key? key}) : super(key: key);

  ProductController productController = Get.put(ProductController());
  WishListController wishListController = Get.put(WishListController());
  var imageUrl = GlobalConfiguration().get('image_url');
  LoginController loginController = Get.put(LoginController());
  var box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: appBarCart(categoryName), body: getProductPage());
  }

  getProductPage() {
    return LimitedBox(
      maxHeight: double.infinity,
      child: GetX<ProductController>(
        initState: (context) {
          productController.getProductList(categoryId);
        },
        builder: (controller) {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return controller.productList.isEmpty
                ? Center(
                    child: Text('No Products in $categoryName'),
                  )
                : GridView.count(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    // physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: 8.0 / 13.0,
                    children: List<Widget>.generate(
                        controller.productList.length, (index) {
                      return controller.productList[index].isActive == 'True'
                          ? getProductTile(controller.productList, index)
                          : Container();
                    }));
          }
        },
      ),
    );
  }

//String image, String name, String mrp, String price,
//           String discount, String mfgName
  getProductTile(List<Productlist> productList, int index) => InkWell(
        onTap: () {
          ProductDetailsController.selectedProductId.value =
              productList[index].srno!;
          ProductDetailsController.selectedProductName.value =
              productList[index].productname!;
          Get.to(ProductDetailsView(productList[index].srno,
              isWishlist: productList[index].iswishlisted));
        },
        child: GridTile(
          child: Card(
              elevation: 1,
              shadowColor: AppColors.themeColor,
              margin: const EdgeInsets.all(4),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 2.0),
                    Expanded(
                        child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: FadeInImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  '$imageUrl${productList[index].thumbimg!}'),
                              placeholder: const AssetImage(
                                  'assets/images/loading.gif')),
                        ),
                        Positioned(
                          top: 4,
                          right: 1,
                          child: Card(
                            //color: Colors.white70,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: FavoriteButton(
                                iconDisabledColor: Colors.grey,
                                iconSize: 34,
                                isFavorite: productList[index].iswishlisted!,
                                // iconDisabledColor: Colors.white,
                                valueChanged: (_isFavorite) {
                                  if (_isFavorite == true) {
                                    print(
                                        'isLogin in product view: ${loginController.isLogin.value}');
                                    if (loginController.isLogin.value ||
                                        box.hasData('userId')) {
                                      wishListController.addToWishList(
                                          productList[index].srno!);
                                    } else {
                                      Get.to(LoginView());
                                      MySnackbar.infoSnackBar('Please Login',
                                          'You have to login first for add in wishlist');
                                    }
                                  } else {
                                    wishListController.addToWishList(
                                        productList[index].srno!);
                                  }
                                  print(
                                      'Is Favorite : $_isFavorite, isWislisted: ${productList[index].iswishlisted!}');
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 2, bottom: 2, left: 10, right: 8),
                      child: Text(
                        productList[index].productname!,
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 14),
                      ),
                    ),

                    //Rating Star
                    productList[index].avgrating == ""
                        ? Container()
                        : Card(
                            margin: const EdgeInsets.only(left: 10),
                            shadowColor: Colors.black,
                            elevation: 3,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 3, bottom: 3, left: 7, right: 7),
                                child: Container(
                                  width: 38,
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        double.parse(
                                                productList[index].avgrating!)
                                            .toStringAsFixed(1),
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 11),
                                      ),
                                    ],
                                  ),
                                )),
                          ),

                    productList[index].businessname == ""
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(
                                top: 2, bottom: 2, left: 10, right: 8),
                            child: Text(
                              'Mfg: ${productList[index].businessname}',
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 11),
                            ),
                          ),
                    const SizedBox(height: 8),
                    productList[index].discount == '0' ||
                            productList[index].discount == null
                        ? Container()
                        : Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 2, bottom: 2, left: 10, right: 1),
                                child: Text(
                                  '\$ ${productList[index].baseprice!}',
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Card(
                                shadowColor: Colors.black,
                                elevation: 3,
                                color: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 3, bottom: 3, left: 7, right: 7),
                                    child: Text(
                                      '${productList[index].discount!} % off',
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      style: const TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10),
                                    )),
                              ),
                            ],
                          ),
                    const SizedBox(height: 2),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 4, bottom: 4, left: 10, right: 10),
                      child: Text(
                        '\$ ${productList[index].newprice!}',
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: const TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 16),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                            padding: EdgeInsets.only(
                                top: 6, bottom: 8, left: 10, right: 2),
                            child: Text(
                              '  In Stock',
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11),
                            )),
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, bottom: 5, left: 12, right: 12),
                              child: Text(
                                '${productList[index].qty} ${productList[index].unitid}',
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: const TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11),
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              )),
        ),
      );
}
