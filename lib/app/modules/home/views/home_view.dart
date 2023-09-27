import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() =>
          controller.navPageList.elementAt(controller.currentPageIndex.value)),
      bottomNavigationBar: Obx(() => Theme(
            data: ThemeData(
              splashFactory: NoSplash.splashFactory,
            ),
            child: BottomNavigationBar(
                onTap: controller.onSelectedBottomNavigationBar,
                currentIndex: controller.currentPageIndex.value,
                showSelectedLabels: true,
                showUnselectedLabels: false,
                selectedItemColor: Colors.deepPurple,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.directions_car_outlined),
                    activeIcon: Icon(Icons.directions_car_filled),
                    label: 'Explore',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.directions),
                    activeIcon: Icon(Icons.directions),
                    label: 'Rent',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline),
                    activeIcon: Icon(Icons.person),
                    label: 'Account',
                  ),
                ]),
          )),
    );
  }
}
