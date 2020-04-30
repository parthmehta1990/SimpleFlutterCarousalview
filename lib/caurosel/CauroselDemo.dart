import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarusoelDemo extends StatefulWidget {
  CarusoelDemo() : super();

  final String title = "Carousel Demo";

  @override
  _CarusoelDemoState createState() => _CarusoelDemoState();
}

class _CarusoelDemoState extends State<CarusoelDemo> {
  int _current = 0; //To keep track of the current image

  //Handler for slider to go back and next in slider
  CarouselSlider _carouselSlider;

  //List of image
  List imgList = [
    'https://images.unsplash.com/photo-1502117859338-fd9daa518a9a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1554321586-92083ba0a115?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1536679545597-c2e5e1946495?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1543922596-b3bbaba80649?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1502943693086-33b5b1cfdf2f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80'
  ];

  //Creating Generic function to map each image to the each indicator
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    //Looping through the list of images
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i])); //passing the function to result
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _carouselSlider = _Slider(),
            //For indicator and button
            SizedBox(
              height: 25.0,
            ),
            _PageIndicator(),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlineButton(
                  onPressed: goToPrevious,
                  child: Text("<"),
                ),
                OutlineButton(onPressed: goToNext, child: Text(">")),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _Slider() {
    return CarouselSlider(
      height: 400,
      initialPage: 0,
      enlargeCenterPage: true,
      autoPlay: true,
      reverse: false,
      autoPlayInterval: Duration(seconds: 2),
      autoPlayAnimationDuration: Duration(milliseconds: 2000),
      pauseAutoPlayOnTouch: Duration(seconds: 3),
      enableInfiniteScroll: true,
      scrollDirection: Axis.horizontal,
      //To make horizontal slider set to Axis.Vertical
      onPageChanged: (index) {
        setState(() {
          _current = index;
        });
      },
      items: imgList.map((imgUrl) {
        return Builder(builder: (BuildContext context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Image.network(
              imgUrl,
              fit: BoxFit.fill,
            ),
          );
        });
      }).toList(),
    );
  }

  Widget _PageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: map<Widget>(imgList, (index, url) {
        return Container(
          width: 10.0,
          height: 10.0,
          margin: EdgeInsets.symmetric(horizontal: 2.0, vertical: 10.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _current == index ? Colors.redAccent : Colors.green,
          ),
        );
      }),
    );
  }

  goToPrevious() {
    _carouselSlider.previousPage(
        duration: Duration(milliseconds: 300), curve: Curves.ease);
  }

  goToNext() {
    _carouselSlider.nextPage(
        duration: Duration(milliseconds: 300), curve: Curves.decelerate);
  }
}
