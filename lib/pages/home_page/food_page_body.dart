import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/pages/food/recommended_food_detail.dart';
import 'package:food_ordering_app/pages/models/Data/food_list.dart';
import 'package:food_ordering_app/pages/models/food.dart';
import 'package:food_ordering_app/resources/dimension.dart';
import 'package:food_ordering_app/widgets/big_text.dart';
import 'package:food_ordering_app/widgets/icon_and_text_widget.dart';
import 'package:food_ordering_app/widgets/small_text.dart';
import '../../widgets/app_column.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  // int _selectedIndex = 0;
  List<Widget> Pages = [
    // MainFoodPage(),
    Container(
      child: const Center(
        child: Text("Next page1"),
      ),
    ),
    Container(
      child: const Center(
        child: Text("Next page2"),
      ),
    ),
    Container(
      child: const Center(
        child: Text("Next page3"),
      ),
    ),
  ];
  // Widget _buildPageItem(int index) {
  //   switch (index) {
  //     case 0:
  //     // Return the content for the first page
  //     // return Container(
  //     //   width: Dimension.listViewImgSiz,
  //     //   height: Dimension.listViewImgSiz,
  //     //   decoration: BoxDecoration(
  //     //       borderRadius: BorderRadius.circular(Dimension.radius20),
  //     //       image: const DecorationImage(
  //     //         fit: BoxFit.cover,
  //     //         image: AssetImage("assets/images/Chicken_Chowmein.jpg"),
  //     //       )),

  //     // );
  //     case 1:
  //       // Return the content for the second page
  //       return Container(
  //         // Customize the content for the second page
  //         child: Center(
  //           child: Text("Next page2"),
  //         ),
  //       );
  //     case 2:
  //       // Return the content for the third page
  //       return Container(
  //         // Customize the content for the third page
  //         child: Center(
  //           child: Text("Next page3"),
  //         ),
  //       );
  //     // Add cases for the remaining pages
  //     // Customize the content for each page based on the index
  //     default:
  //       return Container();
  //   }
  // }

  void onTapNav(int index) {
    setState(() {
      // _selectedIndex = index;
    });
  }

  PageController pageController = PageController(viewportFraction: 0.85);

  // page controller helps us to show or make visible  is there is next page or not.
  var _currPageValue = 0.0;
  // double _scaleFactor = 0.8;
  // double _height = Dimension.pageViewContainer;
  List<Food> listPage = foodList;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue =
            pageController.page!; // it helps to know current page value
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose(); // it hleps in the memory management
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //slider section
        SizedBox(
          height: Dimension.pageView,
          child: PageView.builder(
              controller: pageController,
              itemCount: 5,
              itemBuilder: (context, position) {
                _currPageValue = position.toDouble();
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RecommenededFoodDetail(
                          food: foodList[position],
                        ),
                      ),
                    );
                  },
                  child: _buildPageItem(position, foodList[position]),
                );
              }),
        ),
        //dots section
        DotsIndicator(
          dotsCount: 5,
          position: _currPageValue,
          decorator: DotsDecorator(
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),

        SizedBox(
          height: Dimension.height30,
        ),
        Container(
          margin: EdgeInsets.only(
            left: Dimension.width30,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(
                text: "Popular",
                // String: null,
              ),
              SizedBox(
                width: Dimension.width10,
              ),
              Container(
                margin: const EdgeInsets.only(
                  bottom: 3,
                ),
                child: BigText(
                  text: ".",
                  color: Colors.black,
                  // String: null,
                ),
              ),
              SizedBox(
                width: Dimension.width10,
              ),
              Container(
                margin: const EdgeInsets.only(
                  bottom: 2,
                ),
                child: SmallText(
                  text: "Food Items",
                ),
              )
            ],
          ),
        ),
        // list of Foods and images
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount:
                foodList.length, // itembuilder index is connected to itemCount
            itemBuilder: (context, index) {
              // here we return a function and the form of function we return here container widget or we can say function that reutn widget
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          RecommenededFoodDetail(food: foodList[index]),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(
                    left: Dimension.width20,
                    right: Dimension.width20,
                    bottom: Dimension.height10,
                  ),
                  child: Row(
                    children: [
                      // image section
                      Container(
                        width: Dimension.listViewImgSiz,
                        height: Dimension.listViewImgSiz,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimension.radius20),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(foodList[index].image),
                            )),
                      ),
                      // text section
                      Expanded(
                        child: Container(
                          height: Dimension.listViewTextSiz,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(Dimension.radius20),
                              bottomRight: Radius.circular(Dimension.radius20),
                            ),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: Dimension.width10,
                              right: Dimension.width10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BigText(
                                  text: foodList[index].title,
                                  // String: null,
                                ),
                                SizedBox(
                                  height: Dimension.height10,
                                ),
                                SmallText(
                                  text: foodList[index].detail,
                                ),
                                SizedBox(
                                  height: Dimension.height10,
                                ),
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    IconAndText(
                                      icon: Icons.circle_sharp,
                                      // iconColor: AppColors.blackColor,
                                      text: "Normal",
                                    ),
                                    IconAndText(
                                      icon: Icons.location_on,
                                      // iconColor: AppColors.colorRose,
                                      text: "1.7km",
                                    ),
                                    IconAndText(
                                      icon: Icons.access_time_rounded,
                                      // iconColor: AppColors.blackColor,
                                      text: "32min",
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            })
      ],
    );
  }
}

