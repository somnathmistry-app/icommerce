import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:icommerce/controllers/conditions_controller.dart';
import 'package:icommerce/styles/app_colors.dart';
import 'package:icommerce/styles/commonmodule/app_bar.dart';

class ContactView extends StatelessWidget {
  ConditionController conditionController = Get.put(ConditionController());
  var box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('May I help you ?'),
      body: SafeArea(
        child: LimitedBox(
            maxHeight: double.infinity,
            child: GetX<ConditionController>(
              initState: (context) {
                conditionController.getContact();
              },
              builder: (controller) {
                if (controller.isLoading.value) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Center(child: CircularProgressIndicator()),
                        // HeartbeatProgressIndicator(
                        //   child: Icon(Icons.shopping_cart,
                        //       color: AppColors.themeColorTwo),
                        // ),
                        SizedBox(height: 10),
                        Text(
                          'Loading contacts..',
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  );
                } else {
                  return

                      // controller.contactData == null
                      //   ? const Center(
                      //       child: Text('No Contacts available'),
                      //     )
                      //   :
                      Align(
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        Text(
                          'GET IN TOUCH',
                          style: TextStyle(
                              color: AppColors.themeColorTwo,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        const SizedBox(height: 30),
                        Card(
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 15, bottom: 15, left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getFaqListItem('Our corporate address',
                                      'assets/images/add.png'),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 45),
                                    child: Text(
                                      controller.contactData.value.addr!,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  getFaqListItem(
                                      controller.contactData.value.phno!,
                                      'assets/images/phone.png'),
                                  const SizedBox(height: 10),
                                  getFaqListItem(
                                      controller.contactData.value.email!,
                                      'assets/images/email.png'),

                                  // const SizedBox(height: 10),
                                  // getFaqListItem(controller.contactData.value.instalink!, 'assets/images/instagram.png'),
                                  // const SizedBox(height: 10),
                                  // getFaqListItem(controller.contactData.value.twitlink!, 'assets/images/twitter.png'),
                                  // const SizedBox(height: 10),
                                  // getFaqListItem(controller.contactData.value.linkdinlink!, 'assets/images/linkedin.png'),
                                  // const SizedBox(height: 10),
                                  // getFaqListItem(controller.contactData.value.youtubelink!, 'assets/images/youtube.png'),
                                ],
                              ),
                            )),
                        const SizedBox(height: 100),
                        const Text(
                          'Follow us on',
                          style: TextStyle(fontSize: 14, color: Colors.blue),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //await flutterShareMe.shareToFacebook(url: url, msg: msg);
                            InkWell(
                              onTap: () async {
                               // print('Facebook');
                                conditionController.launchURL(controller.contactData.value.fblink!);
                              },
                              child:
                                  getSocialIcons('assets/images/facebook.png'),
                            ),
                            InkWell(
                              onTap: (){
                conditionController.launchURL(controller.contactData.value.instalink!);
                              },
                              child: getSocialIcons('assets/images/instagram.png'),
                            ),
                            InkWell(
                              onTap: (){
                conditionController.launchURL(controller.contactData.value.twitlink!);
                              },
                              child: getSocialIcons('assets/images/twitter.png'),
                            ),
                            InkWell(
                              onTap: (){
                                conditionController.launchURL(controller.contactData.value.linkdinlink!);
                              },
                              child: getSocialIcons('assets/images/linkedin.png'),
                            ),
                            InkWell(
                              onTap: (){
                                conditionController.launchURL(controller.contactData.value.youtubelink!);
                              },
                              child: getSocialIcons('assets/images/youtube.png'),
                            )

                          ],
                        )
                      ],
                    ),
                  );
                }
              },
            )),
      ),
    );
  }

  Widget getFaqListItem(String data, String img) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(img, scale: 18),
        SizedBox(width: 15),
        Text(data),
      ],
    );
  }

  getSocialIcons(String img) => Image.asset(img, scale: 13);


  /// SHARE ON FACEBOOK CALL
  // shareOnFacebook() async {
  //   String? result = await FlutterSocialContentShare.share(
  //       type: ShareType.facebookWithoutImage,
  //       url: "https://www.apple.com",
  //       quote: "captions");
  //   print(result);
  // }
  //
  // /// SHARE ON INSTAGRAM CALL
  // shareOnInstagram() async {
  //   String? result = await FlutterSocialContentShare.share(
  //       type: ShareType.instagramWithImageUrl,
  //       imageUrl:
  //       "https://post.healthline.com/wp-content/uploads/2020/09/healthy-eating-ingredients-732x549-thumbnail-732x549.jpg");
  //   print(result);
  // }
}
