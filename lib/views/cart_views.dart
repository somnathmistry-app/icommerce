import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:icommerce/controllers/cart_controller.dart';
import 'package:icommerce/controllers/productdetails_controller.dart';
import 'package:icommerce/models/cart_list.dart';
import 'package:icommerce/styles/app_colors.dart';
import 'package:icommerce/styles/button_style.dart';
import 'package:icommerce/styles/commonmodule/app_bar.dart';
import 'package:icommerce/styles/commonmodule/my_widgets.dart';
import 'package:icommerce/views/product_details_view.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'address_view.dart';

class CartView extends StatefulWidget {
  //const CartView({Key? key}) : super(key: key);
  String? cartFrom;


  CartView({this.cartFrom});

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  CartController cartController = Get.put(CartController());
  var imageUrl = GlobalConfiguration().get('image_url');

  @override
  Widget build(BuildContext context) {
    return

      Scaffold(
      backgroundColor: Colors.white,
      //bottomNavigationBar:  getCartBarItem(),

      appBar: widget.cartFrom=='noappbar'?null:appBar('Cart'),
      body: SafeArea(
        child: LimitedBox(
            maxHeight: double.infinity,
            child: GetX<CartController>(
              initState: (context) {
                cartController.fetchCartListProducts();
              },
              builder: (controller) {
                if (controller.isLoading.value) {
                  return
                    Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        HeartbeatProgressIndicator(
                          child: Icon(Icons.shopping_cart,
                              color: AppColors.themeColorTwo),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Loading cart..',
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  );
                } else {
                  return controller.cartListProducts.isEmpty
                      ? const Center(
                          child: Text('No Products in cart'),
                        )
                      : Stack(
                          children: [
                            ListView(
                              children: [
                                const SizedBox(height: 20),
                                getOrderTrack(),
                                const SizedBox(height: 25),
                                Row(
                                  children: [
                                    const SizedBox(width: 10),
                                    Image.asset(
                                      'assets/images/cartgif.gif',
                                      scale: 17,
                                    ),
                                    Card(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0,
                                            right: 10,
                                            top: 4,
                                            bottom: 4),
                                        child:
                                            controller.cartListProducts.length >
                                                    1
                                                ? Text(
                                                    '${controller.cartListProducts.length} items in cart',
                                                    style: const TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.blue),
                                                  )
                                                : Text(
                                                    '${controller.cartListProducts.length} item in cart',
                                                    style: const TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.blue),
                                                  ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Obx(() => getCartList(controller)),
                                const SizedBox(height: 80),
                              ],
                            ),
                            Positioned(
                                bottom: 1,
                                left: 1,
                                right: 2,
                                child: getCartBarItem(controller))
                          ],
                        );
                }
              },
            )),
      ),
    );
  }

  getCartList(CartController controller) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.cartListProducts.length,
        itemBuilder: (context, index) {
          //String name, String price, String img, int stock
          //getTotalCartAmount(controller.cartListProducts);
          return Obx(() => getCartItems(controller.cartListProducts, index));
        });
  }

  getCartItems(RxList<Cartlist> cartListProducts, int index) {
    return InkWell(
      onTap: () {
        ProductDetailsController.selectedProductName.value =
            cartListProducts[index].productname!;
        ProductDetailsController.selectedProductId.value =
            cartListProducts[index].productid!;
        Get.to(ProductDetailsView(cartListProducts[index].productid));
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
                        '$imageUrl${cartListProducts[index].imgurl}'),
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
                    child: SizedBox(

                      child: Text(
                        '${cartListProducts[index].productname}',
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
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
                          cartListProducts[index].quantity.toString(),
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
                          cartListProducts[index].unit.toString(),
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
                      '\$ ${cartListProducts[index].mrp!}',
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
                          '\$ ${cartListProducts[index].totprice.toString()}',
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          style: const TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 15),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        '${cartListProducts[index].discount.toString()} % off',
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
                    children: [
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            children: [
                              GestureDetector(
                                  onTap: () async {
                                    //cartController.cartListProducts[0]
                                    if (cartController.cartListProducts[index]
                                            .quantity! !=
                                        "1") {
                                      cartController.updateCart(
                                          cartListProducts[index].productid!,
                                          "-1",
                                          cartListProducts[index].cartid!);
                                    } else {
                                      cartController.deleteCart(
                                          cartListProducts[index].productid!,
                                          cartListProducts[index].cartid!);
                                      cartController.cartListProducts
                                          .removeAt(index);
                                    }
                                    //await cartController.fetchCartListProducts();
                                  },
                                  child: Image.asset(
                                    'assets/images/minus.png',
                                    scale: 22,
                                  )),
                              // Obx(
                              //   () =>
                              MyWidgets.textView(
                                  '  ${cartListProducts[index].quantity}  ',
                                  Colors.black54,
                                  14,
                                  fontWeight: FontWeight.w800),
                              //),
                              GestureDetector(
                                child: Image.asset('assets/images/plus.png',
                                    scale: 22),
                                onTap: () async {
                                  cartController.updateCart(
                                      cartListProducts[index].productid!,
                                      "1",
                                      cartListProducts[index].cartid!);
                                  // await cartController.fetchCartListProducts();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 35),
                      Container(
                        height: 30,
                        width: 92,
                        child: ElevatedButton(
                            style: elevatedCurveButtonStyleRed,
                            onPressed: () async {
                              cartController.deleteCart(
                                  cartListProducts[index].productid!,
                                  cartListProducts[index].cartid!);
                              cartController.cartListProducts.removeAt(index);
                              // await cartController.fetchCartListProducts();
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
                                      color: Colors.white, fontSize: 10),
                                ),
                              ],
                            )),
                      )
                      // InkWell(
                      //
                      //     onTap: (){
                      //       cartController.deleteCart(cartListProducts[index].productid!, cartListProducts[index].cartid!);
                      //       cartController.cartListProducts.removeAt(index);
                      //     },
                      //     child: Row(
                      //       children: const [
                      //         Icon(Icons.delete, color: Colors.red),
                      //         Text('Remove', style: TextStyle(fontSize: 12),)
                      //       ],
                      //     )),

                      //Obx(() =>

                      //),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  incremnetQnty(int index, int selectedQty) {
    int cartQnt;
    if (selectedQty < 10) {
      selectedQty++;
      //int cartQnt;
      // selectedQnty.value = int.parse(cartListProducts[index].quantity);
    }
  }

  getOrderTrack() {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(width: 1),
        MyWidgets.mySingleTrack('Cart  ', 'assets/images/check_green.svg',
            imgWidth: 18),
        Container(width: 45, height: 1, color: Colors.black),
        MyWidgets.mySingleTrack('Address  ', 'assets/images/check.svg',
            imgWidth: 18),
        Container(width: 45, height: 1, color: Colors.black),
        MyWidgets.mySingleTrack('Payment  ', 'assets/images/check.svg',
            imgWidth: 18),
        const SizedBox(width: 2)
      ],
    ));
  }

  getCartBarItem(CartController controller) {
    return Card(
        elevation: 2,
        margin: const EdgeInsets.only(left: 14, right: 14, bottom: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 15),
              height: 58,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '\$ ${controller.totalPrice.toString()}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  const Text(
                    'Payable amount',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 10,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
            Container(
              height: 45,
              margin: const EdgeInsets.only(right: 6),
              width: 120,
              child: ElevatedButton(
                  style: curveButtonStyleThemeColorTow,
                  onPressed: () {
                    //String? totalAmount, totalMrp, totalSavings;
                    Get.to(AddressView(
                        controller.cartListProducts[0].cartid.toString()));
                  },
                  child: const Text(
                    'Checkout',
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ));
  }
}

