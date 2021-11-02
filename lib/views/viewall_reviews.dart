import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:icommerce/models/product_details.dart';
import 'package:icommerce/styles/app_colors.dart';
import 'package:icommerce/styles/commonmodule/app_bar.dart';

class ViewAllReview extends StatelessWidget {
  List<Reviewlist> productReviewList;
  String? productName;

  ViewAllReview(this.productReviewList, this.productName);
  var imageUrl = GlobalConfiguration().get('image_url');

  @override
  Widget build(BuildContext context) {
    return
        Scaffold(
          appBar: appBar('$productName Review'),
          body:  ListView.builder(
            //padding: const EdgeInsets.only(left: 2, right: 6),
              //physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: productReviewList.length,
              itemBuilder: (context, index) {
                return productReviewItem(productReviewList, index);
              }),
        );
  }
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
                                      double.parse(productReviewList[index].star!).toStringAsFixed(1),
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
                  child: Text(productReviewList[index].review!, style: const TextStyle(fontSize: 13)),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                  child: Text('Given on - ${productReviewList[index].ondate!}', style: const TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ),
        ),
      );
}
