import 'package:connectme/controllers/auth_controller.dart';
import 'package:connectme/controllers/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButtomBar extends GetView<NavigationController> {
  const CustomButtomBar({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AuthenticationController());
    return Obx(
      () => BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blueAccent,
        currentIndex: controller.selectedAthoursPage.value,
        onTap: (value) => controller.changePageAuthors(value),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.connect_without_contact,
            ),
            label: 'Peers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mobile_friendly_rounded),
            label: 'Friends',
          ),
        ],
      ),
    );
  }
}
