import 'package:flutter/material.dart';
import 'package:reciepe_app/constants/constant_function.dart';

import '../views/detail_screen.dart';

class TabBarTrendingWidget extends StatelessWidget {
  const TabBarTrendingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return HomeTabBarView(recipe: 'trending');
  }
}

class HomeTabBarView extends StatelessWidget {
  final String recipe;
  const HomeTabBarView({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: ConstantFunction.getResponse(recipe), 
      builder: (context, snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }else if(!snapshot.hasData){
          return const Center(
            child: Text('no data'),
          );
        }
        return SizedBox(
          height: h*.38,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              Map<String,dynamic> snap = snapshot.data![index];
              int time=snap['totalTime'].toInt();
              int calories=snap['calories'].toInt();
              return Container(
                margin: EdgeInsets.only(
                  right: w*.02
                ),
                width: w*.8,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context,
                              MaterialPageRoute(builder: (context)=>DetailScreen(item: snap,))
                            );
                          },
                          child: Container(
                            width: w,
                            height: h*.27,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(image: NetworkImage(snap['image']),
                                fit:BoxFit.fill) 
                            ),
                          ),
                        ),
                        SizedBox(height: h*.01,),
                        Text(snap['label'], style: TextStyle(
                          fontSize: w*.035,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.fade
                        ),
                        maxLines: 2,
                        ),
                        SizedBox(height: h*.01,),
                        Text("calories: ${calories.toString()} time: ${time.toString()} min", style: TextStyle(
                          fontSize: w*.03, color:const Color(0xff3D3D3D)
                        ),),
                      ],
                    )
                  ],
                ),
              );
            }, 
            separatorBuilder: (context, index) {
              return const SizedBox(width: 10,);
            }, 
            itemCount: snapshot.data!.length
          ),
        );
      },
    );
  }
}