import 'package:bazaar/core/services/payment/paymob/paymob_constant.dart';
import 'package:bazaar/core/widget/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paymob_egypt/flutter_paymob_egypt.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';

class CheckoutPayment extends StatefulWidget {
  const CheckoutPayment({super.key});

  @override
  State<CheckoutPayment> createState() => _CheckoutPaymentState();
}

class _CheckoutPaymentState extends State<CheckoutPayment> {
  int _selectedPaymentMethod = 0;

  List<Map<String, dynamic>> paymentMethods = [];

  @override
  void initState() {
    super.initState();
    paymentMethods = [
      {
        "title": "Cash on Delivery",
        "svgIcon": AppAssets.imagesIconsWallet,
        "onTap": () {}
      },
      {
        "title": "Paymob",
        "svgIcon": AppAssets.imagesPaymentsPaymob,
        "onTap": () => _paypalPayment() // Wrap in a lambda
      },
      {
        "title": "Stripe",
        "svgIcon": AppAssets.imagesPaymentsStripe,
        "onTap": () => _stripePayment() // Wrap in a lambda
      }
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitleWidget(title: "Payment"),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: List<ListTile>.generate(
                paymentMethods.length,
                (index) => _paymentMethod(
                    title: paymentMethods[index]["title"]!,
                    svgIcon: paymentMethods[index]["svgIcon"]!,
                    value: index,
                    onTap: paymentMethods[index]["onTap"]! // Pass the function
                    )),
          ),
        )
      ],
    );
  }

  ListTile _paymentMethod({
    required String title,
    required String svgIcon,
    required int value,
    required Function onTap, // Change to Function
  }) {
    return ListTile(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = value;
          onTap(); // Call the function here
        });
      },
      leading: Icon(
        _selectedPaymentMethod == value
            ? Icons.check_box_rounded
            : Icons.check_box_outline_blank_rounded,
        color: _selectedPaymentMethod == value
            ? AppColors.primaryColor
            : AppColors.greyColor,
      ),
      title: Text(
        title,
        style: AppTextStyles.style14Normal,
      ),
      trailing: SvgPicture.asset(svgIcon, width: 25, height: 25),
    );
  }

  void _stripePayment() {
    // Implement Stripe payment logic here
  }

  void _paypalPayment() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => FlutterPaymobPayment(
        cardInfo: CardInfo(
          apiKey: PaymobConstant.apiKey,
          iframesID: '886613', // from paymob Select Developers -> iframes
          integrationID:
              '4895792', // from dashboard Select Developers -> Payment Integrations -> Online Card ID
        ),
        totalPrice: 100, // required pay with Egypt currency
        appBar: null, // optional
        loadingIndicator: null, // optional
        billingData: null, // optional => your data
        items: const [], // optional
        successResult: (data) {
          print('successResult: $data');
        },
        errorResult: (error) {
          print('errorResult: $error');
        },
      ),
    ));
  }
}
