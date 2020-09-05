import 'dart:async';

import 'package:flutter/material.dart';

class CircularSlider extends StatefulWidget {

  @override
  _CircularSliderState createState() => _CircularSliderState();
}

class _CircularSliderState extends State<CircularSlider> {
  PageController _pageController;

  List<String> myImages = [
    'assets/images/slider1.jpg',
    'assets/images/slider2.jpg',
    'assets/images/slider3.jpg',
    'assets/images/slider4.jpg',
  ];

  int i = 250;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 2), (Timer timer) {
      if (i == 60) {
        _pageController.jumpToPage(i);
        i++;
      } else if (i < 120) {
        _pageController.animateToPage(i,
            duration: Duration(milliseconds: 100), curve: Curves.easeInCirc);
        i++;
      } else {
        i = 60;
        _pageController.jumpToPage(i);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Circulat Slider"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.25,
        child: PageView.builder(
          pageSnapping: true,
          controller: _pageController = PageController(initialPage: 0),
          allowImplicitScrolling: true,
          onPageChanged: (value) {
            i = value;
          },
          itemCount: 500,
          itemBuilder: (ctx, index) => Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
            child: Container(
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.red,
                image: DecorationImage(
                    image: AssetImage(myImages[index % myImages.length]),
                    fit: BoxFit.cover),
                // boxShadow: [BoxShadow(blurRadius: 0,spreadRadius: 1,offset: Offset(2, 2),color: Colors.black26)]
              ),
            ),
          ),
        ),
      ),
    );
  }
}