Widget _buildPageItem(int index, Food food) {
  Matrix4 matrix = Matrix4.identity();
  // var _currPageValue = 0.0;
  // double _scaleFactor = 0.8;
  // double _height = 220;
  // double currTrans = 0.0;
  // double currScale = 0.8;

  // if (index == _currPageValue.floor()) {
  //   var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
  //   var currTrans = _height * (1 - currScale) / 2;
  //   matrix = Matrix4.diagonal3Values(1, currScale, 1)
  //     ..setTranslationRaw(0, currTrans, 0);
  // } else if (index == _currPageValue.floor() + 1) {
  //   var currScale =
  //       _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
  //   matrix = Matrix4.diagonal3Values(1, currScale, 1);
  //   var currTrans = _height * (1 - currScale) / 2;
  //   matrix = Matrix4.diagonal3Values(1, currScale, 1)
  //     ..setTranslationRaw(0, currTrans, 0);
  // } else if (index == _currPageValue.floor() - 1) {
  //   var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
  //   matrix = Matrix4.diagonal3Values(1, currScale, 1);
  //   matrix = Matrix4.diagonal3Values(1, currScale, 1)
  //     ..setTranslationRaw(0, currTrans, 0);
  // } else {
  //   var currScale = 0.8;
  //   matrix = Matrix4.diagonal3Values(1, currScale, 1)
  //     ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
  // }

  return Transform(
    transform: matrix,
    child: Stack(
      children: [
        Container(
          height: Dimension.pageViewContainer,
          margin: EdgeInsets.only(
              left: Dimension.width10, right: Dimension.width10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                Dimension.radius20,
              ),
              color: index.isEven
                  ? const Color(0xff6C72C0)
                  : const Color(0xff6067C9),
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(food.image))),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: Dimension.pageViewTextContainer,
            margin: const EdgeInsets.only(
              left: 30,
              right: 30,
              bottom: 30,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                Dimension.radius30,
              ),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                    color: Color(0Xffe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(0, 5)),
                BoxShadow(
                    color: Colors.white,
                    // blurRadius: 5.0,
                    offset: Offset(-5, 0)),
                BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
              ],
            ),
            child: Container(
              padding: EdgeInsets.only(
                top: Dimension.height15,
                left: Dimension.width15,
                right: Dimension.width15,
              ),
              child: AppColumn(
                text: food.title,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
