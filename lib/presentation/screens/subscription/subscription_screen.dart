import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/core/constants/styles.dart';
import 'package:kenja_app/presentation/screens/subscription/payment_methods_screen.dart';
import 'package:kenja_app/presentation/widgets/next_bottom.dart';

import '../../../core/constants/colors.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  String selectedPlan = 'yearly'; // 'yearly' or 'monthly

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: const Alignment(0, -1.3),
        children: [
          Image.asset(
            'assets/images/SubscriptionScreen.png',
            width: 375.w,
            height: 375.h,
          ),
          Padding(
            padding: EdgeInsets.all(18.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                185.verticalSpace,
                Text("Sog'lom turmush tarziga\n e'tibor o'zingizga e'tibor",
                    style: CustomTextStyle.style700.copyWith(fontSize: 25.sp)),
                SizedBox(height: 20.h),
                _buildFeatureRow(Icons.check, "Barcha mashqlarni ko'rish"),
                SizedBox(height: 10.h),
                _buildFeatureRow(
                    Icons.check, "Maxsus ishlab chiqilgan taomnoma"),
                SizedBox(height: 10.h),
                _buildFeatureRow(Icons.check, "Statistikani ko'rib borish"),
                SizedBox(height: 20.h),
                _buildSubscriptionOption(
                  context,
                  title: 'Yillik sotib olish',
                  price: '\$39.99/yiliga',
                  discountText: 'Save 90%',
                  isSelected: selectedPlan == 'yearly',
                  value: 'yearly',
                  bestValue: true,
                ),
                SizedBox(height: 10.h),
                _buildSubscriptionOption(
                  context,
                  title: 'Oylik sotib olish',
                  price: '\$6.99/oyiga',
                  isSelected: selectedPlan == 'monthly',
                  value: 'monthly',
                  bestValue: false,
                ),
                64.verticalSpace,
                Center(
                  child: MyNextBottom(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PaymentMethodsScreen(),
                        ),
                      );
                    },
                    text: 'Sotib olish',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20.w),
        SizedBox(width: 10.w),
        Text(
          text,
          style: TextStyle(fontSize: 16.sp),
        ),
      ],
    );
  }

  Widget _buildSubscriptionOption(
    BuildContext context, {
    required String title,
    required String price,
    String? discountText,
    required bool isSelected,
    required String value,
    required bool bestValue,
  }) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPlan = value;
        });
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isDark
              ? isSelected
                  ? darkError
                  : mainDarkColor
              : isSelected
                  ? Colors.red[100]
                  : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
              color: isDark
                  ? isSelected
                      ? Colors.red
                      : grey
                  : mainDarkColor,
              width: 1.w),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: CustomTextStyle.style500),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    Text(price, style: CustomTextStyle.style400),
                    if (bestValue)
                      Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            'Best Value',
                            style: TextStyle(fontSize: 12.sp),
                          ),
                        ),
                      ),
                  ],
                ),
                if (discountText != null)
                  Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        discountText,
                        style: TextStyle(fontSize: 12.sp),
                      ),
                    ),
                  ),
              ],
            ),
            const Spacer(),
            Radio<String>(
              value: value,
              groupValue: selectedPlan,
              onChanged: (newValue) {
                setState(() {
                  selectedPlan = newValue!;
                });
              },
              activeColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
