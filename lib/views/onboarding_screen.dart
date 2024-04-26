
import 'package:flutter/material.dart';
import 'package:reciepe_app/views/home.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SizedBox(
        height: h,
        width: w,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                height: h*.85,
                width: w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/bg.webp'),                      
                      fit: BoxFit.cover
                    )
                ),
              ),
            ),
            Center(
              child: Text('Recipe App', style: TextStyle(fontSize: 42, color: Colors.white),),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: h*.243,
                width: w,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: h*.032),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Lets cook good food', style: TextStyle(
                          fontSize: w*.06, fontWeight: FontWeight.w600,
                        ),),
                        SizedBox(height: h*.01,),
                        Text('Check out the app and start cooking delicious meals!',
                          style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(height: h*.032,),
                        SizedBox(
                          width: w*.8,
                          child: ElevatedButton(
                            onPressed: (){
                              Navigator.push(context,
                                MaterialPageRoute(
                                  builder: (context) => const Home()
                                )  
                              );
                            },
                            child: Text('Get Started', style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold,
                            ),),
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(Colors.redAccent),
                              ),
                          ),
                        )                    
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}