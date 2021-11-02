import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:image_picker/image_picker.dart';
import 'package:icommerce/controllers/conditions_controller.dart';
import 'package:icommerce/controllers/login_controller.dart';
import 'package:icommerce/controllers/profile_controller.dart';
import 'package:icommerce/styles/app_colors.dart';
import 'package:icommerce/styles/button_style.dart';
import 'package:icommerce/styles/commonmodule/my_snack_bar.dart';
import 'package:icommerce/views/address_view.dart';
import 'package:icommerce/views/contact_view.dart';
import 'package:icommerce/views/faq_view.dart';
import 'package:icommerce/views/order_list.dart';
import 'package:icommerce/views/pages_view.dart';
import 'package:icommerce/views/privacy_policy.dart';
import 'login_view.dart';

class ProfileView extends StatefulWidget {
  //const AccountView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _formKey = GlobalKey<FormState>();
  ProfileController controller = ProfileController();
  var box = GetStorage();
  var loginStatus;

  LoginController loginController = Get.put(LoginController());
  ProfileController profileController = Get.put(ProfileController());
  DateTime selectedDate = DateTime.now();
  ConditionController conditionController = Get.put(ConditionController());
  GlobalConfiguration globalConfiguration = GlobalConfiguration();

  @override
  void initState() {
    setState(() {
      print('isLogin accview.... ${loginController.isLogin}');
      loginStatus = loginController.name.value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          child: loginController.isLogin.value || box.hasData('userId')
              ? Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/pbg.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 42),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50)),
                                    child: CachedNetworkImage(
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                      imageUrl:
                                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyfV4V3Gws5xaeB9rRpB6MUR4ZqKLMtUNV0MIZs5K1vfuZvrl2_kTpZdE3UXgLfnYbx6o&usqp=CAU',
                                      placeholder: (context, url) =>
                                          Image.asset(
                                        'assets/images/loading.gif',
                                        fit: BoxFit.fitWidth,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(
                                        Icons.account_circle_rounded,
                                        size: 48.0,
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      (box.read('name') == null
                                          ? const Text(
                                              'Guest',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12),
                                            )
                                          : Text(
                                              '${box.read('name')}',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 13),
                                            )),
                                      box.read('email') == null
                                          ? const Text(
                                              'Email : Not available',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12),
                                            )
                                          : Text(
                                              '${box.read('email')}',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13),
                                            ),
                                      box.read('mobile') == null
                                          ? const Text(
                                              'Mobile : Not available',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14),
                                            )
                                          : Text(
                                              '${box.read('mobile')}',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12),
                                            ),
                                    ],
                                  ),
                                ],
                              ),

                              ///update profile
                              InkWell(
                                onTap: () {
                                  //profileController.fnameTec.value == box.read(key)
                                  profileController.fnameTec.text =
                                      box.read('name');
                                  //lastName
                                  profileController.lnameTec.text =
                                      box.read('lastName');
                                  profileController.phoneTec.text =
                                      box.read('mobile');
                                  // profileController.selectedDate.value =
                                  //     box.read('dob');
                                  getBottomAddressFrom();
                                  //Get.to(const EditProfile());
                                },
                                child: Card(
                                    margin: const EdgeInsets.only(right: 20),
                                    color: Colors.white38,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(7.0),
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 5),
                            child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.to(AddressView("profile"));
                                          },
                                          child: getProfileItems(
                                              Icons.location_on_outlined,
                                              "   Shipping Address"),
                                        ),
                                        const Divider(
                                          height: 4,
                                        ),
                                        InkWell(
                                            onTap: () {
                                              Get.to(OrderListView());
                                            },
                                            child: getProfileItems(
                                                Icons.bookmark_border,
                                                "   Order History")),
                                        const Divider(
                                          height: 4,
                                        ),
                                        // Get.to(OrderListView());
                                        InkWell(
                                          onTap: () {
                                            Get.to(OrderListView());
                                          },
                                          child: getProfileItems(Icons.update,
                                              "   Delivary Status"),
                                        ),
                                        const Divider(
                                          height: 4,
                                        ),
                                        // getProfileItems(
                                        //     Icons.notifications_none,
                                        //     "   Notification Setting"),
                                        // const Divider(
                                        //   height: 4,
                                        // ),
                                        InkWell(
                                          onTap: () {
                                            Get.to(PrivacyPolicy());
                                          },
                                          child: getProfileItems(
                                              Icons.privacy_tip_outlined,
                                              "   Privacy Policy"),
                                        ),
                                        const Divider(
                                          height: 4,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.to(FaqView());
                                          },
                                          child: getProfileItems(
                                              Icons.question_answer_outlined,
                                              "   FAQs"),
                                        ),
                                        const Divider(
                                          height: 4,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.to(LoginView());
                                          },
                                          child: getProfileItems(
                                              Icons.person_add_outlined,
                                              "   Use Another account"),
                                        ),
                                        const Divider(
                                          height: 4,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.to(ContactView());
                                          },
                                          child: getProfileItems(
                                              Icons.help_outline, "   Help"),
                                        ),
                                        const Divider(
                                          height: 4,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            conditionController.launchURL(
                                                globalConfiguration
                                                    .get('app_playstore_link'));
                                          },
                                          child: getProfileItems(
                                              //https://play.google.com/store/apps/details?id=com.bigbasket.mobileapp
                                              Icons.star_rate_outlined,
                                              "   Rate Our App"),
                                        ),

                                        const SizedBox(height: 20),
                                        SizedBox(
                                          width: 100,
                                          height: 32,
                                          child: ElevatedButton(
                                              style:
                                                  elevatedCurveButtonStyleRed,
                                              onPressed: () {
                                                print(
                                                    'isLogin accview.... ${loginController.isLogin}');
                                                Get.offAll(PagesView());
                                                box.erase();
                                                loginController.isLogin(false);
                                                MySnackbar.infoSnackBar(
                                                    'Logged Out',
                                                    'you are logged out successfully');
                                              },
                                              child: const Text(
                                                'Log out',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.white),
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ))
              : Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('You are not logged in'),
                    const SizedBox(height: 15),
                    const Text('Please login or create your account'),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 45,
                      width: 150,
                      // margin: EdgeInsets.only(left: 40.0, right: 40.0, top: 20.0),
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          color: AppColors.themeColor,
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: AppColors.white),
                          ),
                          onPressed: () {
                            Get.to(LoginView());
                          }),
                    ),
                  ],
                )),
        ));
  }

  getProfileItems(IconData icons, String name) => Padding(
        padding: const EdgeInsets.all(9.0),
        child: Row(
          children: [
            Icon(
              icons,
              color: Colors.green,
              size: 20,
            ),
            Text(
              name,
              style: const TextStyle(fontSize: 13),
            )
          ],
        ),
      );

  void getBottomAddressFrom() {
    Get.bottomSheet(
        Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          width: double.infinity,
          height: double.maxFinite,
          child: editProfile(),
        ),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ));
  }

