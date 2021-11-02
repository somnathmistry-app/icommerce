import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icommerce/controllers/cart_controller.dart';
import 'package:icommerce/views/cart_views.dart';

import '../app_colors.dart';

AppBar appBar(String name) => AppBar(
    title: Text(name,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16)));



AppBar appBarCart(String name) => AppBar(
  title: Text(name,
      style:
      const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16)),
  actions: [
    //Container(color:Colors.deepPurple,child: Text('data')),
    Obx(()=>Badge(
      badgeColor: Colors.deepOrange,
      position: BadgePosition.topEnd(top: 2, end: 4),
      badgeContent: Text(CartController.cartItem.value, style: const TextStyle(color: Colors.white, fontSize: 11),),
      child: IconButton(
        icon: Icon(Icons.shopping_cart, color: AppColors.white),
        onPressed: () {
          Get.to(() => CartView());
        },
      ),
    )),
    const SizedBox(width: 4,)
  ],
);

