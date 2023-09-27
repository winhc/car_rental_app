import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widgets/welcome_title.dart';
import '../controllers/welcome_controller.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset("assets/images/car_front.png")),
          Container(
            color: Colors.white.withOpacity(0.5),
          ),
          const Positioned(
            top: 100,
            left: 16,
            child: Wrap(
              direction: Axis.vertical,
              children: [
                WelcomeTitle(title: "Find and "),
                WelcomeTitle(title: "rental car in"),
                WelcomeTitle(title: "easy steps."),
              ],
            ),
          ),
          Positioned(
              bottom: 20,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      controller.goToSign();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: 60,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          color: Colors.deepPurple),
                      child: const Center(
                          child: Text(
                        "Let's go",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
