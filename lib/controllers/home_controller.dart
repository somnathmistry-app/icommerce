import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:icommerce/apis/home_api.dart';
import 'package:icommerce/models/home_model.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;
  var sliderList = <Sliderlist>[];
  var topcatlist = <Catlist>[];
  var catlist = <Catlist>[];
  Banner bannerOne = Banner();
  Banner bannerTow = Banner();
  var box = GetStorage();

  // @override
  // void onInit() {
  //   getHomeData(box.read('userId').toString());
  // } //JSON
  // status : ""
  // sliderlist
  // topcatlist
  // banner1
  // banner2
  // catlist
  // recentprd
  // similarprd

  getHomeData() async {
    try {
      isLoading(true);
      var homeData = await HomeApi.fetchHome(box.read('userId'));
      print('homeData $homeData');
      print('userId`````````````: ${box.read('userId')}');

      if (homeData != null) {
        sliderList.assignAll(homeData.sliderlist!);
        topcatlist.assignAll(homeData.topcatlist!);
        catlist.assignAll(homeData.catlist!);
        bannerOne = homeData.banner1!;
        bannerTow = homeData.banner2!;
        update();
        // categoryListStatic.assignAll(categories);
      }
    } finally {
      isLoading(false);
    }
  }
}
