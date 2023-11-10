import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_booking/json/movie_json.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class DetailsPage extends StatefulWidget {
  final Movie movie;

  const DetailsPage({Key? key, required this.movie}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 18,
            )),
        backgroundColor: Colors.transparent,
        title: Text(
          "Details Page",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Hero(
                      tag: widget.movie.title,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: CachedNetworkImage(
                          key: UniqueKey(),
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: MediaQuery.of(context).size.width * 0.6,
                          imageUrl: widget.movie.poster,
                          errorWidget: (context, url, error) {
                            return Icon(Icons.error);
                          },
                          progressIndicatorBuilder: (context, url, progress) {
                            return Center(
                              child: CircularProgressIndicator(
                                value: progress.progress,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        CategoryItem(
                          icon: Icons.videocam_rounded,
                          category: "genre",
                          categoryValue: widget.movie.genre,
                        ),
                        CategoryItem(
                            icon: Icons.access_time_filled,
                            category: "Duration",
                            categoryValue: widget.movie.duration.toString()),
                        CategoryItem(
                          icon: Icons.videocam_rounded,
                          category: "Rating",
                          categoryValue: "${widget.movie.rating} /10",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                widget.movie.title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.white,
                thickness: 0.5,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Synopsis",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) {
                  return LinearGradient(colors: [
                    Colors.white,
                    Colors.white.withOpacity(0.1),
                  ],
                    stops: const [
                      0.1,5.0
                    ],
                    end: Alignment.bottomCenter,
                    begin: Alignment.topCenter

                  ).createShader(Rect.fromLTRB(0, 0, 0, bounds.height));
                },
                child: Text(
                  widget.movie.synopsis,
                  maxLines: 7,
                  style: TextStyle(fontSize: 12, height:1.5,),
                ),
              ),
              SizedBox(height: 20,),

              MaterialButton(
                  onPressed: (){

                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),

                  ),
                  color: Colors.orange,
                  child: Center(child: Text("Get Reservation",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 14),)))
            ],
          ),
        ),

      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String category, categoryValue;

  const CategoryItem(
      {Key? key,
      required this.icon,
      required this.category,
      required this.categoryValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4 / 3.5,
      width: MediaQuery.of(context).size.width * 0.25,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.white),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.3),
                  )
                ]),
                child: Icon(
                  icon,
                  color: Colors.white,
                )),
            Text(
              category,
              style:
                  TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12),
            ),
            Text(
              categoryValue,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
