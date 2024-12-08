import 'package:flutter_dotenv/flutter_dotenv.dart';

class PaymobConstant {
  static String apiKey = dotenv.env['PAYMOB_API_KEY']!;
  static String secretKey = dotenv.env['PAYMOB_SECRET_KEY']!;
}
