import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_booking/json/category_json.dart';
import 'package:cinema_booking/json/movie_json.dart';
import 'package:cinema_booking/pages/details_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 1;
  PageController? controller;
  final double _viewPortFraction=0.6;
  double pageOffset = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=PageController(initialPage: 1,
        viewportFraction: _viewPortFraction
    )..addListener(() {setState(() {
      pageOffset=controller!.page!;
    });});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Welcome Sanjesh",style: TextStyle(fontSize: 14,color: Colors.white.withOpacity(0.8)),),
                      SizedBox(width: 5,),
                      Image.network("https://icons.iconarchive.com/icons/google/noto-emoji-people-bodyparts/512/12050-waving-hand-icon.png",width: 24,)
                    ],
                  ),
                Text("Let's relax and watch movie  !",style: TextStyle(fontSize: 14,color: Colors.white.withOpacity(0.8),fontWeight: FontWeight.bold),)
                ],
              ),
              Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white,width: 0.5),
                  image: DecorationImage(
                    image: NetworkImage("https://wallpapers.com/images/hd/cool-profile-picture-87h46gcobjl5e4xu.jpg"),fit: BoxFit.fitHeight
                  )
                ),
              )
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(30)
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Search",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                  prefixIcon: Icon(Icons.search,color: Colors.white.withOpacity(0.7),size: 20,)
                ),
              ),
            ),
          ),
          SizedBox(height: 15,),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("Category",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.white),),
                Row(
                  children: [
                    Text("See All",style: TextStyle(fontSize: 14,color: Colors.orange),),
                    Icon(Icons.chevron_right_outlined,color: Colors.orange,size: 20,)
                  ],

                )
              ],
            ),
          ),
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(categories.length, (index) {
                return Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width*0.15,
                      width:  MediaQuery.of(context).size.width*0.15,

                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Center(child: Text(categories[index].emoticon,style: TextStyle(fontSize: 30),)),
                    ),
                    SizedBox(height: 8,),
                    Text(categories[index].name,style: TextStyle(fontSize: 12,color: Colors.white),)
                  ],
                );
              }),
            ),
          ),
          SizedBox(height: 15,),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text("Showing this month",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.white),),
          ),
          SizedBox(height: 15,),
          Expanded(
            child: Stack(
              children: [
                PageView.builder(
                  controller: controller,
                  itemCount: movies.length,
                    onPageChanged: (value){
                    setState(() {
                      currentIndex = value;
                    });
                    },

                    itemBuilder: (context,index){
                    double scale = max(_viewPortFraction,(1-(pageOffset-index).abs())+_viewPortFraction);
                    double angle=0.0;
                    if (controller!.position.haveDimensions){
                      angle=index.toDouble()-(controller!.page??0);
                      angle=(angle*5).clamp(-5, 5);

                    }else{
                      angle=index.toDouble()-1;
                      angle=(angle*5).clamp(-5, 10);

                    }
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(movie: movies[index],)));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 100-(scale/1.6*100),left: 20),
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Transform.rotate(
                            angle: angle*pi/100,
                            child: Hero(
                              tag: movies[index % movies.length].title,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                child: CachedNetworkImage(
                                  height: MediaQuery.of(context).size.height*0.37,
                                  width: MediaQuery.of(context).size.width*0.6,
                                  fit: BoxFit.cover,
                                  imageUrl: movies[index].poster,
                                  errorWidget: (context,url,error){
                                    return Icon(Icons.error);
                                  },
                                  progressIndicatorBuilder: (context,url,progress){
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: progress.progress,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          width: currentIndex == index ?30 :10,
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: currentIndex == index ? Colors.yellow:Colors.white
                          ),
                        ),
                      );
                    }),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
