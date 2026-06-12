import 'package:carlanda_car_buy_sell/core/common/widgets/custom_appbar.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/to_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({super.key});
  static const String routeName = "/profile/terms-and-condition";

  final String termsText = '''
About CarLanda
Effective Date: 04/21/2025
Welcome to CarLanda. By signing up and using our mobile application and services (collectively, the “App”), you agree to the following Terms and Conditions (“Terms”). Please read them carefully.

User Eligibility
You must be 18 years or older and provide accurate information when registering or making a purchase.

Vehicle Purchase
All vehicle listings are added and maintained by CarLanda. Prices shown include base cost; delivery options may affect the final price.

Payment & Proof
Payments must be made via approved methods (bank transfer or in-person). Proof of payment must be submitted to process the order.

Contract Agreement
Upon payment confirmation, a purchase contract is automatically generated and signed digitally.

Delivery & Tracking
Once the vehicle is in transit, users will receive tracking details. Delivery times may vary due to customs and logistics.

Cancellations & Refunds
Orders are final once payment is confirmed. Cancellations are not accepted after contract generation.

Liability
Contact Us
For questions or concerns, contact:
support@carlanda.com
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: "Terms & Condition"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.w),
            margin: EdgeInsets.only(bottom: 50.h, top: 16.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.w),
            ),
            child: Text(
              termsText,
              style: GoogleFonts.roboto(
                fontSize: 14.sp,
                color: "#444952".toColor(),
                fontWeight: FontWeight.w400,
                height: 1.6,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
