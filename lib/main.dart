import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:icommerce/payment/stripe_details.dart';
import 'package:icommerce/views/splash_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("config");
  await GetStorage.init();
  Stripe.publishableKey = publishKey;
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  //var box = GetStorage();
  //const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // if(box.read('userId')==null || box.read('userId')==""){
    //   box.write('userId', '2');
    // }
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ndugagambia',
      theme: ThemeData(
        fontFamily: 'Mulish-Medium',
        primarySwatch: Colors.blue,
      ),
      home:  SplashView(),
    );
  }
}