import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/core/constants/colors.dart';
import 'package:kenja_app/core/constants/styles.dart';
import 'package:kenja_app/presentation/screens/payment_methods_screen.dart';
import 'package:kenja_app/presentation/widgets/next_bottom.dart';

class SubscriptionScreen extends StatefulWidget {
  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  String selectedPlan = 'yearly'; // 'yearly' or 'monthly'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainDarkColor,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/SubscriptionScreen.png',
            fit: BoxFit.cover,
            width: 375.w,
            height: 371.h,
          ),
          Padding(
            padding: EdgeInsets.all(18.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                195.verticalSpace,
                Text("Sog'lom turmush tarziga e'tibor o'zingizga e'tibor",
                    style: CustomTextStyle.style700.copyWith(fontSize: 27.sp)),
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
                const Spacer(),
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
        Icon(icon, color: Colors.white, size: 20.w),
        SizedBox(width: 10.w),
        Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 16.sp),
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
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPlan = value;
        });
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected ? darkError : mainDarkColor,
          borderRadius: BorderRadius.circular(12.r),
          border: isSelected ? Border.all(color: Colors.red, width: 2.w) : null,
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                    ),
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
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.sp),
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
                        style: TextStyle(color: Colors.white, fontSize: 12.sp),
                      ),
                    ),
                  ),
              ],
            ),
            Spacer(),
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
