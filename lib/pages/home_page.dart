import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ucc_hostel/core/const.dart';
import 'package:ucc_hostel/models/apartment_model.dart';
import 'package:ucc_hostel/pages/detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var data = ApartmentModel.list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.roofing),
            SizedBox(width: 10),
            Text('Ucc Hostels'),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Detail_page(data[index],),),);
                      },
                        child: _buildItem(context, index)
                    );
                    },
                  ),
              ),
            ],
    ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index){
    return Container(
      padding: EdgeInsets.all(12),
      height: 250,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: MediaQuery.of(context).size.width * .5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                image: DecorationImage(
                  image:
                    ExactAssetImage("assets/${data[index].images.first}.png"),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                   blurRadius: 7,
                   spreadRadius: 1,
                   color: Colors.black12,
                )
                ],
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black87,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.all(
                          Radius.circular(20),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: 12,
                        left: 40,
                        right: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * .25,
                            child: Text(
                              "${data[index].name}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          // Container(
                          //   padding: EdgeInsets.all(6),
                          //   child: Icon(
                          //     Icons.directions,
                          //     color: Colors.white,
                          //     size: 20,
                          //   ),
                          //   decoration: BoxDecoration(
                          //     color: Colors.black38
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          _buildDescription(context, index)
        ],
      ),
    );
  }

  Align _buildDescription(BuildContext context, int index) {
    return Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: MediaQuery.of(context).size.width * .43,
            height: 200,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 7,
                  spreadRadius: 1,
                  color: Colors.black12,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("¢${data[index].price}/",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Text("year",
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text("${data[index].location}",
                style: TextStyle(
                  color: Colors.black,
                ),
                ),

                Text("${data[index].telephone}",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                Wrap(
                  children: [
                    ...data[index].features.map(
                        (feature){
                          return Container(
                            padding: EdgeInsets.all(6),
                            margin: EdgeInsets.only(
                                bottom: 6,
                                right: 6
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(50)
                              ),
                              color: AppColors.stylecolor,
                            ),
                            child: Text(
                              feature,
                              style: TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
  }
}

