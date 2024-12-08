import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/cart/presentation/manager/cart/cart_cubit.dart';
import '../utils/models/products_details_model/product.dart';

class QuantityButton extends StatelessWidget {
  final Product product;

  const QuantityButton({
    super.key,
    required this.product, // Pass the product instance
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        // Read the current quantity from the product model
        int currentQuantity = product.quantity ?? 1;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300), // Border color
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: DropdownButton<int>(
            value: currentQuantity,
            focusColor: Colors.transparent,
            icon: Icon(
              Icons.arrow_drop_down,
              color: Colors.grey.shade400,
            ),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            underline: const SizedBox.shrink(),
            onChanged: (int? newValue) {
              if (newValue != null) {
                // Update the product's quantity and notify the CartCubit
                context.read<CartCubit>().updateQuantity(product, newValue);
              }
            },
            items: List.generate(10, (index) => index + 1) // Quantities 1 to 10
                .map<DropdownMenuItem<int>>((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text(value.toString()),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
