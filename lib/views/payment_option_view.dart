import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icommerce/controllers/cart_controller.dart';
import 'package:icommerce/controllers/order_controller.dart';
import 'package:icommerce/payment/stripe_key.dart';
import 'package:icommerce/styles/app_colors.dart';
import 'package:icommerce/styles/button_style.dart';
import 'package:icommerce/styles/commonmodule/my_widgets.dart';

class PaymentOptionView extends StatelessWidget {
  //Order data
  //address data
  String? name,
      email,
      addressType,
      address,
      landmark,
      phone,
      phtwo,
      cartId,
      delivaryAddressId;

  //other data
  //String? totalAmount, totalSaving, discount, shippingCharge;

  PaymentOptionView(
      this.name,
      this.email,
      this.addressType,
      this.address,
      this.landmark,
      this.phone,
      this.phtwo,
      this.cartId,
      this.delivaryAddressId);

  //OrderController orderController = Get.put(OrderController());
  CartController cartController = Get.put(CartController());
  OrderController orderController = Get.put(OrderController());
  StripePay stripePay = StripePay();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: SafeArea(
        child: LimitedBox(
          maxHeight: double.infinity,
          child: ListView(
            children: [
              const SizedBox(height: 20),
              getOrderTrack(),
              const SizedBox(height: 25),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child:
                        MyWidgets.textView('Payment method', Colors.black, 14),
                  )),
              const SizedBox(height: 10),
              addressListItem(),
              const SizedBox(height: 10),
              getAmountSummery(),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: MyWidgets.textView(
                    'Choose payment method', Colors.black, 14),
              ),
              getPaymentMethods()
            ],
          ),
        ),
      ),
    );
  }

  getOrderTrack() => Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(width: 1),
          MyWidgets.mySingleTrack('Cart  ', 'assets/images/check.svg',
              imgWidth: 18),
          Container(width: 45, height: 1, color: Colors.black),
          MyWidgets.mySingleTrack('Address  ', 'assets/images/check.svg',
              imgWidth: 18),
          Container(width: 45, height: 1, color: Colors.black),
          MyWidgets.mySingleTrack('Payment  ', 'assets/images/check_green.svg',
              imgWidth: 18),
          const SizedBox(width: 2)
        ],
      ));

  getAmountSummery() => Card(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ExpandablePanel(
            header: MyWidgets.textView(
                'Total Payable Amount  -   \$ ${cartController.totalPrice}',
                Colors.black,
                14,
                fontWeight: FontWeight.w700),
            collapsed:
                MyWidgets.textView('* including all taxes', Colors.black87, 14),
            expanded: Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                    child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyWidgets.textView('Total MRP', Colors.black87, 14),
                            MyWidgets.textView('\$ ${cartController.totalMrp}',
                                Colors.black87, 14,
                                fontWeight: FontWeight.bold)
                          ],
                        )),
                  ),
                  const Divider(thickness: 1),
                  Container(
                    child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyWidgets.textView(
                                'Total Savings', Colors.black87, 14),
                            MyWidgets.textView('${cartController.totalSaving}',
                                Colors.green, 14,
                                fontWeight: FontWeight.bold)
                          ],
                        )),
                  ),
                  const Divider(thickness: 1),
                  Container(
                    child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyWidgets.textView(
                                'Shipping charge', Colors.black87, 14),
                            MyWidgets.textView('\$ FREE', Colors.black87, 14,
                                fontWeight: FontWeight.bold)
                          ],
                        )),
                  ),
                  const Divider(thickness: 1),
                  Container(
                    child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyWidgets.textView(
                                'Total Payable Amount', Colors.green, 14,
                                fontWeight: FontWeight.bold),
                            MyWidgets.textView(
                                '\$ ${cartController.totalPrice.value}',
                                Colors.green,
                                14,
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

  getPaymentMethods() => Column(
        children: [
          InkWell(
            onTap: () {
              getConfirmOrder();
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: AppColors.themeColorTwo,
                      width: 1,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(4)),
              elevation: 1.5,
              margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Container(
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.monetization_on_sharp, color: Colors.green),
                      SizedBox(width: 10),
                      Text('Cash on Delivery')
                    ],
                  )),
            ),
          ),

          ///Stripe Payment
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: ElevatedButton(
                style: elevatedButtonStyleStripe,
                onPressed: () async {
                  // //cartid, deliveraddressid, txnid
                  await stripePay.makePayment(cartController.totalPrice.value.toString(), cartId!, delivaryAddressId!);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.payment, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'Pay using Stripe',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.security,
                color: Colors.green,
              ),
              MyWidgets.textView(
                  'The Payment will be completely safe and secure',
                  Colors.black87,
                  12),
            ],
          ),
          const SizedBox(height: 20),
        ],
      );

  confirmOrderDialog(String payAmount, String mrp, String discount,
      String codCharge, String shipingCharge, String savings) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
      child: Column(
        children: [
          const SizedBox(height: 4),
          MyWidgets.textView('Note: You need to pay \$ 20 for cash on delivery',
              Colors.black54, 12),
          const SizedBox(height: 15),
          Container(
            child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyWidgets.textView('Total MRP', Colors.black87, 14),
                    MyWidgets.textView('\$ $mrp', Colors.black87, 14,
                        fontWeight: FontWeight.bold)
                  ],
                )),
          ),
          const Divider(thickness: 1),
          Container(
            child: Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyWidgets.textView('Discount', Colors.black87, 14),
                    MyWidgets.textView(discount, Colors.green, 14,
                        fontWeight: FontWeight.bold)
                  ],
                )),
          ),
          const Divider(thickness: 1),
          Container(
            child: Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyWidgets.textView('COD charge', Colors.black87, 14),
                    MyWidgets.textView(codCharge, Colors.black87, 14,
                        fontWeight: FontWeight.bold)
                  ],
                )),
          ),
          const Divider(thickness: 1),
          Container(
            child: Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyWidgets.textView('Shipping charge', Colors.black87, 14),
                    MyWidgets.textView(shipingCharge, Colors.black87, 14,
                        fontWeight: FontWeight.bold)
                  ],
                )),
          ),
          const Divider(thickness: 1),
          Container(
            child: Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyWidgets.textView('Total Savings', Colors.green, 14,
                        fontWeight: FontWeight.bold),
                    MyWidgets.textView(savings, Colors.green, 14,
                        fontWeight: FontWeight.bold)
                  ],
                )),
          ),
          const Divider(thickness: 1),
          Container(
            child: Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyWidgets.textView('Total Payable amount', Colors.black, 16,
                        fontWeight: FontWeight.bold),
                    MyWidgets.textView('\$ $payAmount', Colors.black, 16,
                        fontWeight: FontWeight.bold)
                  ],
                )),
          ),
          const SizedBox(height: 20),
          Container(
              height: 42,
              width: double.infinity,
              child: ElevatedButton(
                  style: elevatedButtonStyleThemeColorTow,
                  onPressed: () {
                    Get.back();
                    orderController.codCartorder(cartId!, delivaryAddressId!);
                    // Get.to(const SuccessView());
                  },
                  child: Text(
                    'Confirm Order',
                    style: TextStyle(color: AppColors.white),
                  ))),
        ],
      ),
    );
  }

  getConfirmOrder() {
    Get.bottomSheet(
        Container(
          width: double.infinity,
          height: double.maxFinite,
          //String payAmount, String mrp, String discount, String codCharge, String shipingCharge, String savings
          child: confirmOrderDialog(
              cartController.totalPrice.value.toString(),
              cartController.totalMrp.value.toString(),
              "0",
              "0.0",
              "Free",
              cartController.totalSaving.value.toString()),
        ),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ));
  }

  addressListItem() {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8),
      width: double.infinity,
      child: Card(
        shadowColor: AppColors.themeColor,
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: MyWidgets.textView(name!, Colors.black, 16)),
                  const SizedBox(width: 15),
                  Card(
                    color: Colors.white70,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 4, bottom: 4),
                      child: Text(
                        addressType!,
                        style: const TextStyle(fontSize: 11),
                      ),
                    ),
                  )
                ],
              ),
              //name, email, addressType, address, landmark, phone, phtwo,
              MyWidgets.textView(email!, Colors.black, 12.5),
              const SizedBox(height: 8),
              MyWidgets.textView(address!, Colors.black, 13.5),
              MyWidgets.textView('LandMark: $landmark', Colors.black, 13),
              Row(
                children: [
                  MyWidgets.textView('Contacts: $phone, ', Colors.black, 13),
                  MyWidgets.textView('$phtwo', Colors.black, 13),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 33,
                    width: 105,
                    child: ElevatedButton(
                        style: curveButtonStyleThemeColorTow,
                        onPressed: () {
                          //name, email, addressType, address, landmark, phone, phtwo,
                          //this.name,
                          //       this.email,
                          //       this.addressType,
                          //       this.address,
                          //       this.landmark,
                          //       this.phone,
                          //       this.phtwo,
                          //       this.totalAmount,
                          //       this.totalSaving,
                          //       this.discount,
                          //       this.shippingCharge
                          Get.back();
                        },
                        child: Text(
                          'Change',
                          style:
                              TextStyle(color: AppColors.white, fontSize: 11),
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
