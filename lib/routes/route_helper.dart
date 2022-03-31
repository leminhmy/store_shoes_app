import 'package:get/get.dart';
import 'package:store_shoes_app/screens/detail_page/detail_page.dart';
import 'package:store_shoes_app/screens/home_page/main_home_page.dart';

import '../screens/auth/sign_in_page.dart';
import '../screens/cart_page/cart_page.dart';
import '../screens/home_page/components/home_page.dart';
class RouteHelper{
  static const String initial = "/";
  static const String shoesDetail = '/shoes-detail';
  static const String leatherShoes ='/leather-shoes';
  static const String cartPage = '/cart-page';
  static const String signIn = '/sign-in';

  static getInitial()=>'$initial';
  static String getShoesDetail(int pageId, String page)=>'$shoesDetail?pageId=$pageId&page=$page';
  static getLeatherShoes() =>'$leatherShoes';
  static String getCartPage()=> '$cartPage';
  static String getSignInPage()=> '$signIn';

  static List<GetPage> routes =[
    GetPage(name: initial, page: ()=>MainHomePage()),
    GetPage(name: signIn, page: ()=>SignInPage(),transition: Transition.fade),
    GetPage(name: shoesDetail, page: (){
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters["page"];
      return DetailPage(pageId: int.parse(pageId!), page: page!,);
    },
        transition: Transition.fadeIn
    ),
    GetPage(name: cartPage, page: (){
      return CartPage();
    },
      transition: Transition.fadeIn,
    ),
  ];
}