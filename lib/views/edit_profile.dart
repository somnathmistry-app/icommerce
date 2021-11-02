// import 'dart:io';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:ndugagambia/controllers/profile_controller.dart';
// import 'package:ndugagambia/controllers/register_controller.dart';
// import 'package:ndugagambia/styles/app_colors.dart';
// import 'package:ndugagambia/styles/commonmodule/app_bar.dart';
// import 'package:permission_handler/permission_handler.dart';
//
//
// class EditProfile extends StatefulWidget {
//   const EditProfile({Key? key}) : super(key: key);
//
//   @override
//   _EditProfileState createState() => _EditProfileState();
// }
//
// class _EditProfileState extends State<EditProfile> {
//   final _formKey = GlobalKey<FormState>();
//   DateTime selectedDate = DateTime.now();
//   final RegisterController _registerController = Get.put(RegisterController());
//   ProfileController controller = ProfileController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appBar('Edit Profile'),
//       backgroundColor: AppColors.white,
//       body: ListView(
//         children: [
//           Column(
//             children: [
//               const SizedBox(height: 40),
//
//
//               Obx(() {
//                 return controller.selectedImagePath.value == ''
//                     ? ClipRRect(
//                   borderRadius: const BorderRadius.all(Radius.circular(50)),
//                   child: CachedNetworkImage(
//                     width: 80,
//                     height: 80,
//                     fit: BoxFit.cover,
//                     imageUrl: 'https://www.gstatic.com/webp/gallery3/2.png',
//                     placeholder: (context, url) => Image.asset(
//                       'assets/images/loading.gif',
//                       fit: BoxFit.fitWidth,
//                     ),
//                     errorWidget: (context, url, error) => Icon(
//                       Icons.account_circle_rounded,
//                       size: 48.0,
//                       color: Colors.grey.shade400,
//                     ),
//                   ),
//                 )
//                     : ClipRRect(
//                     borderRadius: const BorderRadius.all(Radius.circular(50)),
//                     child: Image.file(
//                       File(controller.selectedImagePath.value),
//                       fit: BoxFit.cover,
//                       width: 80,
//                       height: 80,
//                     ));
//               }),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const SizedBox(width: 60),
//                 InkWell(
//                     onTap: () {
//                       askForPermission();
//                       controller.getImage(ImageSource.gallery);
//                     },
//                     child:
//                     const Icon(Icons.image_outlined, color: Colors.blue,)
//                     // SvgPicture.asset(
//                     //   'assets/images/change.svg',
//                     //   width: 25,
//                     //   height: 25,
//                     // )
//
//                 )
//               ],
//             ),
//           ),
//
//
//           const Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Text(
//               'Choose profile image by clicking icon',
//               textAlign: TextAlign.center,
//               style: TextStyle(color: Colors.black26, fontSize: 10),
//             ),
//           ),
//
//           Container(
//             margin: const EdgeInsets.only(left: 24, right: 24),
//             child: Card(
//               elevation: 10,
//               shadowColor: AppColors.white,
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                     top: 50, bottom: 50, left: 28, right: 28),
//                 child: Column(
//                   children: [
//                     Form(
//                       key: _formKey,
//                       child: Column(
//                         children: [
//                           Container(
//                             height: 50,
//                             // margin: EdgeInsets.only(left: 40.0, right: 40.0, top: 70.0),
//                             child: TextFormField(
//                                 controller:
//                                 _registerController.firstNameController,
//                                 validator: (value) => value!.isEmpty
//                                     ? "Please enter name"
//                                     : null,
//                                 decoration: InputDecoration(
//                                   hintText: 'Enter name',
//                                   labelText: 'Name',
//                                   labelStyle: TextStyle(
//                                     fontSize: 15,
//                                     color: AppColors.themeColor,
//                                     fontWeight: FontWeight.w600,
//                                     // light
//                                     fontStyle: FontStyle.normal,
//                                   ),
//                                   border: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                           color: AppColors.themeColor)),
//                                 )),
//                           ),
//
//                           const SizedBox(height: 15),
//                           //Password TextField
//                           Container(
//                             height: 50,
//                             //  margin: EdgeInsets.only(left: 40.0, right: 40.0, top: 20.0),
//                             child: TextFormField(
//                                 controller:
//                                 _registerController.mobileController,
//                                 validator: (value) => value!.isEmpty
//                                     ? 'Please enter mobile number'
//                                     : value.length < 10
//                                     ? 'Please enter 10 digit number'
//                                     : null,
//                                 decoration: InputDecoration(
//                                   hintText: 'Enter mobile',
//                                   labelText: 'Mobile',
//                                   labelStyle: TextStyle(
//                                     fontSize: 15,
//                                     color: AppColors.themeColor,
//                                     fontWeight: FontWeight.w600,
//                                     // light
//                                     fontStyle: FontStyle.normal,
//                                   ),
//                                   border: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                           color: AppColors.themeColor)),
//                                 )),
//                           ),
//
//                           const SizedBox(height: 15),
//                           Container(
//                             height: 50,
//                             // margin: EdgeInsets.only(left: 40.0, right: 40.0, top: 70.0),
//                             child: TextFormField(
//                                 controller:
//                                 _registerController.emailController,
//                                 validator: (value) => value!.isEmpty
//                                     ? "Please enter email"
//                                     : !value.contains('@')
//                                     ? "Invalid Email Id"
//                                     : null,
//                                 decoration: InputDecoration(
//                                   hintText: 'Enter email',
//                                   labelText: 'Email',
//                                   labelStyle: TextStyle(
//                                     fontSize: 15,
//                                     color: AppColors.themeColor,
//                                     fontWeight: FontWeight.w600,
//                                     // light
//                                     fontStyle: FontStyle.normal,
//                                   ),
//                                   border: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                           color: AppColors.themeColor)),
//                                 )),
//                           ),
//
//                           InkWell(
//                             onTap: () {
//                               _selectDate(context);
//                             },
//                             child: Container(
//                               height: 50,
//                               width: double.maxFinite,
//                               margin: const EdgeInsets.only(
//                                   left: 0.0, right: 0.0, top: 15.0),
//                               child: TextFormField(
//                                 // validator: (input) => input.length < 1
//                                 //     ? "should_be_not_empty"
//                                 //     : null,
//                                   style: TextStyle(
//                                       fontSize: 14.0,
//                                       color: AppColors.themeColor),
//                                   textAlign: TextAlign.start,
//                                   enabled: false,
//                                   keyboardType: TextInputType.datetime,
//                                   // controller: editProfileController.dobController,
//                                   decoration: InputDecoration(
//                                     labelText: _registerController
//                                         .dobController.text.isEmpty
//                                         ? 'Select DOB'
//                                         : _registerController
//                                         .dobController.text,
//                                     labelStyle: TextStyle(
//                                       fontSize: 15,
//                                       color: AppColors.themeColor,
//                                       fontWeight: FontWeight.w600,
//                                       // light
//                                       fontStyle: FontStyle.normal,
//                                     ),
//                                     border: OutlineInputBorder(
//                                         borderSide: BorderSide(
//                                             color: AppColors.themeColor)),
//                                   )),
//                             ),
//                           ),
//
//                           const SizedBox(height: 15),
//                           //Password TextField
//                           Container(
//                             height: 50,
//                             //  margin: EdgeInsets.only(left: 40.0, right: 40.0, top: 20.0),
//                             child: TextFormField(
//                                 controller: _registerController
//                                     .passwordController,
//                                 validator: (value) => value!.isEmpty
//                                     ? 'Please enter password'
//                                     : value.length < 4
//                                     ? 'Please enter min 4 digit password'
//                                     : null,
//                                 obscureText: true,
//                                 decoration: InputDecoration(
//                                   hintText: 'Enter password',
//                                   labelText: 'Password',
//                                   labelStyle: TextStyle(
//                                     fontSize: 15,
//                                     color: AppColors.themeColor,
//                                     fontWeight: FontWeight.w600,
//                                     // light
//                                     fontStyle: FontStyle.normal,
//                                   ),
//                                   border: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                           color: AppColors.themeColor)),
//                                 )),
//                           ),
//
//                           const SizedBox(height: 25),
//                         ],
//                       ),
//                     ),
//                     //Login button
//                     Container(
//                       height: 45,
//                       width: double.infinity,
//                       // margin: EdgeInsets.only(left: 40.0, right: 40.0, top: 20.0),
//                       child: RaisedButton(
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(6)),
//                           color: AppColors.themeColor,
//                           child: Text(
//                             'UPDATE',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w900,
//                                 color: AppColors.white),
//                           ),
//                           onPressed: () {
//                             // Get.to(PageView());
//                             if (_formKey.currentState!.validate()) {
//                               _registerController.getRegister();
//                             }
//
//                             // Get.offAll(HomePage());
//
//                             // print('Email: '+.text+" "+'Password: '+_passwordTextController.text);
//                           }),
//                     ),
//                     const SizedBox(height: 30),
//                   ],
//                 ),
//               ),
//             ),
//           )
//
//           //Email TextField
//         ],
//       )
//     );
//   }
//
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//         context: context,
//         initialDate: selectedDate.subtract(const Duration(days: 15 * 365)),
//         initialDatePickerMode: DatePickerMode.day,
//         firstDate: DateTime(1940, 1, 13),
//         lastDate: selectedDate.subtract(const Duration(days: 15 * 365)));
//     if (picked != null) {
//       setState(() {
//         selectedDate = picked;
//         // _registerController.dobController.text =
//         // '${selectedDate.year.toString()}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}';
//       });
//     }
//   }
//
//
//   askForPermission()async{
//     if(Platform.isIOS){
//       var status = await Permission.camera.status;
//       if (status.isDenied) {
//         // We didn't ask for permission yet or the permission has been denied before but not permanently.
//       }
//
// // You can can also directly ask the permission about its status.
//       if (await Permission.location.isRestricted) {
//         // The OS restricts access, for example because of parental controls.
//       }
//     }
//
//     //return status;
//   }
// }
