import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:icommerce/styles/app_colors.dart';
import 'package:icommerce/styles/button_style.dart';
import 'package:icommerce/views/order_list.dart';
import 'package:icommerce/views/pages_view.dart';

class SuccessView extends StatelessWidget {
  const SuccessView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Stack(
          children: [
            Positioned(
                top: 80,
                left: 1,
                right: 1,
                child:
                    SvgPicture.asset('assets/images/success.svg', height: 200)),
            Positioned(
                top: 140,
                left: 72,
                right: 210,
                child: Image.asset(
                  'assets/images/sucgif.gif',
                  height: 60,
                )),
            // Image.asset('assets/images/sucgif.gif'),



            Positioned(
              top: 290,
              left: 1,
              right: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: 40),
                  Text('Congratulations',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.themeColor),
                  ),
                  const SizedBox(height:10),
                  Text('Your order placed successfully',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.themeColor),
                  ),
                  const SizedBox(height:10),
                  // const Text('Order Id : ndugArg4545E',
                  //   style: TextStyle(
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.w400,
                  //       color: Colors.black45),
                  // ),
                  Container(height: 100),
                  ElevatedButton(
                      style: curveButtonStyleThemeColorTow,
                      onPressed: (){
                        Get.off(OrderListView());
                      }, child: Text('View Order', style: TextStyle(color: AppColors.white, fontSize: 13),)),
                  Container(height: 15,),
                  ElevatedButton(
                      style: curveButtonStyleThemeColor,
                      onPressed: (){
                        Get.offAll(PagesView());
                      }, child: Text('Continue Shopping', style: TextStyle(color: AppColors.white, fontSize: 13),)),


                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}
