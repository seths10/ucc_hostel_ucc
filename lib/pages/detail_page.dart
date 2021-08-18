import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_indicator/flutter_slider_indicator.dart';
import 'package:ucc_hostel/core/const.dart';
import 'package:ucc_hostel/models/apartment_model.dart';

class Detail_page extends StatefulWidget {
  final ApartmentModel data;
  Detail_page(this.data);
  @override
  _Detail_pageState createState() => _Detail_pageState();
}

class _Detail_pageState extends State<Detail_page> {
  var _pageController = PageController();
  var _currentIndex = 0;
  var _maxLines = 3;

  @override
  Widget build(BuildContext context) {
    _pageController.addListener(() {
      setState(() {
        _currentIndex = _pageController.page.round();
      });
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _buildImageSlider(context),
          _buildWidgetImageIndicator(context),
          _buildWidgetButtonClose(context),
          _buildWidgetPrice(),
          DraggableScrollableSheet(
            initialChildSize: .5,
            minChildSize: .5,
            maxChildSize: .8,
            builder: (context, controller){
              return SingleChildScrollView(
                controller: controller,
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 25),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Icon(
                              Icons.drag_handle,
                              color: Colors.black38),
                          ),
                          Padding(
                            padding: EdgeInsets.all(24),
                            child: Text(
                              widget.data.name,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 _buildWidgetSize(
                                     "3 in A Room",
                                     widget.data.threeinRoom),
                                 Container(
                                   width: 1,
                                   height: 50,
                                   color: Colors.black38,
                                 ),
                                 _buildWidgetSize("2 in A Room",
                                     widget.data.twoinRoom),
                                Container(
                                  width: 1,
                                  height: 50,
                                  color: Colors.black38,
                                ),
                                 _buildWidgetSize("1 in A Room",
                                     widget.data.oneinRoom),
                              ],
                            ),
                          ),
                          SizedBox(height: 24),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              widget.data.desc,
                              maxLines: _maxLines,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                height: 1.5,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  if (_maxLines == 3){
                                    _maxLines = 10;
                                  } else {
                                    _maxLines = 3;
                                  }
                                });
                              },
                              child: Text(
                                _maxLines == 3 ? "Read more" : "Read Less",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.stylecolor,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWidgetSize(String name, int size) {
    return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text("¢$size",
                                  style: TextStyle(
                                    color: Colors.black,
                                    height: 1.5,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            );
  }

  Widget _buildImageSlider(BuildContext context) {
    return Container(
          height: MediaQuery.of(context).size.height * .6,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.data.images.length,
              itemBuilder: (context, index){
                return Image.asset('assets/${widget.data.images[index]}.png',
                fit: BoxFit.cover,
                );
              },
              ),
        );
  }

  Widget _buildWidgetImageIndicator(BuildContext context) {
    return Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * .45),
            child: SliderIndicator(
                length: widget.data.images.length,
                activeIndex: _currentIndex,
                indicator: Icon(
                  Icons.radio_button_unchecked,
                  color: Colors.white,
                  size: 10,
                ),
                activeIndicator: Icon(
                  Icons.fiber_manual_record,
                  color: Colors.white,
                  size: 12,
                ),
            ),
          ),
        );
  }

  Widget _buildWidgetButtonClose(BuildContext context) {
    return Align(
          alignment: Alignment.topRight,
          child: Container(
            margin: EdgeInsets.only(right: 24, top: 45),
            child: IconButton(
              icon: Icon(Icons.close,
              color: Colors.black
              ),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
          ),
        );
  }

  Widget _buildWidgetPrice() {
    return Container(
          margin: EdgeInsets.only(left: 24,top: 50),
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("¢${widget.data.price}/",
                style: TextStyle(color: Colors.white),
              ),
              Text("year",
                style: TextStyle(color: Colors.white, fontSize: 16,),
              ),
            ],
          ),
        );
  }
}