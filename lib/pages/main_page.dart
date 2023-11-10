import 'package:cinema_booking/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<IconData> bottomIcons = [
    Icons.home_filled,
    CupertinoIcons.compass_fill,
    CupertinoIcons.ticket_fill,
    Icons.person,
  ];

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: IndexedStack(
        index: currentPage,
        children: [
          HomePage(),
          Center(child: Text("sanjesh",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),)),
          Center(child: Text("explore",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),)),
          Center(child: Text("profile",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),)),


        ]

      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(bottomIcons.length, (index) {
              return InkWell(
                onTap: (){
                  setState(() {
                    currentPage = index;
                    print(currentPage);
                  });
                },
                child: Stack(
                  children: [
                    AnimatedContainer(duration: Duration(milliseconds: 400),
                      height: currentPage == index ? 24:0,
                      width: currentPage == index ? 24:0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                          boxShadow: [
                          BoxShadow(
                            spreadRadius: currentPage == index ? 5:0,
                            blurRadius: currentPage == index ? 5:0,
                            color: Colors.white.withOpacity(0.3)
                          )
                        ]
                      ),
                    ),
                    Icon(
                      bottomIcons[index],
                      color: currentPage == index
                          ? Colors.white
                          : Colors.white.withOpacity(0.3),
                    ),
                  ],
                ),
              );
            })),
      ),
    );
  }
}
