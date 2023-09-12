import 'package:flutter/material.dart';
import 'package:food_ordering_app/resources/color_manager.dart';
import 'package:food_ordering_app/resources/dimension.dart';
import 'package:food_ordering_app/resources/routes_manager.dart';
import 'package:food_ordering_app/widgets/app_icon.dart';
import 'package:food_ordering_app/widgets/big_text.dart';
import 'package:food_ordering_app/widgets/small_text.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({super.key});

  @override
  Widget build(BuildContext context) {
    //var getCartHistoryList= Get.find<cartController>().getCartHistoryList().reversed;
    // Map<String,int> cartItemsPerOrder=Map();

    //   for(int i=0; i<getCartHistoryList.lenght;i++){
    //     if(cartItemsPerOrder.containsKey(getCartHistoryList[i]["time"])){
    //       cartItemsPerOrder.update(getCartHistoryList[i]["time"],(value)=>++value);

    //     }else{
    //       cartItemsPerOrder.putIfAbsent(getCartHistory[i]['time'],()=>1);
    //     }
    //   }

    //   List<int>cartItemsPerOrderToList(){
    //     return cartItemsPerOrder.entries.map((e)=>e.value).toList();
    //   }

    //  List<String>cartOrderTimeToList(){
    //     return cartItemsPerOrder.entries.map((e)=>e.key).toList();
    //   }

    //   List<int> itemPerOrder =cartItemsPerOrderToList();

    //   var listCounter=0;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Dimension.height10 * 10,
            color: AppColors.orange,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Dimension.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(
                  text: "Cart History", color: Colors.white,
                  // String: String
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.cartPage);
                  },
                  child: const AppIcon(
                      icon: Icons.shopping_cart_checkout_outlined,
                      background: AppColors.orange),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
                margin: EdgeInsets.only(
                  top: Dimension.height20,
                  left: Dimension.width20,
                  right: Dimension.width20,
                ),
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView(
                    children: [
                      // for (int i = 0; i < itemsPerOrder.length; i++)
                      Container(
                        height: Dimension.height30 * 4,
                        margin: EdgeInsets.only(
                          bottom: Dimension.height20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // BigText(text: getCartHistoryList[listCounter].time!, String: String), // here time chanegs according to order date
                            // instede of line 73 used this
                            // (() {
                            //   DateTime parseDate =
                            //       DateFormate("yyy-MM-dd HH:mm:ss").parse(
                            //           text: getCartHistoryList[listCounter]
                            //               .time!);
                            //   var inputData= DateTime.parse(parseDate.toString())                              var outputFormate =
                            //    var outputFormate = DateFormate("MM/dd/yyy hh:mm a");
                            //   var outputDate= outputFormate.formate(inputDate);
                            //   return BigText(text: outputDate,);
                            // }()),
                            BigText(
                              text: "05/02/2023",
                              //  String: String
                            ),
                            SizedBox(
                              height: Dimension.height10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Wrap(
                                  direction: Axis.horizontal,
                                  children: [
                                    // List.generate(itemsPerorder[i], (index)){
                                    // if (listCounter<getCartHistoryList.lenght){
                                    // listCounter++;
                                    // }
                                    //   return index<=2?Container(
                                    // height:Dimension.height40*2,
                                    // width: Dimension.width20*4,
                                    // margin:EdgeInsets.only(righ:Dimension.width10/2)
                                    // decoration: BoxDecoration(
                                    // BorderRadius.circular(Dimension.radius15/2),
                                    // fit:BoxFit.cover,
                                    // image:DecorationImage(
                                    // image: NetworkImage(
                                    // AppConstants.BASE_URL+AppConstants.UPLOAD_URL+getCartHistoryList[listCounter-1].img!)))
                                    //   ): Container();
                                    // }

                                    Text(
                                        "here need to be image which is dynamic"),
                                  ],
                                ),
                                SizedBox(
                                  height: Dimension.height20 * 4,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SmallText(text: "Total"),
                                      // BigText(text: itemsPerOrder[i].toString(), String: String),
                                      BigText(
                                        text: "items",
                                        //  String: String
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // var orderTime = cartOrderTimeToList();
                                          // Print("Order Time" +
                                          //     orderTime[i].toString());
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Dimension.width10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimension.radius15 / 3),
                                              border: Border.all(
                                                  width: 1,
                                                  color: AppColors.colorBlue)),
                                          child: SmallText(
                                            text: "One more",
                                            color: AppColors.colorBlue,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}
