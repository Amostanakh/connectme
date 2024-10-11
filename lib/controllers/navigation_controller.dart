import 'package:get/get.dart';

class NavigationController extends GetxController {
  RxInt selectedAthoursPage = 0.obs;
  RxInt selectedPage = 0.obs;

  void changePageAuthors(int authorsPageindex) {
    selectedAthoursPage.value = authorsPageindex;
  }

  void changePage(int index) {
    selectedPage.value = index;
  }
}
