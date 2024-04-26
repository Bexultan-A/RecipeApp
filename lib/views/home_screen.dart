import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/home_app_bar.dart';
import '../components/tab_bar_widget.dart';
import '../components/text_field_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeAppBar(),
              SizedBox(
                height: h*.022,
              ),
              TextFieldWidget(),
              SizedBox(
                height: h*.022,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Categories', style: TextStyle(
                    fontSize: w*.045,
                    fontWeight: FontWeight.bold
                  ),),
                  const Text('see all'),
                  SizedBox(height: h*.022,),
                ],
              ),
              SizedBox(height: h*.022,),
              const TabBarWidget()
            ],
          ),
        ),
      ),),
    );
  }
}