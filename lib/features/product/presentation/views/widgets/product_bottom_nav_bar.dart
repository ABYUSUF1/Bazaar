// import 'package:flutter/material.dart';

// import '../../../../../core/widget/add_to_cart_button.dart';
// import '../../../../../core/widget/favorite_button.dart';
// import '../../../../../core/widget/quantity_button.dart';

// class ProductBottomNavBar extends StatelessWidget {
//   const ProductBottomNavBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return  Padding(
//             padding: const EdgeInsets.only(right: 12.0, left: 12.0, bottom: 24.0),
//             child: Row(
//               children: [
//                 _cartPart(),
//                 const SizedBox(width: 10),
//                 const FavoriteButton()
//               ],
//             ),
//           );
//   }
//   Row _cartPart() 
  
// {return
//   const Row(
//     children: [
//                 QuantityButton(),
//                 SizedBox(width: 10),
//                 Expanded(
//                     child: AddToCartButton(
//                   userId: null,
//                   productId: null,
//                   quantity: null,
//                 )),
//   ]);
// }
// }