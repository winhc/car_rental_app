import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/account_controller.dart';

class AccountView extends GetView<AccountController> {
  const AccountView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Obx(
            () => ListTile(
              title: Text(
                "${controller.userName}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("${controller.userEmail}"),
            ),
          ),
          const Divider(
            thickness: 0.5,
          ),
          ListTile(
            onTap: () {
              controller.goToFavouriteView();
            },
            leading: const Icon(CupertinoIcons.heart_fill),
            title: const Text("Your favourite"),
          ),
          const Divider(
            thickness: 0.5,
          ),
          ListTile(
            onTap: () {
              controller.onLogoutClick(context);
            },
            leading: const Icon(Icons.logout_outlined),
            title: const Text("Logout"),
          ),
          const Divider(
            thickness: 0.5,
          )
        ],
      ),
    );
  }
}
