import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectme/config/user_data_config.dart';
import 'package:connectme/controllers/new_user_auth.dart';
import 'package:connectme/models/user_model.dart';
import 'package:connectme/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';

class AuthenticationController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  var selectedImage = ''.obs;
  RxString selectedpdf = ''.obs;
  var selectedImageSize = ''.obs;

  var localImage = ''.obs;

  GetStorage getStorage = GetStorage();

  Map<String, dynamic> data = {};

  void signup(BuildContext context) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((signedInUser) async {
      data = {
        "email": signedInUser.user!.email,
        "uid": signedInUser.user!.uid,
      };
      await getStorage.write("user", data);
      kUser.value = UserModel.fromJson(data);

      UserManagement().storeNewUser(signedInUser.user, context);
    }).catchError((e) {
      Fluttertoast.showToast(
          msg: "Email or password error, try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.orange,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  void login() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((signedInUser) async {
      data = {
        "email": signedInUser.user!.email,
        "uid": signedInUser.user!.uid,
      };

      // await getStorage.write("user", data);

      kUser.value = UserModel.fromJson(data);

      // Get.offAll(() => const Navigation());
    }).catchError((e) {
      Fluttertoast.showToast(
          msg: "Email or password error, try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.orange,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  void forgetpassword() async {
    // isLoading.value = true;
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await auth.sendPasswordResetEmail(email: emailController.text);

      Fluttertoast.showToast(
          msg: "Email Successfully reseted open email to finish verication'",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.orange,
          textColor: Colors.white,
          fontSize: 16.0);

      // isLoading.value = false;
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Try Again email does not exist',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.orange,
          textColor: Colors.white,
          fontSize: 16.0);

      // isLoading.value = false;
    }
  }

  signOut() {
    // getStorage.erase();
    FirebaseAuth.instance.signOut().then((value) => Get.to(() => LoginPage()));
    // isLoading.value = false;
  }

  delete() async {
    User? currentFirebaseUser = FirebaseAuth.instance.currentUser;
    if (currentFirebaseUser != null) {
      currentFirebaseUser.delete().then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(currentFirebaseUser.uid)
            .delete();
        Get.snackbar('Alert', 'Account has been deleted Succefully');
        Get.offAll(LoginPage());
      });
    }
  }
}
