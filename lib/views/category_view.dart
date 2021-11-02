import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:icommerce/controllers/home_controller.dart';
import 'package:icommerce/controllers/login_controller.dart';
import 'package:icommerce/models/home_model.dart';
import 'package:icommerce/styles/app_colors.dart';
import 'package:icommerce/styles/commonmodule/app_bar.dart';
import 'package:icommerce/views/product_view.dart';

class CategoryView extends StatelessWidget {
  //const CategoryView({Key? key}) : super(key: key);
  LoginController loginController = Get.put(LoginController());
  HomeController homeController = Get.put(HomeController());
  GlobalConfiguration globalConfiguration = GlobalConfiguration();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCart('Categories'),
      body: getCatePage(),
    );
  }

  getCatePage() {
    return GetX<HomeController>(
      initState: (context) {
        homeController.getHomeData();
      },
      builder: (controller) {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return controller.sliderList.isEmpty
              ? Center(
            child: Text('No Products in ${controller.sliderList}'),
          )
              : ListView(
            children: [
              getCategoryList(controller.catlist),
              const SizedBox(height: 15),
            ],
          );
        }
      },
    );
  }

  getCategoryList(List<Catlist> catlist) => Container(
      margin: const EdgeInsets.only(left: 5, right: 5),
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: 1.0 / 1.2,
            //productList[index].node.variants.edges[0]
            //controller.productList.length
            children: List<Widget>.generate(catlist.length, (index) {
              return getCategoryItem(catlist, index);
            }),
          )
        ],
      ),
  );

  getCategoryItem(List<Catlist> catlist, int index) => InkWell(
        onTap: () {
          Get.to(() => ProductView(catlist[index].srno!, catlist[index].name!));
        },
        child: Container(
            margin: EdgeInsets.all(2),
            width: double.infinity,
            height: 170,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: 86,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              '${globalConfiguration.get('image_url')}${catlist[index].image!}')),
                      borderRadius: const BorderRadius.all(Radius.circular(14)),
                      color: Colors.grey[50],

                    ),
                  ),

                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 4, right: 4, top: 7, bottom: 7),
                  child: Text('${catlist[index].name}',
                      style:
                          const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white),
                      textAlign: TextAlign.center),
                )
              ],
            ),
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.themeColorTwo),
                color: AppColors.themeColorTwo,
                borderRadius: const BorderRadius.all(Radius.circular(15.0)))),
      );
}
