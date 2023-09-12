import 'package:get/get.dart';

class Dimension {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  static double pageView = screenHeight / 2.64;
  static double pageViewContainer = screenHeight / 3.84;
  static double pageViewTextContainer = screenHeight / 7.03;

  // height
  static double height10 = screenHeight /
      84.4; // 844 is constant number where 844 is divided by any using number for exam here i take 10 so 844/10 is 84.4 so here i write 84.4
  static double height20 =
      screenHeight / 42.2; // we divided 844/20 and get 42.2
  static double height15 = screenHeight /
      56.27; // we divided 844/15 and get 56.27 where 844 is constant num for screen size divder
  static double height30 = screenHeight / 28.13;
  static double height45 = screenHeight / 18.76;

  // width
  static double width5 = screenHeight / 168.8;
  static double width10 = screenHeight / 84.4;
  static double width15 = screenHeight / 56.27;
  static double width20 = screenHeight / 42.2;
  static double width30 = screenHeight / 28.13;

  // font size
  static double font20 = screenHeight / 42.2;
  static double font16 = screenHeight / 52.75;
  static double font26 = screenHeight / 32.46;

  //radius
  static double radius15 = screenHeight / 56.27;
  static double radius20 = screenHeight / 42.2;
  static double radius30 = screenHeight / 28.13;
  static double radius40 = screenHeight / 41.1;

  //icon Size
  static double iconSize24 = screenHeight / 35.17;
  static double iconSize16 = screenHeight / 52.75;

  // List view size
  static double listViewImgSiz = screenWidth / 3.25;
  static double listViewTextSiz = screenWidth / 3.9;

  // food details orr popularaafoodaimgSize
  static double popularFoodImgSize = screenHeight / 2.41;

  // bottom height
  static double bottomHeightBar = screenHeight / 7.03;
}
