import 'dart:async';

import 'package:flutter/material.dart';

class CircularSlider extends StatefulWidget {
  final List<String> myImages;

  CircularSlider(this.myImages);

  @override
  _CircularSliderState createState() => _CircularSliderState();
}

class _CircularSliderState extends State<CircularSlider> {
  PageController _pageController;
   int maxCount = 0;
  int currentIndex = 0;



  List<bool> myIndicators=[
    false,
    false,
    false,
    false,
  ];
  List<String> myImages;


  @override
  void initState() {
    super.initState();
 myImages=widget.myImages;
 maxCount=myImages.length*100;
 currentIndex=(maxCount/2).toInt();

    Timer.periodic(Duration(seconds: 2), (Timer timer) {
      if (currentIndex == maxCount / 2) {
        _pageController.jumpToPage(currentIndex);
        currentIndex++;
      } else if (currentIndex < maxCount) {
        _pageController.animateToPage(currentIndex,
            duration: Duration(milliseconds: 100), curve: Curves.easeInCirc);
        currentIndex++;
      } else {
        currentIndex = (maxCount / 2).toInt();
        _pageController.jumpToPage(currentIndex);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Circular Slider"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.25,
        child: Container(
          margin: EdgeInsets.all(8),
          child: GridTile(
            child: PageView.builder(
              pageSnapping: true,
              controller: _pageController = PageController(initialPage: 0),
              allowImplicitScrolling: true,
              onPageChanged: (value) {
                currentIndex = value;
                setState(() {
                  for(int i=0;i<myIndicators.length;i++){
                    if(i==value%4)
                      myIndicators[i]=true;
                    else
                      myIndicators[i]=false;
                  }
                });

              },
              itemCount: maxCount,
              itemBuilder: (ctx, index) => Container(
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
            footer: GridTileBar(
              backgroundColor: Colors.black54,
              leading: null,
              trailing: null,
              title: Container(
                alignment: Alignment.center,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: myImages.length,
                    itemBuilder: (context, index) {
                      return myIndicators[index]
                          ? Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Image.asset(
                                "assets/images/selected.png",
                                width: 15,
                                height: 15,
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Image.asset(
                                "assets/images/unselected.png",
                                width: 15,
                                height: 15,
                              ),
                            );
                    }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
