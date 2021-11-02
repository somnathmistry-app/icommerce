import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icommerce/controllers/cart_controller.dart';
import 'package:icommerce/controllers/productdetails_controller.dart';
import 'package:icommerce/controllers/wishlist_controller.dart';
import 'package:icommerce/models/wish_list_model.dart';
import 'package:icommerce/styles/app_colors.dart';
import 'package:icommerce/styles/button_style.dart';
import 'package:icommerce/styles/commonmodule/app_bar.dart';
import 'package:icommerce/views/product_details_view.dart';

class WishListView extends StatelessWidget {
  //const WishListView({Key? key}) : super(key: key);
  WishListController wishListController = Get.put(WishListController());
  CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: appBar('Save Products'), body: getWishList());
  }

  getWishList() {
    return GetX<WishListController>(
      initState: (context) {
        wishListController.fetchWishlistProducts();
      },
      builder: (controller) {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return controller.wishListProducts.isEmpty
              ? const Center(
                  child: Text('No Products in Wishlist'),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  //physics: NeverScrollableScrollPhysics(),
                  //itemCount: 2,
                  itemCount: controller.wishListProducts.length,
                  itemBuilder: (context, index) {
                    //String name, String price, String img, int stock
                    //getTotalCartAmount(controller.cartListProducts);
                    return getWishListItems(controller.wishListProducts, index);

                    // controller.cartListProducts.value.list[index].product.data
                    //     .product.title,
                    // controller.cartListProducts.value.list[index].product.data
                    //     .product.variants.edges[0].node.price,
                    // controller.cartListProducts.value.list[index].product.data
                    //     .product.featuredImage.originalSrc,
                    // controller.cartListProducts.value.list[index].product.data
                    //     .product.totalInventory,
                    // index);
                  });
        }
      },
    );
  }

  getWishListItems(List<Wishlist> wishListProducts, int index) {
    return

      InkWell(
      onTap: () {
        ProductDetailsController.selectedProductId.value = wishListProducts[index].productid!;
        ProductDetailsController.selectedProductName.value = wishListProducts[index].productname!;

        Get.to(ProductDetailsView(wishListProducts[index].productid));
      },
      child: Card(
        elevation: 1,
        shadowColor: AppColors.themeColor,
        margin: const EdgeInsets.all(4),
        child: Container(
          height: 190,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 10),
              Container(
                width: 100,
                child: FadeInImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'http://ndugagambia.iwebnext.net/${wishListProducts[index].imgurl}'),
                    placeholder: const AssetImage('assets/images/loading.gif')),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 2, bottom: 2, left: 6, right: 8),
                    child: Text(
                      '${wishListProducts[index].productname}',
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.only(top: 2, bottom: 2, left: 6, right: 8),
                    child: Text(
                      'Mfg: Company name',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 11),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 6, bottom: 4, left: 6, right: 1),
                        child: Text(
                          wishListProducts[index].qty!.toString(),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 6, bottom: 4, left: 6, right: 1),
                        child: Text(
                          wishListProducts[index].unit.toString(),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 2, bottom: 2, left: 10, right: 1),
                    child: Text(
                      '\$ ${wishListProducts[index].baseprice!}',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 6, bottom: 6, left: 6, right: 1),
                        child: Text(
                          '\$ ${wishListProducts[index].price!.toString()}',
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          style: const TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 15),
                        ),
                      ),
                      SizedBox(width: 15),
                      Text(
                        '${wishListProducts[index].discount!.toString()} % off',
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                            fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 30,
                        width: 99,
                        child: ElevatedButton(
                            style: curveButtonStyleThemeColor,
                            onPressed: () {
                              cartController.addToCart(wishListProducts[index].productid!);
                              wishListController.deleteWishlist(
                                  wishListProducts[index].wishlistid!);
                              wishListController.wishListProducts
                                  .removeAt(index);
                            },
                            child: const Text(
                              'Add to cart',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 11),
                            )),
                      ),
                      const SizedBox(width: 20),
                      Container(
                        height: 30,
                        width: 99,
                        child: ElevatedButton(
                            style: elevatedCurveButtonStyleRed,
                            onPressed: () {
                              wishListController.deleteWishlist(
                                  wishListProducts[index].wishlistid!);
                              wishListController.wishListProducts
                                  .removeAt(index);
                            },
                            child: Row(
                              children: const [
                                Expanded(
                                    child: Icon(
                                  Icons.delete,
                                  size: 16,
                                  color: Colors.white,
                                )),
                                SizedBox(width: 8),
                                Text(
                                  '  Remove',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 11),
                                ),
                              ],
                            )),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
