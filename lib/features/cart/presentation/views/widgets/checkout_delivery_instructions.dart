import 'package:bazaar/core/utils/app_colors.dart';
import 'package:bazaar/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widget/title_widget.dart';

class CheckoutDeliveryInstructions extends StatefulWidget {
  const CheckoutDeliveryInstructions({super.key});

  @override
  State<CheckoutDeliveryInstructions> createState() =>
      _CheckoutDeliveryInstructionsState();
}

class _CheckoutDeliveryInstructionsState
    extends State<CheckoutDeliveryInstructions> {
  int _selectedInstructionIndex = 0;

  final List<String> _deliveryInstructions = [
    LocaleKeys.cart_hand_it_directly_to_me.tr(),
    LocaleKeys.cart_leave_it_at_the_door.tr(),
    LocaleKeys.cart_pick_it_from_store.tr(),
  ];

  void _selectInstruction(int index) {
    setState(() {
      _selectedInstructionIndex = index;
    });
  }

  void _addCustomInstruction() {
    // Implement logic to add a custom instruction, e.g., using a text field or dialog
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleWidget(title: LocaleKeys.cart_delivery_instructions.tr()),
        SizedBox(
          height: 70,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _deliveryInstructions.length,
            itemBuilder: (context, index) {
              return Container(
                width: 200,
                height: 50,
                margin: const EdgeInsets.only(right: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: _selectedInstructionIndex == index
                          ? AppColors.primaryColor
                          : AppColors.greyColor,
                      width: _selectedInstructionIndex == index ? 3.0 : 1.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: RadioListTile<int>(
                  value: index,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  activeColor: AppColors.primaryColor,
                  groupValue: _selectedInstructionIndex,
                  title: Text(_deliveryInstructions[index]),
                  onChanged: (value) => _selectInstruction(value!),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
