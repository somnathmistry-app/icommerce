import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:icommerce/controllers/home_controller.dart';
import 'package:icommerce/controllers/login_controller.dart';
import 'package:icommerce/models/home_model.dart';
import 'package:icommerce/views/category_view.dart';
import 'package:icommerce/views/product_view.dart';
import 'package:icommerce/search/searchview.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  LoginController loginController = Get.put(LoginController());
  HomeController homeController = Get.put(HomeController());
  var box = GetStorage();
  var imageUrl = GlobalConfiguration().get('image_url');

  @override
  Widget build(BuildContext context) {
    //print('isLogin home.... ${loginController.isLogin}');
    return Scaffold(backgroundColor: Colors.white, body: getHomePage());
  }

  getHomePage() {
    return LimitedBox(
      maxHeight: double.infinity,
      child: GetX<HomeController>(
        initState: (context) {
          homeController.getHomeData();
          print('userId is : ${box.read('userId').toString()}');
        },
        builder: (controller) {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return controller.sliderList.isEmpty
                ? Center(
                    child: Text('No Products in ${controller.sliderList}'),
                  )
                : ListView(
                    children: [
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: (){
                          Get.to(SearchView());
                        },
                        child: getSearch(),
                      ),

                      const SizedBox(height: 15),
                      getSliders(controller.sliderList),
                      const SizedBox(height: 20),
                      getTopCategoryList(controller.topcatlist),
                      const SizedBox(height: 15),
                      getBanner(controller.bannerOne.imgurl.toString(),
                          'iCommerce Sale is on'),
                      const SizedBox(height: 20),
                      getCategoryList(controller.catlist),
                      const SizedBox(height: 15),
                      getBanner('https://firebasestorage.googleapis.com/v0/b/fir-2707f.appspot.com/o/Website%20banner%201.jpg?alt=media&token=ea6b05be-13a8-482e-ba34-da2c35667045', 'Sale is On')
                      //getBanner(controller.bannerTow.imgurl.toString(),
                         // 'Get upto 10% off'),
                     , const SizedBox(height: 20),
                    ],
                  );
          }
        },
      ),
    );
  }

  getSliders(List<Sliderlist> sliderList) => Container(
      color: Colors.white,
      height: 180.0,
      width: double.infinity,
      child: CarouselSlider(
          // items: [
          //   Card(
          //       child: Image.network(
          //         'https://ndugagambia.iwebnext.net/${sliderList[index].imgurl!}',
          //         fit: BoxFit.fill,
          //       )),
          // ],
          items: getSliderList(sliderList),
          options: CarouselOptions(
            height: 180,
            aspectRatio: 16 / 12,
            viewportFraction: .8,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.linear,
            enlargeCenterPage: true,
            //onPageChanged: callbackFunction,
            scrollDirection: Axis.horizontal,
          ))

      // })
      );

  getSliderList(List<Sliderlist> sliderList) {
    List<String> imgList = [];

    for (int i = 0; i < sliderList.length; i++) {
      imgList.add(sliderList[i].imgurl!);
    }
    //print('imageList in slider...$imgList');

    return imgList
        .map((item) => FadeInImage(
            fit: BoxFit.fill,
            image: NetworkImage('$imageUrl$item'),
            placeholder: const AssetImage('assets/images/loading.gif')))
        .toList();
  }

  getTopCategoryList(List<Catlist> topcatlist) => Container(
      margin: const EdgeInsets.only(left: 5, right: 5),
      padding: const EdgeInsets.only(top: 15, bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '     Top Categories',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => CategoryView());
                },
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'view all   ',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 3,
            childAspectRatio: 8.0 / 11.5,
            //productList[index].node.variants.edges[0]
            //controller.productList.length
            children: List<Widget>.generate(
                topcatlist.length > 3 ? 3 : topcatlist.length, (index) {
              return getTopCategoryItem(topcatlist, index);
            }),
          )
        ],
      ),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Colors.white,
                Colors.white,
              ]),
          color: Colors.grey[300],
          borderRadius: const BorderRadius.all(Radius.circular(15.0))));

  getTopCategoryItem(List<Catlist> topcatlist, int index) => InkWell(
        onTap: () {
          Get.to(() =>
              ProductView(topcatlist[index].srno!, topcatlist[index].name!));
        },
        child: Card(
          elevation: 2.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
              width: 110,
              height: 170,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 12),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      width: double.infinity,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(topcatlist[index].name!,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        color: Colors.black12,
                        height: 25,
                        width: 25,
                        child: const ClipRect(
                          child: Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 10,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Container(
                          width: 80,
                          height: 110,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    '$imageUrl${topcatlist[index].image!}')),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(14)),
                            color: Colors.black12,
                          ),
                        ),
                      ),

                      /*
                  Container(
                    width: 64,
                    height: 83,
                    // child:Expanded(child: Image.asset('assets/images/banner1.jpg', fit: BoxFit.cover)),

                    //'https://ndugagambia.iwebnext.net/${topcatlist[index].image}'!
                    child: Expanded(
                      child: FadeInImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://ndugagambia.iwebnext.net/${topcatlist[index].image}'!),
                          placeholder:
                              const AssetImage('assets/images/loading.gif')),
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      image:
                    ),
                  ),

                   */
                    ],
                  )
                ],
              ),
              decoration: BoxDecoration(
                  border: Border.all(width: .3,color: Colors.black12),
                 //  gradient: const LinearGradient(
                 //      begin: Alignment.topLeft,
                 //      end: Alignment.bottomRight,
                 //      colors: [Colors.tealAccent, Colors.white60]),
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)))),
        ),
      );

  getBanner(String bannerOne, String bannerTitle) => Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Text(
            bannerTitle,
            style: const TextStyle(
                color: Colors.green, fontSize: 13, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            width: double.infinity,
            height: 140,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage('$imageUrl$bannerOne')),
              borderRadius: const BorderRadius.all(Radius.circular(14)),
              color: Colors.black12,
            ),
          ),
        ],
      );

  getSearch() => Container(
        margin: const EdgeInsets.only(left: 50, right: 50),
        height: 36,
        width: double.infinity,
        child: Row(
          children: const [
            SizedBox(width: 20),
            Icon(Icons.search, size: 18),
            SizedBox(width: 20),
            Text(
              'Search for products',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        decoration: const BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
        ),
      );

  getCategoryList(List<Catlist> catlist) => Container(
      margin: const EdgeInsets.only(left: 5, right: 5),
      padding: const EdgeInsets.only(top: 15, bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '     Categories',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => CategoryView());
                },
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'view all   ',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),

          /*

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(ProductView('', ''));
                  },
                  child: getTopCategoryItem(
                      'Vegetable',
                      '15%',
                      'assets/images/banner1.jpg',
                      <Color>[Colors.tealAccent, Colors.white60]),
                ),
                getTopCategoryItem('Grocery', '15%', 'assets/images/spice.png',
                    <Color>[Colors.yellow, Colors.white60]),
                getTopCategoryItem(
                    'Baby & Child',
                    '15%',
                    'assets/images/child.png',
                    <Color>[Colors.lightBlueAccent, Colors.white60])
              ],
            ),

             */

          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 3,
            childAspectRatio: 8.0 / 12.5,
            //productList[index].node.variants.edges[0]
            //controller.productList.length
            children: List<Widget>.generate(
                catlist.length > 6 ? 6 : catlist.length, (index) {
              return getCategoryItem(catlist, index);
            }),
          )
        ],
      ),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          // gradient: const LinearGradient(
          //     begin: Alignment.topLeft,
          //     end: Alignment.bottomRight,
          //     colors: <Color>[
          //       Colors.white30,
          //       Colors.green,
          //     ]),
          color: Colors.grey[50],
          borderRadius: const BorderRadius.all(Radius.circular(15.0))));

  getCategoryItem(List<Catlist> catlist, int index) => InkWell(
        onTap: () {
          Get.to(() => ProductView(catlist[index].srno!, catlist[index].name!));
        },
        child: Container(
            margin: const EdgeInsets.all(2),
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
                              '$imageUrl${catlist[index].image!}')),
                      borderRadius: const BorderRadius.all(Radius.circular(14)),
                      color: Colors.grey[50],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 4, right: 4, top: 6, bottom: 6),
                  child: Text('${catlist[index].name}',
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center),
                )
              ],
            ),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                color: Colors.grey[100],
                borderRadius: const BorderRadius.all(Radius.circular(15.0)
                ))),
      );
}
