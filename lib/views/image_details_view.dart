import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageDetialsView extends StatelessWidget {
  //const ImageDetialsView(sliderList, {Key? key}) : super(key: key);
  var sliderList;


  ImageDetialsView(this.sliderList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CarouselSlider(
          options: CarouselOptions(
            autoPlay: false,
            aspectRatio: .6,
            enlargeCenterPage: true,
          ),
          //items: [Image.asset('assets/images/banner1.jpg')],
          items: sliderList,
        ),
      ),
    );
  }
}
