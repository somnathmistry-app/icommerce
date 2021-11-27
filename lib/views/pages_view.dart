import 'package:badges/badges.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:icommerce/controllers/cart_controller.dart';
import 'package:icommerce/controllers/conditions_controller.dart';
import 'package:icommerce/controllers/login_controller.dart';
import 'package:icommerce/styles/app_colors.dart';
import 'package:icommerce/views/contact_view.dart';
import 'package:icommerce/views/notification_view.dart';
import 'package:icommerce/views/order_list.dart';
import 'package:icommerce/views/privacy_policy.dart';
import 'package:icommerce/views/profile_view.dart';
import 'package:icommerce/views/return_policy.dart';
import 'package:icommerce/views/terms_condition.dart';
import 'package:icommerce/views/top_view.dart';
import 'package:icommerce/views/wish_list_view.dart';
import 'package:share/share.dart';
import 'cart_views.dart';
import 'home_view.dart';
import 'login_view.dart';

class PagesView extends StatefulWidget {
  @override
  _PagesViewState createState() => _PagesViewState();
}

class _PagesViewState extends State<PagesView> {
  final int _currentIndex = 0;
  final PageController _pageController = PageController();
  LoginController loginController = Get.put(LoginController());
  ConditionController conditionController = Get.put(ConditionController());
  GlobalConfiguration globalConfiguration = GlobalConfiguration();
  CartController cartController = Get.put(CartController());
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();


  final List<Widget> _screens = [
    const HomeView(),
    TopView(),
    CartView(cartFrom: 'noappbar'),
    NotificationView(),
    ProfileView()
  ];

