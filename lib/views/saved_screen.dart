import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:reciepe_app/components/custom_app_bar.dart';
import 'package:reciepe_app/views/detail_screen.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    var myBox=Hive.box('saved');

    return Scaffold(
      appBar: const CustomAppBar(title: 'Saved', back: false,),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, right: 8, left: 8),
        child: ValueListenableBuilder(
          valueListenable: myBox.listenable(), 
          builder: (context, box, _) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                crossAxisSpacing: 10,
                childAspectRatio: .6/1
              ), 
              itemCount: box.length,
              itemBuilder: (context, index) {
                var data = box.values.toList();
                return Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                  MaterialPageRoute(builder: (context) =>DetailScreen(item: data[index]))
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: NetworkImage(data[index]['image']),
                                    fit: BoxFit.cover
                                  )
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 8,
                            left: 6
                          ),
                          child: Text(data[index]['label'],style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: w*.03
                          ),),
                        ),
                      ),
                    ],
                  ),
                );
            });
          },
        ),
      ),
    );
  }
}