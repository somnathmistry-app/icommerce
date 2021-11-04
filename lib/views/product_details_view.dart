import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:html/parser.dart' show parse;
import 'package:html_unescape/html_unescape.dart';
import 'package:icommerce/controllers/cart_controller.dart';
import 'package:icommerce/controllers/login_controller.dart';
import 'package:icommerce/controllers/productdetails_controller.dart';
import 'package:icommerce/controllers/wishlist_controller.dart';
import 'package:icommerce/models/product_details.dart';
import 'package:icommerce/styles/app_colors.dart';
import 'package:icommerce/styles/button_style.dart';
import 'package:icommerce/styles/commonmodule/my_snack_bar.dart';
import 'package:icommerce/styles/commonmodule/my_widgets.dart';
import 'package:icommerce/views/image_details_view.dart';
import 'package:icommerce/views/viewall_reviews.dart';
import 'package:photo_view/photo_view.dart';
import 'login_view.dart';

class ProductDetailsView extends StatefulWidget {
  @override
  _ProductDetailsViewState createState() => _ProductDetailsViewState();
  String? productId;
  bool? isWishlist;

  //String? productName;
  ProductDetailsView(this.productId, {this.isWishlist});
//ProductDetailsView(this.productName);
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  ProductDetailsController productDetailsController =
      Get.put(ProductDetailsController());
  CartController cartController = Get.put(CartController());
  WishListController wishListController = Get.put(WishListController());
  var imageUrl = GlobalConfiguration().get('image_url');
  LoginController loginController = Get.put(LoginController());
  var box = GetStorage();
  var document =
      parse('<body>Hello world! <a href="www.html5rocks.com">HTML5 rocks!');
  var unescape = HtmlUnescape();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: bottomBar(),
        appBar: AppBar(
            title: Obx(() => Text(
                  ProductDetailsController.selectedProductName.value,
                  style: const TextStyle(fontSize: 16),
                ))),
        body: getProductDetailsPage());
  }

  //Obx(()=>appBarCart(ProductDetailsController.selectedProductName.value)

  Widget bottomBar() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 36,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.themeColorTwo,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            margin: const EdgeInsets.only(left: 15),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: DropdownButton<String>(
                  icon: const Icon(Icons.arrow_drop_up),
                  underline: const SizedBox(),
                  items: productDetailsController
                      .getQuantity()
                      .map((String stringItemValue) {
                    return DropdownMenuItem<String>(
                      value: stringItemValue,
                      child: Text(stringItemValue),
                    );
                  }).toList(),
                  onChanged: (String? selectedItem) {
                    setState(() {
                      cartController.selectedQuantity.value = selectedItem!;
                    });
                  },
                  value: cartController.selectedQuantity.value),
            ),
          ),
          FlatButton(
            onPressed: () {
              if (loginController.isLogin.value || box.hasData('userId')) {
                //ProductDetailsController.selectedProductId.value
                //cartController.addToCart(widget.productId!);
                cartController.addToCart(
                    ProductDetailsController.selectedProductId.value);
              } else {
                Get.to(LoginView());
                MySnackbar.infoSnackBar(
                    'Please Login', 'You have to login first for add in cart');
              }
            },
            child: const Text('ADD TO CART',
                style: TextStyle(color: Colors.black)),
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: AppColors.themeColorTwo,
                    width: 1,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(4)),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: RaisedButton(
                color: AppColors.themeColorTwo,
                child: MyWidgets.textView('BUY NOW', Colors.white, 14),
                onPressed: () {
                  if (loginController.isLogin.value || box.hasData('userId')) {
                    double totalPrice = double.parse(productDetailsController
                            .productDetailsData.newprice!) *
                        double.parse(cartController.selectedQuantity.value);
                    double totalMrp = double.parse(productDetailsController
                            .productDetailsData.baseprice!) *
                        double.parse(cartController.selectedQuantity.value);
                    double totalSaving = totalMrp - totalPrice;
                    //assign price to cart controller value
                    cartController.totalPrice.value = totalPrice;
                    cartController.totalMrp.value = totalMrp;
                    cartController.totalSaving.value = totalSaving;

                    //ProductDetailsController.selectedProductId.value
                    cartController.buyNow(
                        ProductDetailsController.selectedProductId.value);
                    //cartController.buyNow(widget.productId!);
                    //Get.to(AddressView(widget.productId!));
                  } else {
                    Get.to(LoginView());
                    MySnackbar.infoSnackBar('Please Login',
                        'You have to login first to buy this product');
                  }
                }),
          ),
        ],
      ),
    );
  }

  getProductDetailsPage() {
    return LimitedBox(
      maxHeight: double.infinity,
      child: GetX<ProductDetailsController>(
        initState: (context) {
          productDetailsController.fetchProductDetails(widget.productId!);
        },
        builder: (controller) {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return controller.productDetailsData == null
                ? const Center(
                    child: Text('No Product Details available'),
                  )
                : getProductDetailsList(
                    controller.productDetailsData,
                    controller.productImgList,
                    controller.similarProduct,
                    controller.productReviewList);
          }
        },
      ),
    );
  }

  getProductDetailsList(
      Prddata productDetailsData,
      List<Prdimglist> productImgList,
      List<Prddata> similarProduct,
      List<Reviewlist> productReviewList) {
    // ProductDetailsController.selectedProductName.value =
    //     productDetailsData.productname!;
    return ListView(
      padding: const EdgeInsets.only(left: 14, right: 12),
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 25.0, bottom: 8.0),
          child: MyWidgets.textView(
              productDetailsData.productname!, Colors.black, 22,
              fontWeight: FontWeight.w600),
        ),
        productDetailsData.businessname == "" ||
                productDetailsData.businessname == null
            ? Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: MyWidgets.textView(
                    'Seller unavailable', Colors.black, 16,
                    fontWeight: FontWeight.w400),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: MyWidgets.textView(
                    '${productDetailsData.businessname}', Colors.black, 16,
                    fontWeight: FontWeight.w400),
              ),
        const SizedBox(height: 4),
        productDetailsData.avgrating == "" ||
                productDetailsData.avgrating == null
            ? Container()
            : Row(
                children: [
                  Card(
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
                          width: 48,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star,
                                size: 17,
                                color: Colors.orange,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                double.parse(productDetailsData.avgrating!)
                                    .toStringAsFixed(1),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        )),
                  ),
                  MyWidgets.textView(
                      '  ${productReviewList.length} ratings & review',
                      Colors.black54,
                      13),
                ],
              ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              color: Colors.amber,
              height: 30,
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.black, size: 18),
                  MyWidgets.textView(' BEST PRICE  ', Colors.black, 12)
                ],
              ),
            ),
            Card(
              //color: Colors.white70,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: FavoriteButton(
                  iconDisabledColor: Colors.grey,
                  iconSize: 34,
                  isFavorite: widget.isWishlist,
                  // iconDisabledColor: Colors.white,
                  valueChanged: (_isFavorite) {
                    if (_isFavorite == true) {
                      wishListController
                          .addToWishList(productDetailsData.srno!);
                    } else {
                      wishListController
                          .addToWishList(productDetailsData.srno!);
                    }
                    //print('Is Favorite : $_isFavorite');
                  },
                ),
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: Align(
              alignment: Alignment.topRight,
              child: Icon(Icons.share, color: Colors.blue)),
        ),
        //Slider
        Center(
            child: Container(
          margin: const EdgeInsets.only(top: 10, bottom: 15),
          // height: 240,
          child: InkWell(
            onTap: () {
              Get.to(ImageDetialsView(getSliderList(productImgList)));
            },
            child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: false,
                aspectRatio: 1.0,
                enlargeCenterPage: true,
              ),
              //items: [Image.asset('assets/images/banner1.jpg')],
              items: getSliderList(productImgList),
            ),
          ),

          // FadeInImage(
          //     fit: BoxFit.fitHeight,
          //     //https://cdn.shopify.com/s/files/1/0521/4027/7914/products/PRE-C90_Supreme.png?v=1611780492
          //     image: NetworkImage(controller.productDetailsData
          //         .product.featuredImage.originalSrc),
          //     placeholder: AssetImage('assets/images/loading.gif')),
          //
        )),
        const SizedBox(height: 30),
        productDetailsData.discount == '0' ||
                productDetailsData.discount == null
            ? Container()
            : Text(
                ' MRP \$ ${productDetailsData.baseprice.toString()}',
                style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    decoration: TextDecoration.lineThrough),
              ),
        const SizedBox(height: 6),
        Row(
          children: [
            MyWidgets.textView("\$ ${productDetailsData.newprice.toString()} ",
                Colors.black, 25,
                fontWeight: FontWeight.w900),
            productDetailsData.discount == '0' ||
                    productDetailsData.discount == null
                ? Container()
                : Card(
                    color: Colors.green,
                    child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 2, bottom: 2),
                        child: Text(
                          '${productDetailsData.discount.toString()} % off',
                          style: const TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              fontSize: 13),
                        )),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  )
          ],
        ),
        const SizedBox(height: 4),
        MyWidgets.textView('Including all texes', Colors.black54, 12),
        const SizedBox(height: 6),
        Row(
          children: [
            MyWidgets.textView('In Stock', Colors.green, 13.0),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 5, left: 12, right: 12),
                      child: Text(
                        '${productDetailsData.qty} ${productDetailsData.unitid}',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w800,
                            fontSize: 13),
                      )),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 6),
        /*
                  SizedBox(height: 20),
                  MyWidgets.textView('Highlights', Colors.black, 16,
                      fontWeight: FontWeight.w700),
                  SizedBox(height: 6),
                  MyWidgets.textView(
                      'Highlights one\nHighlights two\nHighlights three\nHighlights four',
                      Colors.black,
                      14,
                      fontWeight: FontWeight.w400),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    color: Colors.black12,
                    height: 4,
                    width: double.infinity,
                  ),
                  MyWidgets.textView('Offer Available', Colors.black, 16,
                      fontWeight: FontWeight.w700),
                  SizedBox(height: 6),
                  MyWidgets.textView(
                      'Offer one\nOffer two\nOffer three\nOffer four',
                      Colors.black,
                      14,
                      fontWeight: FontWeight.w400),
                   */
        Container(
          margin: const EdgeInsets.only(top: 30, bottom: 20),
          color: Colors.black12,
          height: 4,
          width: double.infinity,
        ),
        //Product Specifiaction
        const SizedBox(height: 6),
        //Product Details
        MyWidgets.textView('Product Details', Colors.black, 16,
            fontWeight: FontWeight.w700),
        const SizedBox(height: 10),
        ExpandableText(
          '${productDetailsData.shortdesc}',
          expandText: 'show more',
          collapseText: 'show less',
          maxLines: 4,
          linkColor: Colors.blue,
        ),
        const SizedBox(height: 30),
        Container(
          margin: const EdgeInsets.only(top: 10, bottom: 15),
          color: Colors.black12,
          height: 4,
          width: double.infinity,
        ),
        /*
    var document = parse(
    '<body>Hello world! <a href="www.html5rocks.com">HTML5 rocks!');
    print(document.outerHtml);
     */

        ExpandablePanel(
          header: MyWidgets.textView('Product Description', Colors.black, 16,
              fontWeight: FontWeight.w700),
          collapsed: Text('About ${productDetailsData.productname}'),
          expanded: Align(
              alignment: Alignment.center,
              //child: Text(unescape.convert("&lt;strong&#62;This &quot;escaped&quot; string"))),
              //child: Text(document.outerHtml)),
              child: Text(unescape.convert(productDetailsData.fulldesc!))),
          // child: Text(unescape.convert(HtmlCharacterEntities.decode(productDetailsData.fulldesc!)))),
        ),

        const SizedBox(height: 15),
        //Similar products
        Container(
          margin: const EdgeInsets.only(top: 10, bottom: 15),
          color: Colors.black12,
          height: 4,
          width: double.infinity,
        ),
        const SizedBox(height: 10),
        MyWidgets.textView('Product Reviews', Colors.black, 16,
            fontWeight: FontWeight.w700),
        MyWidgets.textView(
            '${productReviewList.length} Reviews', Colors.black, 13,
            fontWeight: FontWeight.w400),
        const SizedBox(height: 22),
        getProductReview(productReviewList),
        productReviewList.length > 4
            ? getAllCommentBn(productReviewList)
            : Container(),
        const SizedBox(height: 15),
        Container(
          margin: const EdgeInsets.only(top: 10, bottom: 15),
          color: Colors.black12,
          height: 2,
          width: double.infinity,
        ),
        const SizedBox(height: 10),
        MyWidgets.textView('Product you may also like', Colors.black, 16,
            fontWeight: FontWeight.w700),
        const SizedBox(height: 22),
        getSimilarProducts(similarProduct),
        const SizedBox(height: 30)
      ],
    );
  }

  getSliderList(List<Prdimglist> productImgList) {
    List<String> imgList = [];

    for (int i = 0; i < productImgList.length; i++) {
      imgList.add(productImgList[i].imgurl!);
    }
    //print('imageList in slider...$imgList');

    // return imgList
    //     .map((item) => PhotoView(
    //           imageProvider: NetworkImage('$imageUrl$item'),
    //         ))
    //     .toList();

    return imgList
        .map((item) => FadeInImage(
            fit: BoxFit.contain,
            image: NetworkImage('$imageUrl$item'),
            placeholder: const AssetImage('assets/images/loading.gif'))).toList();


  }

  getSimilarProducts(List<Prddata> similarProduct) {
    return similarProduct.isEmpty
        ? const Center(
            child: Text('No Similar product available'),
          )
        : GridView.count(
            padding: const EdgeInsets.only(left: 5, right: 5),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: 8.0 / 13.0,
            children: List<Widget>.generate(similarProduct.length, (index) {
              return similarProduct[index].isActive == 'True'
                  ? getProductTile(similarProduct, index)
                  : Container();
            }));
  }

