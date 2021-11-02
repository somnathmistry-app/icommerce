import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:icommerce/controllers/order_controller.dart';
import 'package:icommerce/controllers/productdetails_controller.dart';
import 'package:icommerce/styles/app_colors.dart';
import 'package:icommerce/styles/button_style.dart';
import 'package:icommerce/styles/commonmodule/app_bar.dart';
import 'package:icommerce/styles/commonmodule/my_widgets.dart';
import 'package:icommerce/views/contact_view.dart';
import 'package:icommerce/views/product_details_view.dart';

class OrderDetailsView extends StatelessWidget {
  OrderController? controller;
  int index;
  final _formKey = GlobalKey<FormState>();

  OrderDetailsView(this.controller, this.index);

  //const OrderDetailsView(OrderController controller, {Key? key}) : super(key: key);
  var imageUrl = GlobalConfiguration().get('image_url');
  OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Order Details'),
      body: ListView(
        children: [
          InkWell(
            onTap: () {
              ProductDetailsController.selectedProductId.value =
                  controller!.orderListProducts[index].productid!;
              ProductDetailsController.selectedProductName.value =
                  controller!.orderListProducts[index].productname!;
              Get.to(ProductDetailsView(
                  controller!.orderListProducts[index].productid));
            },
            child: orderDetails(controller, index),
          ),
          addressItem(controller, index),
          getAmountSummery(controller, index),
          controller!.orderListProducts[index].orderstatus == "Cancelled"
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('Order has been canceled'),
                    ElevatedButton(
                        onPressed: () {
                          ProductDetailsController.selectedProductId.value =
                              controller!.orderListProducts[index].productid!;
                          ProductDetailsController.selectedProductName.value = orderController.orderListProducts[index].productname!;
                          Get.to(ProductDetailsView(
                              orderController
                                  .orderListProducts[index].productid));
                        },
                        child: const Text('Buy Again'))
                  ],
                )
              : Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      controller!.orderListProducts[index].orderstatus ==
                              "Delivered"
                          ? InkWell(
                              onTap: () {
                                getCancelReturnDialog('return');
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(top: 14, bottom: 14),
                                child: Text('Return Order',
                                    style: TextStyle(
                                        color: Colors.redAccent,
                                        fontWeight: FontWeight.w600)),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                getCancelReturnDialog('cancel');
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(top: 14, bottom: 14),
                                child: Text('Cancel Order',
                                    style: TextStyle(
                                        color: Colors.redAccent,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ),
                      Container(
                        color: Colors.black38,
                        height: 30,
                        width: 1,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(ContactView());
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(top: 14, bottom: 14),
                          child: Text('Need Help?',
                              style: TextStyle(color: Colors.blue)),
                        ),
                      ),
                    ],
                  ),
                )
        ],
      ),
    );
  }

  orderDetails(OrderController? controller, int index) => Card(
        elevation: 1,
        shadowColor: AppColors.themeColor,
        margin: const EdgeInsets.all(5),
        child: Container(
          padding: const EdgeInsets.all(10),
          //height: 200,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //controller.orderListProducts[index].deliverystatus!
                      Text(
                          'Order Id: ${controller!.orderListProducts[index].orderid!}'),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 2, left: 6, right: 8),
                        child: Text(
                          '${controller.orderListProducts[index].productname}',
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 2, bottom: 10, left: 6, right: 8),
                        child: Text(
                          '${controller.orderListProducts[index].qty} ${controller.orderListProducts[index].unit}',
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    child: FadeInImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            '$imageUrl${controller.orderListProducts[index].prdimg}'),
                        placeholder:
                            const AssetImage('assets/images/loading.gif')),
                  ),
                  // const SizedBox(width: 5),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        '  Delivery status',
                        style: TextStyle(fontSize: 10),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 2, bottom: 4, left: 6, right: 8),
                        child: Row(
                          children: [
                            Image.asset('assets/images/order.png', scale: 28),
                            const SizedBox(width: 12),
                            const Text(
                              'Ordered',
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 13),
                            ),

                            // Image.asset('assets/images/tdg.gif', scale: 8,),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 2, bottom: 4, left: 6, right: 8),
                        child: Row(
                          children: [
                            Text(
                              controller.orderListProducts[index].orderdate!,
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 10),
                            ),

                            // Image.asset('assets/images/tdg.gif', scale: 8,),
                          ],
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(left: 20),
                          color: Colors.blue,
                          height: 30,
                          width: 2),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 6, bottom: 4, left: 2, right: 8),
                        child: Row(
                          children: [
                            Image.asset('assets/images/dv.gif', scale: 6),
                            const SizedBox(width: 2),
                            Text(
                              controller
                                  .orderListProducts[index].deliverystatus!,
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 13),
                            ),

                            // Image.asset('assets/images/tdg.gif', scale: 8,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              controller.orderListProducts[index].deliverystatus == "Pending"
                  ? Container()
                  : const Divider(color: Colors.black38),

              //Rating Row
              controller.orderListProducts[index].deliverystatus == "Pending"
                  ? Container()
                  : InkWell(
                      onTap: () {
                        getBottomReviewFrom();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 6, bottom: 6, left: 6, right: 8),
                            child: Row(
                              children: [
                                const Text(
                                  'Write a Review  ',
                                  textAlign: TextAlign.start,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13),
                                ),
                                Image.asset('assets/images/revbg.gif',
                                    scale: 14),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
              controller.orderListProducts[index].paystatus == "Paid"
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Text(
                          'Paid using ${controller.orderListProducts[index].paymethod}',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text('Transaction Id: ${controller.orderListProducts[index].txnid}',
                          style: const TextStyle(fontSize: 11))
                    ])
                  : Container()
            ],
          ),
        ),
      );

  addressItem(OrderController? controller, int index) {
    return Card(
      shadowColor: AppColors.themeColor,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Shipping Address',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
            ),
            Container(
              margin: const EdgeInsets.only(top: 6, bottom: 6),
              width: 115,
              height: 1,
              color: Colors.blue,
            ),
            Row(
              children: [
                Expanded(
                  child: MyWidgets.textView(
                      controller!.orderListProducts[index].name!,
                      Colors.black,
                      14),
                ),
                const SizedBox(width: 15),
                Card(
                  color: Colors.white70,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10, top: 4, bottom: 2),
                      child: Text(
                        controller.orderListProducts[index].addrtype!,
                        style: const TextStyle(fontSize: 11),
                      )),
                )
              ],
            ),

            //name, email, addressType, address, landmark, phone, phtwo,
            MyWidgets.textView(
                controller.orderListProducts[index].email!, Colors.black, 12),
            const SizedBox(height: 8),
            MyWidgets.textView(
                controller.orderListProducts[index].addrs!, Colors.black, 12),

            MyWidgets.textView(
                '${controller.orderListProducts[index].city!}, ${controller.orderListProducts[index].states!}',
                Colors.black,
                12),

            MyWidgets.textView(
                'Pin: ${controller.orderListProducts[index].pin!}',
                Colors.black,
                12),
            MyWidgets.textView(
                'LandMark: ${controller.orderListProducts[index].landmark!}',
                Colors.black,
                12),
            Row(
              children: [
                MyWidgets.textView(
                    'Contacts: ${controller.orderListProducts[index].phno1}',
                    Colors.black,
                    12),
                MyWidgets.textView(
                    '  ${controller.orderListProducts[index].phno2}',
                    Colors.black,
                    12),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  getAmountSummery(OrderController? controller, int index) => Card(
        margin: const EdgeInsets.only(top: 5, left: 5, right: 5),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ExpandablePanel(
            header: MyWidgets.textView(
                'Total Amount  -   \$ ${controller!.orderListProducts[index].totprice}',
                Colors.black,
                12,
                fontWeight: FontWeight.w700),
            collapsed:
                MyWidgets.textView('* including all taxes', Colors.black87, 12),
            expanded: Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                    child: Padding(
                        padding: const EdgeInsets.only(top: 6, bottom: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyWidgets.textView('Total MRP', Colors.black87, 12),
                            MyWidgets.textView(
                                '\$ ${controller.orderListProducts[index].totmrp}',
                                Colors.black87,
                                12,
                                fontWeight: FontWeight.bold)
                          ],
                        )),
                  ),
                  const Divider(thickness: 1),
                  Container(
                    child: Padding(
                        padding: const EdgeInsets.only(top: 6, bottom: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyWidgets.textView(
                                'Total Savings', Colors.black87, 12),
                            MyWidgets.textView(
                                '${controller.orderListProducts[index].totsavings}',
                                Colors.green,
                                12,
                                fontWeight: FontWeight.bold)
                          ],
                        )),
                  ),
                  const Divider(thickness: 1),
                  Container(
                    child: Padding(
                        padding: const EdgeInsets.only(top: 6, bottom: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyWidgets.textView(
                                'Shipping charge', Colors.black87, 12),
                            MyWidgets.textView('\$ FREE', Colors.black87, 12,
                                fontWeight: FontWeight.bold)
                          ],
                        )),
                  ),
                  const Divider(thickness: 1),
                  Container(
                    child: Padding(
                        padding: const EdgeInsets.only(top: 6, bottom: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyWidgets.textView('Total Amount', Colors.green, 12,
                                fontWeight: FontWeight.bold),
                            MyWidgets.textView(
                                '\$ ${controller.orderListProducts[index].totprice}',
                                Colors.green,
                                12,
                                fontWeight: FontWeight.bold)
                          ],
                        )),
                  ),
                ],
              ),
            ),
            // tapHeaderToExpand: true,
            // hasIcon: true,
          ),
        ),
      );

  void getBottomReviewFrom() {
    Get.bottomSheet(
        Container(
          width: double.infinity,
          height: 280,
          child: addReviewFields(),
        ),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ));
  }

  addReviewFields() {
    return Column(
      children: [
        const SizedBox(height: 20),
        MyWidgets.textView("Give Us Your Valuable Review", Colors.black, 12),
        const SizedBox(height: 30),
        RatingBar.builder(
          itemSize: 30,
          initialRating: 0,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 0),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            print('rating update, $rating');
            orderController.rating.value = rating;
          },
        ),
        const SizedBox(height: 25),
        Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                // margin: EdgeInsets.only(left: 40.0, right: 40.0, top: 70.0),
                child: TextFormField(
                    textAlignVertical: TextAlignVertical.bottom,
                    style: const TextStyle(fontSize: 12),
                    controller: orderController.commentTec,
                    validator: (value) =>
                        value!.isEmpty ? "Please write a comment" : null,
                    decoration: InputDecoration(
                      hintText: 'Enter comment',
                      labelText: 'Enter comment',
                      labelStyle: TextStyle(
                        fontSize: 13,
                        color: AppColors.themeColor,
                        fontWeight: FontWeight.w400,
                        // light
                        fontStyle: FontStyle.normal,
                      ),
                      // OutlineInputBorder(
                      //         borderRadius: const BorderRadius.all(
                      //           const Radius.circular(10.0),
                      //         ),
                      border: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: AppColors.themeColor)),
                    )),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        const SizedBox(height: 15),
        //Login button
        Container(
            height: 35,
            width: 180,
            //margin: const EdgeInsets.only(left: 100, right: 100),
            // margin: EdgeInsets.only(left: 40.0, right: 40.0, top: 20.0),
            child: ElevatedButton(
                style: curveButtonStyleThemeColorTow,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    orderController.addReviewOrder(
                        controller!.orderListProducts[index].productid);
                    // orderController.addListenerId(key, () {
                    //   orderController.addReviewOrder(controller!.orderListProducts[index].productid);
                    // });

                    // if (addressHeading == 'Edit Address') {
                    //   addressController.editAddress(addressId);
                    // } else {
                    //   addressController.addAddress();
                    // }
                  }
                },
                child: const Text(
                  'SUBMIT REVIEW',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ))),
      ],
    );
  }

  void getCancelReturnDialog(String cancelType) {
    Get.defaultDialog(
      title: "Are you sure to cancel?",
      titleStyle: const TextStyle(fontSize: 14),
      content: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                child: FadeInImage(
                    height: 75,
                    width: 75,
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        '$imageUrl${controller!.orderListProducts[index].prdimg}'),
                    placeholder: const AssetImage('assets/images/loading.gif')),
              ),
              Text(
                '\$ ${controller!.orderListProducts[index].totprice!}',
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '${controller!.orderListProducts[index].productname!} (${controller!.orderListProducts[index].qty!} ${controller!.orderListProducts[index].unit!})',
          ),
          const SizedBox(height: 15),
          const Divider(
            thickness: .9,
          )
        ],
      ),
      cancel: InkWell(
        onTap: () {
          if (cancelType == 'return') {
            print('returnorder bn clicked');
            orderController
                .returnOrder(controller!.orderListProducts[index].srno);
          } else {
            print('cancelorder bn clicked');
            orderController
                .cancelOrder(controller!.orderListProducts[index].srno);
          }
        },
        child: const Padding(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 14),
          child: Text('Yes         '),
        ),
      ),
      confirm: InkWell(
        onTap: () {
          print('Cancel bn clicked');
          Get.back();
        },
        child: const Padding(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 14),
          child: Text('         No'),
        ),
      ),
    );
  }
}
