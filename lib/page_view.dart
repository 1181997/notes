import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/favourite_page.dart';
import 'package:notes/home_page.dart';

class First extends StatelessWidget {
  const First({super.key});

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: Obx(() => Scaffold(
        appBar: AppBar(
          title: Text('Notes'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Notes'),
              Tab(text: 'Favorites'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            HomePage(), // Home page content
            FavoritePage(), // Favorite page content
          ],
        ),
      ),)
    );
  }
}