//String image, String name, String mrp, String price,
//           String discount, String mfgName
  getProductTile(List<Prddata> productList, int index) => InkWell(
        onTap: () {
          print('similar product clicked');
          ProductDetailsController.selectedProductId.value =
              productList[index].srno!;
          ProductDetailsController.selectedProductName.value =
              productList[index].productname!;
          productDetailsController.fetchProductDetails(
              ProductDetailsController.selectedProductId.value);
          // Get.back();
          // Get.to(ProductDetailsView(
          //     productList[index].srno, productList[index].productname,
          //     isWishlist: productList[index].iswishlisted));
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
                    Row(
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
                          top: 4, bottom: 4, left: 10, right: 6),
                      child: Text(
                        '\$ ${productList[index].newprice!}',
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: const TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 16),
                      ),
                    ),
                    const SizedBox(width: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                            padding: EdgeInsets.only(
                                top: 6, bottom: 8, left: 10, right: 8),
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
                                  top: 3, bottom: 3, left: 10, right: 10),
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

  getProductReview(List<Reviewlist> productReviewList) => ListView.builder(
      //padding: const EdgeInsets.only(left: 2, right: 6),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: productReviewList.length > 4 ? 4 : productReviewList.length,
      itemBuilder: (context, index) {
        return productReviewItem(productReviewList, index);
      });

  Widget productReviewItem(List<Reviewlist> productReviewList, int index) =>
      InkWell(
        onTap: () {
          // if (controller.notificationList[index].ntype == 'product') {
          //   Get.to(ProductDetailsView(controller.notificationList[index].catprdid!, controller.notificationList[index].catprdname!));
          // } else {
          //   Get.to(ProductView(controller.notificationList[index].catprdid!, controller.notificationList[index].catprdname!));
          // }
        },
        child: Card(
          elevation: 1,
          shadowColor: AppColors.themeColor,
          margin: const EdgeInsets.all(4),
          child: Container(
            padding: const EdgeInsets.all(8),
            //height: 140,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                          child: CachedNetworkImage(
                            width: 35,
                            height: 35,
                            fit: BoxFit.cover,
                            imageUrl:
                                '$imageUrl${productReviewList[index].userpic}',
                            placeholder: (context, url) => Image.asset(
                              'assets/images/loading.gif',
                              fit: BoxFit.fitWidth,
                            ),
                            errorWidget: (context, url, error) => Icon(
                              Icons.account_circle_rounded,
                              size: 48.0,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text('Nice Product'),
                      ],
                    ),
                    Row(
                      children: [
                        Card(
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
                                width: 56,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      size: 20,
                                      color: Colors.orange,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      double.parse(
                                              productReviewList[index].star!)
                                          .toStringAsFixed(1),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(productReviewList[index].review!,
                      style: const TextStyle(fontSize: 13)),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, bottom: 10.0),
                  child: Text('Given on - ${productReviewList[index].ondate!}',
                      style: const TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ),
        ),
      );

  getAllCommentBn(List<Reviewlist> productReviewList) {
    return Container(
      margin: const EdgeInsets.only(left: 80, right: 80),
      child: ElevatedButton(
          style: elevatedButtonStyleWhiteCurve,
          onPressed: () {
            Get.to(ViewAllReview(productReviewList,
                ProductDetailsController.selectedProductName.value));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                'View all comments',
                style: TextStyle(fontSize: 12, color: Colors.black45),
              ),
              Icon(Icons.arrow_forward, size: 14)
            ],
          )),
    );
  }
}