  int _selectedIndex = 0;
  var box = GetStorage();

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedItem) {
    print(selectedItem);
    _pageController.jumpToPage(selectedItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: getDrawer(),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.jpg',
              width: 75,
            ),
            const SizedBox(width: 10),
          ],
        ),
        backgroundColor: AppColors.white,
        actions: [
          //Container(color:Colors.deepPurple,child: Text('data')),

          Obx(
            () => loginController.isLogin.value || box.hasData('userId')
                ? InkWell(
                    onTap: () {
                      Get.to(() => LoginView());
                    },
                    child: Center(
                      child: Text(
                        box.read('name'),
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ))
                : IconButton(
                    icon: SvgPicture.asset('assets/images/user.svg'),
                    color: Colors.teal,
                    onPressed: () {
                      Get.to(() => LoginView());
                    }),
          ),
          Obx(()=>Badge(
            badgeColor: Colors.deepOrange,
            position: BadgePosition.topEnd(top: 2, end: 4),
            badgeContent: Text(CartController.cartItem.value, style: const TextStyle(color: Colors.white, fontSize: 11),),
            child: IconButton(
              icon: Icon(Icons.shopping_cart, color: AppColors.black),
              onPressed: () {
                Get.to(() => CartView());
              },
            ),
          )),
          const SizedBox(width: 4,)
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar:
      CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 56.0,
        items: <Widget>[
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: Icon(Icons.home_filled, size: 20, color: AppColors.white),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Icon(Icons.assistant, size: 22, color: AppColors.white),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Icon(Icons.shopping_cart, size: 22, color: AppColors.white),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Icon(Icons.notifications, size: 22, color: AppColors.white),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Icon(Icons.person, size: 22, color: AppColors.white),
          ),
        ],
        color: AppColors.themeColor,
        buttonBackgroundColor: AppColors.themeColorTwo,
        backgroundColor: AppColors.trasparent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: _onItemTapped,
        letIndexChange: (index) => true,
      ),


      /*
      BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.white,
        selectedFontSize: 16,
        onTap: _onItemTapped,
        items: [
          // /   HomeView(),
          //     TopBrandView(),
          //     OrderView(),
          //     AccountView()
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled,
                color: _selectedIndex == 0
                    ? AppColors.themeColor
                    : Colors.blueGrey.shade400),
            title: Text(
              'Home',
              style: TextStyle(
                  color: _selectedIndex == 0
                      ? AppColors.themeColor
                      : Colors.blueGrey.shade400,
                  fontSize: 14),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assistant,
                color: _selectedIndex == 1
                    ? AppColors.themeColor
                    : Colors.blueGrey.shade400),
            title: Text(
              'Top',
              style: TextStyle(
                  color: _selectedIndex == 1
                      ? AppColors.themeColor
                      : Colors.blueGrey.shade400),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications,
                color: _selectedIndex == 2
                    ? AppColors.themeColor
                    : Colors.blueGrey.shade400),
            title: Text(
              'Notification',
              style: TextStyle(
                  color: _selectedIndex == 2
                      ? AppColors.themeColor
                      : Colors.blueGrey.shade400),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle,
                size: 28,
                color: _selectedIndex == 3
                    ? AppColors.themeColor
                    : Colors.blueGrey.shade400),
            title: Text(
              'Account',
              style: TextStyle(
                  color: _selectedIndex == 3
                      ? AppColors.themeColor
                      : Colors.blueGrey.shade400),
            ),
          ),
        ],
      ),

       */
    );
  }

  Widget getDrawer() {
    // String userName = box.read('name');
    // String email = box.read('email');
    return ListView(
      children: [
        Obx(() => InkWell(
          onTap: (){},
          child: UserAccountsDrawerHeader(
                // accountName: Text(box.read('name')),
                // accountEmail: Text(box.read('email')),
                accountName: loginController.isLogin.value || box.hasData('userId')
                    ? Text(box.read('name'))
                    : const Text('Guest'),
                accountEmail: loginController.isLogin.value || box.hasData('userId')
                    ? Text(box.read('email'))
                    : const Text(''),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: AppColors.white,
                  child: Image.asset('assets/images/logo.jpg', scale: 5),
                ),
              ),
        )),
        ListTile(
          onTap: () {
            Get.back();
            Get.to(WishListView());
          },
          title: const Text('Save Products'),
          leading: const Icon(Icons.save),
        ),

        ListTile(
          onTap: () {
            Get.back();
            Get.to(OrderListView());
          },
          title: const Text('My Order'),
          leading: const Icon(Icons.shopping_cart),
        ),
        ListTile(
          onTap: () {
            Get.back();
            Get.to(ReturnPolicy());
          },
          title: const Text('Return Policy'),
          leading: const Icon(Icons.save),
        ),
        ListTile(
          onTap: () {
            Get.back();
            Get.to(PrivacyPolicy());
          },
          title: const Text('Privacy & policy'),
          leading: const Icon(Icons.policy),
        ),
        ListTile(
          onTap: () {
            Get.back();
            Get.to( TermsAndConditionView());
          },
          title: const Text('Terms & condition'),
          leading: const Icon(Icons.branding_watermark_sharp),
        ),
        //Get.to(ContactView());
        ListTile(
          onTap: () {
            Get.back();
            Get.to(ContactView());
          },
          title: const Text('Support'),
          leading: const Icon(Icons.contact_support),
        ),
        ListTile(
          onTap: () {
            Get.back();
            Share.share(
                'Download Ndugagambia app \n\nhttps://play.google.com/store/apps/details?id=com.ndugagambia');
          },
          title: const Text('Share app'),
          leading: const Icon(Icons.share),
        ),
        ListTile(
          onTap: () {
            Get.back();
            conditionController.launchURL(globalConfiguration.get('app_playstore_link'));
          },
          title: const Text('Rate us'),
          leading: const Icon(Icons.star_rate),
        ),
        ListTile(
          onTap: () {
            box.erase();
            loginController.isLogin(false);
            Get.back();
            //Get.to(SupportView(contextFrom: 'drawer',));
          },
          title: const Text('Logout'),
          leading: const Icon(Icons.logout),
        ),
      ],
    );
  }
}

class Person {
  final String name, surname;
  final num age;

  Person(this.name, this.surname, this.age);
}