//controller.getImage(ImageSource.gallery);
  editProfile() {
    return ListView(
      children: [
        Column(
          children: [
            const SizedBox(height: 15),
            const Text("Edit Profile"),
            Container(height: 5, width: 100),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                controller.getImage(ImageSource.gallery);
              },
              child: Obx(() {
                return controller.selectedImagePath.value == ''
                    ?
                ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                        child: CachedNetworkImage(
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          imageUrl:
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyfV4V3Gws5xaeB9rRpB6MUR4ZqKLMtUNV0MIZs5K1vfuZvrl2_kTpZdE3UXgLfnYbx6o&usqp=CAU',
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
                      )
                    : ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                        child: Image.file(
                          File(controller.selectedImagePath.value),
                          fit: BoxFit.cover,
                          width: 60,
                          height: 60,
                        ));
              }),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  //profile
                  // fname
                  // lname
                  // email (read only)
                  // phon
                  // dob

                  const SizedBox(height: 12),
                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    height: 40,
                    // margin: EdgeInsets.only(left: 40.0, right: 40.0, top: 70.0),
                    child: TextFormField(
                        textAlignVertical: TextAlignVertical.bottom,
                        style: const TextStyle(fontSize: 12),
                        controller: profileController.fnameTec,
                        validator: (value) =>
                            value!.isEmpty ? "Enter first name" : null,
                        decoration: const InputDecoration(
                          hintText: 'Enter first name',
                          labelText: 'First Name',
                          labelStyle: TextStyle(
                            fontSize: 13,
                            color: Colors.black45,
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
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(color: Colors.black26)),
                        )),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    height: 40,
                    // margin: EdgeInsets.only(left: 40.0, right: 40.0, top: 70.0),
                    child: TextFormField(
                        textAlignVertical: TextAlignVertical.bottom,
                        style: const TextStyle(fontSize: 12),
                        controller: profileController.lnameTec,
                        validator: (value) =>
                            value!.isEmpty ? "Enter last name" : null,
                        decoration: const InputDecoration(
                          hintText: 'Enter last name',
                          labelText: 'Last Name',
                          labelStyle: TextStyle(
                            fontSize: 13,
                            color: Colors.black45,
                            fontWeight: FontWeight.w400,
                            // light
                            fontStyle: FontStyle.normal,
                          ),
                          // OutlineInputBorder(
                          //         borderRadius: const BorderRadius.all(
                          //           const Radius.circular(10.0),
                          //
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(color: Colors.black26)),
                        )),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    height: 40,
                    // margin: EdgeInsets.only(left: 40.0, right: 40.0, top: 70.0),
                    child: TextFormField(
                        textAlignVertical: TextAlignVertical.bottom,
                        style: const TextStyle(fontSize: 12),
                        controller: profileController.phoneTec,
                        validator: (value) =>
                            value!.isEmpty ? "Enter phone number" : null,
                        decoration: const InputDecoration(
                          hintText: 'Enter phone number',
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(
                            fontSize: 13,
                            color: Colors.black45,
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
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(color: Colors.black26)),
                        )),
                  ),
                  const SizedBox(height: 10),

                  InkWell(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Obx(() => Container(
                            padding: const EdgeInsets.only(left: 15),
                            alignment: Alignment.centerLeft,
                            height: 40,
                            width: double.maxFinite,
                            margin: const EdgeInsets.only(left: 15, right: 15),
                            child: Text(
                              profileController.selectedDate.value.toString(),
                              style: const TextStyle(color: Colors.black),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black45,
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20))),
                          ))),

                  const SizedBox(height: 15),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                style: curveButtonStyleThemeColorTow,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    profileController.updateUser();
                  }
                },
                child: const Text(
                  'Update',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ))
          ],
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1920, 1),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        profileController.selectedDate.value =
            '${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}-${selectedDate.year.toString()}';
      });
    }
  }
}
