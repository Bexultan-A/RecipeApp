import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:reciepe_app/components/custom_clip_path.dart';
import 'package:reciepe_app/constants/show_detail_dialog.dart';
import 'package:reciepe_app/constants/start_cooking.dart';

import '../components/circle_button.dart';
import '../components/ingredient_list.dart';

class DetailScreen extends StatefulWidget {
  final Map<dynamic,dynamic> item;
  const DetailScreen({super.key, required this.item});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    var myBox = Hive.box('saved');
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    int quantityItems = widget.item["ingredients"].length;
    int time = widget.item['totalTime'].toInt();
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: h*.44,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(widget.item['image']), fit: BoxFit.cover)
                  ),
                ),
                Positioned(
                  top: h*.04,
                  left: w*.05,
                  child: const CircleAvatar(
                  backgroundColor: Colors.redAccent,
                  child: BackButton(color: Colors.white,),
                  )
                ),
              ],
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: w*.04),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20,),
                  Text(widget.item['label'],
                  style: TextStyle(fontSize: w*.05, fontWeight: FontWeight.w700, color: Colors.black),),
                  const SizedBox(height: 1,),
                  Text("$time min"),
                  SizedBox(height: h*.01,),
        
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        child: const CircleButton(icon: Icons.share, label: 'Share',)
                      ),
                      ValueListenableBuilder(
                        valueListenable: myBox.listenable(), 
                        builder: (context, box, _) {
                          String key = widget.item['label'];
                          bool saved=myBox.containsKey(key);
                          if(saved) {
                            return GestureDetector(
                              onTap: () {
                                myBox.delete(key);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    duration: Duration(seconds: 1),
                                    content: Text('Recipe deleted')
                                  )
                                );
                              },
                              child: const CircleButton(icon: Icons.bookmark, label: 'Saved',)
                            );
                          }
                          else {
                            return GestureDetector(
                              onTap: () {
                                myBox.put(key, widget.item);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    duration: Duration(seconds: 1),
                                    content: Text('Recipe saved successfully')
                                  )
                                );
                              },
                              child: const CircleButton(icon: Icons.bookmark_border, label: 'Save',)
                            );
                          }
                        }
                      ),
                      GestureDetector(
                        onTap: () {
                          ShowDialog.showCallories(widget.item['totalNutrients'], context);
                        },
                        child: const CircleButton(icon: Icons.monitor_heart_outlined, label: 'Calories',)
                      ), 
                    ],
                  ),
                  SizedBox(height: h*.02,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Direction', style: TextStyle(fontWeight: FontWeight.bold, fontSize: w*.06),),
                      SizedBox(width: w*.34,
                      child: ElevatedButton(onPressed: (){
                        StartCooking.startCooking(widget.item['url']);
                      },
                        child: Text('Start'),),),                    
                    ],
                  ),
        
                  SizedBox(height: h*.02,),
        
                  Container(
                    height: h*.07,
                    width: w,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: ClipPath(
                          clipper: CustomClipPath(),
                          child: Container(
                            color: Colors.redAccent,
                            child: Center(
                              child: Text('Ingridients Required',
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: w*.05),),
                            ),
                          ),
                        )),
                        Expanded(flex: 1, child: Container(
                          color: Colors.white,
                          child: Center(
                            child: Text('  $quantityItems\nItems'),
                          ),
                        ),)
                      ],
                    ),
                  ),
                  SizedBox(height: h*1.8,
                    child: IngredientList(
                      ingredients: widget.item['ingredients'],
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}