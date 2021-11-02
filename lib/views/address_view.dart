import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icommerce/controllers/address_controller.dart';
import 'package:icommerce/styles/app_colors.dart';
import 'package:icommerce/styles/button_style.dart';
import 'package:icommerce/styles/commonmodule/app_bar.dart';
import 'package:icommerce/styles/commonmodule/my_widgets.dart';
import 'package:icommerce/views/payment_option_view.dart';

class AddressView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String? cartId;

  AddressController addressController = Get.put(AddressController());

  AddressView(this.cartId);

  int val = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addressController.nameTec.clear();
          addressController.streetTec.clear();
          addressController.mobileTecOne.clear();
          addressController.mobileTecTwo.clear();
          addressController.landMarkTec.clear();
          addressController.pinTec.clear();
          addressController.cityTec.clear();
          addressController.stateTec.clear();
          getBottomAddressFrom("Add New Address ", "new address");
        },
        backgroundColor: AppColors.themeColorTwo,
        child: const Icon(Icons.add),
      ),
      appBar: appBar('Select address'),
      body: SafeArea(
        child: LimitedBox(
            maxHeight: double.infinity,
            child: GetX<AddressController>(
              initState: (context) {
                addressController.fetchAddressList();
              },
              builder: (controller) {
                if (controller.isLoading.value) {
                  return Center(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                      SizedBox(height: 10),
                      Text(
                        'Available addresses..',
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),);
                } else {
                  return controller.addressList.isEmpty
                      ? const Center(
                          child: Text('No address available, Add now'),
                        )
                      : ListView(
                          children: [
                            const SizedBox(height: 20),
                            getOrderTrack(),
                            const SizedBox(height: 25),
                            Row(
                              children: [
                                const SizedBox(width: 10),
                                Image.asset(
                                  'assets/images/locationgif.gif',
                                  scale: 10,
                                ),
                                Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(50.0)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0,
                                        right: 12,
                                        top: 6,
                                        bottom: 6),
                                    child: controller.addressList.length > 1
                                        ? Text(
                                            '${controller.addressList.length} Addresses Available',
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.blue),
                                          )
                                        : Text(
                                            '${controller.addressList.length} Address Available',
                                            style:
                                                const TextStyle(fontSize: 13),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            getAddressList(controller)
                          ],
                        );
                }
              },
            )),
      ),
    );
  }

  getOrderTrack() {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(width: 1),
        MyWidgets.mySingleTrack('Cart  ', 'assets/images/check.svg',
            imgWidth: 18),
        Container(width: 45, height: 1, color: Colors.black),
        MyWidgets.mySingleTrack('Address  ', 'assets/images/check_green.svg',
            imgWidth: 18),
        Container(width: 45, height: 1, color: Colors.black),
        MyWidgets.mySingleTrack('Payment  ', 'assets/images/check.svg',
            imgWidth: 18),
        const SizedBox(width: 2)
      ],
    ));
  }

  addAddress(String addressHeading, String addressId) {
    print('address heading, $addressHeading');
    return

      ListView(
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 10),
              MyWidgets.textView(addressHeading, Colors.black, 16),
              const SizedBox(height: 12),
              Obx(() => Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          title: const Text("Home"),
                          value: 1,
                          activeColor: AppColors.themeColorTwo,
                          groupValue: addressController.addressTypeInt.value,
                          selected: addressController.addressTypeInt.value == 1,
                          toggleable: true,
                          onChanged: (value) {
                            addressController.addressType.value = 'Home';
                            addressController.addressTypeInt.value =
                                value.hashCode;
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          title: const Text("Work"),
                          value: 2,
                          activeColor: AppColors.themeColorTwo,
                          groupValue: addressController.addressTypeInt.value,
                          selected: addressController.addressTypeInt.value == 2,
                          toggleable: false,
                          onChanged: (value) {
                            addressController.addressType.value = 'Work';
                            addressController.addressTypeInt.value =
                                value.hashCode;
                          },
                        ),
                      ),
                    ],
                  )),
              Container(
                //addrs:address
                // addrtype:Home
                // email:email
                // IsActive:true
                // landmark:landmark
                // name:Sam3
                // phno1:9876543213
                // phno2:9876543201
                // pin:1234567
                // userid:9
                margin: const EdgeInsets.only(left: 15, right: 15),
                height: 40,
                // margin: EdgeInsets.only(left: 40.0, right: 40.0, top: 70.0),
                child: TextFormField(
                    textAlignVertical: TextAlignVertical.bottom,
                    style: const TextStyle(fontSize: 12),
                    controller: addressController.nameTec,
                    validator: (value) =>
                        value!.isEmpty ? "Please enter name" : null,
                    decoration: InputDecoration(
                      hintText: 'Enter name',
                      labelText: 'Name',
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
              //address TextField
              Container(
                height: 40,
                margin: const EdgeInsets.only(left: 15, right: 15),
                child: TextFormField(
                    textAlignVertical: TextAlignVertical.bottom,
                    style: const TextStyle(fontSize: 12),
                    controller: addressController.streetTec,
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter home/ street' : null,
                    decoration: InputDecoration(
                      hintText: 'Enter House/ Street Name',
                      labelText: 'House/ Street Name',
                      labelStyle: TextStyle(
                        fontSize: 13,
                        color: AppColors.themeColor,
                        fontWeight: FontWeight.w400,
                        // light
                        fontStyle: FontStyle.normal,
                      ),
                      border: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: AppColors.themeColor)),
                    )),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 15, right: 4),
                      width: 20,
                      height: 40,
                      // margin: EdgeInsets.only(left: 40.0, right: 40.0, top: 70.0),
                      child: TextFormField(
                          textAlignVertical: TextAlignVertical.bottom,
                          style: const TextStyle(fontSize: 12),
                          controller: addressController.mobileTecOne,
                          validator: (value) => value!.isEmpty
                              ? "Please enter mobile number"
                              : value.length < 10
                                  ? 'Please enter 10 digit number'
                                  : null,
                          decoration: InputDecoration(
                            hintText: 'Mobile Number',
                            labelText: 'Mobile Number',
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
                                borderSide:
                                    BorderSide(color: AppColors.themeColor)),
                          )),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 4, right: 15),
                      height: 40,
                      // margin: EdgeInsets.only(left: 40.0, right: 40.0, top: 70.0),
                      child: TextFormField(
                          textAlignVertical: TextAlignVertical.bottom,
                          style: const TextStyle(fontSize: 12),
                          controller: addressController.mobileTecTwo,
                          decoration: InputDecoration(
                            hintText: 'Alternative number',
                            labelText: 'Alternative number',
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
                                borderSide:
                                    BorderSide(color: AppColors.themeColor)),
                          )),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 15, right: 4),
                      width: 20,
                      height: 40,
                      // margin: EdgeInsets.only(left: 40.0, right: 40.0, top: 70.0),
                      child: TextFormField(
                          textAlignVertical: TextAlignVertical.bottom,
                          style: const TextStyle(fontSize: 12),
                          controller: addressController.landMarkTec,
                          validator: (value) =>
                              value!.isEmpty ? "Please enter landmark" : null,
                          decoration: InputDecoration(
                            hintText: 'Landmark',
                            labelText: 'Landmark',
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
                                borderSide:
                                    BorderSide(color: AppColors.themeColor)),
                          )),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 4, right: 15),
                      height: 40,
                      // margin: EdgeInsets.only(left: 40.0, right: 40.0, top: 70.0),
                      child: TextFormField(
                          textAlignVertical: TextAlignVertical.bottom,
                          style: const TextStyle(fontSize: 12),
                          controller: addressController.pinTec,
                          validator: (value) =>
                              value!.isEmpty ? "Please enter name" : null,
                          decoration: InputDecoration(
                            hintText: 'Pincode',
                            labelText: 'Pincode',
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
                                borderSide:
                                    BorderSide(color: AppColors.themeColor)),
                          )),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 15, right: 4),
                      width: 20,
                      height: 40,
                      // margin: EdgeInsets.only(left: 40.0, right: 40.0, top: 70.0),
                      child: TextFormField(
                          textAlignVertical: TextAlignVertical.bottom,
                          style: const TextStyle(fontSize: 12),
                          controller: addressController.cityTec,
                          validator: (value) =>
                              value!.isEmpty ? "Please enter city" : null,
                          decoration: InputDecoration(
                            hintText: 'City',
                            labelText: 'City',
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
                                borderSide:
                                    BorderSide(color: AppColors.themeColor)),
                          )),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 4, right: 15),
                      height: 40,
                      // margin: EdgeInsets.only(left: 40.0, right: 40.0, top: 70.0),
                      child: TextFormField(
                          textAlignVertical: TextAlignVertical.bottom,
                          style: const TextStyle(fontSize: 12),
                          controller: addressController.stateTec,
                          validator: (value) =>
                              value!.isEmpty ? "Please enter state" : null,
                          decoration: InputDecoration(
                            hintText: 'State',
                            labelText: 'State',
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
                                borderSide:
                                    BorderSide(color: AppColors.themeColor)),
                          )),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),
            ],
          ),
        ),
        //Login button
        Container(
            height: 40,
            width: double.infinity,
            margin: const EdgeInsets.only(left: 15, right: 15),
            // margin: EdgeInsets.only(left: 40.0, right: 40.0, top: 20.0),
            child: ElevatedButton(
                style: curveButtonStyleThemeColorTow,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (addressHeading == 'Edit') {
                      addressController.editAddress(addressId);
                    } else {
                      addressController.addAddress();
                    }
                  }
                },
                child: addressHeading == 'Edit'
                    ? const Text(
                        'UPDATE ADDRESS',
                        style: TextStyle(color: Colors.white),
                      )
                    : const Text(
                        'ADD ADDRESS',
                        style: TextStyle(color: Colors.white),
                      ))),
      ],
    );
  }

  getAddressList(AddressController controller) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.addressList.length,
        itemBuilder: (context, index) {
          //  "srno": "11",
          //             "userid": "9",
          //             "addrtype": "Home",
          //             "name": "Sam3",
          //             "email": "email",
          //             "phno1": "9876543213",
          //             "phno2": "9876543201",
          //             "addrs": "address",
          //             "landmark": "landmark",
          //             "pin": "1234567",
          //             "IsActive": null,
          //             "deliverytype": null
          //         },

          //String addressType, String name, String email, String phOne, String phTwo, String address, String land
          //return Text('sdfsf');
          return addressListItem(addressController, index);
        });
  }

  addressListItem(AddressController controller, int index) {
    return Container(
      margin: const EdgeInsets.only(left: 6, right: 6),
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

                  Expanded(
                    child: MyWidgets.textView(
                        controller.addressList[index].name!,
                        Colors.black,
                        16),
                  ),
                  const SizedBox(width: 15),

                  Card(
                    color: Colors.white70,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10, top: 4, bottom: 2),
                        child:  Text(
                          controller.addressList[index].addrtype!,
                          style: const TextStyle(fontSize: 11),
                        )),
                  )


                ],
              ),







              //name, email, addressType, address, landmark, phone, phtwo,
              MyWidgets.textView(
                  controller.addressList[index].email!, Colors.black, 12.5),
              const SizedBox(height: 8),
              MyWidgets.textView(
                  controller.addressList[index].addrs!, Colors.black, 13.5),

              MyWidgets.textView(
                  '${controller.addressList[index].city!}, ${controller.addressList[index].states!}',
                  Colors.black,
                  13),


              MyWidgets.textView('Pin: ${controller.addressList[index].pin!}',
                  Colors.black, 13),
              MyWidgets.textView(
                  'LandMark: ${controller.addressList[index].landmark!}',
                  Colors.black,
                  13),
              Row(
                children: [
                  MyWidgets.textView(
                      'Contacts: ${controller.addressList[index].phno1}',
                      Colors.black,
                      13),
                  MyWidgets.textView('  ${controller.addressList[index].phno2}',
                      Colors.black, 13),
                ],
              ),
              const SizedBox(height: 20),



              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  cartId == "profile"
                      ? Container()
                      : Expanded(
                        child: SizedBox(
                            height: 33,
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
                                  Get.to(PaymentOptionView(
                                      controller.addressList[index].name!,
                                      controller.addressList[index].email!,
                                      controller.addressList[index].addrtype!,
                                      controller.addressList[index].addrs!,
                                      controller.addressList[index].landmark!,
                                      controller.addressList[index].phno1!,
                                      controller.addressList[index].phno2!,
                                      cartId,
                                      controller.addressList[index].srno));
                                },
                                child: Text(
                                  'Deliver Here',
                                  style: TextStyle(
                                      color: AppColors.white, fontSize: 11),
                                )),
                          ),
                      ),
                  SizedBox(width: 4),
                  Expanded(child: SizedBox(
                    height: 33,

                    child: ElevatedButton(
                        style: elevatedButtonStyleWhiteCurve,
                        onPressed: () {
                          //Need to fix
                          addressController.nameTec.text =
                          controller.addressList[index].name!;
                          addressController.streetTec.text =
                          controller.addressList[index].addrs!;
                          addressController.mobileTecOne.text =
                          controller.addressList[index].phno1!;
                          addressController.mobileTecTwo.text =
                          controller.addressList[index].phno2!;
                          addressController.landMarkTec.text =
                          controller.addressList[index].landmark!;
                          addressController.pinTec.text =
                          controller.addressList[index].pin!;
                          addressController.cityTec.text =
                          controller.addressList[index].city!;
                          addressController.stateTec.text =
                          controller.addressList[index].states!;
                          getBottomAddressFrom("Edit",
                              controller.addressList[index].srno!);
                        },
                        child: Text(
                          'Edit',
                          style:
                          TextStyle(color: AppColors.black, fontSize: 11),
                        )),
                  )),
                  SizedBox(width: 4),
                  Expanded(child: SizedBox(
                    height: 33,
                    child: ElevatedButton(
                        style: elevatedCurveButtonStyleRed,
                        onPressed: () {
                          //Need to fix
                          addressController.deleteAddress(
                              '${controller.addressList[index].srno}');
                          controller.addressList.removeAt(index);
                        },
                        child: Text(
                          'Remove',
                          style:
                          TextStyle(color: AppColors.white, fontSize: 11),
                        )),
                  ))
                ],
              )


            ],
          ),
        ),
      ),
    );
  }




  void getBottomAddressFrom(String addressHeading, String addressId) {
    Get.bottomSheet(
        Container(
          width: double.infinity,
          height: double.maxFinite,
          child: addAddress(addressHeading, addressId),
        ),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ));
  }
}
