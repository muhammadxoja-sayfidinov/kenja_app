import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'card_payment_screen.dart';

class PaymentMethodsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: mainDarkColor,
        elevation: 0,
        title: Text('To\'lov usullari', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            _buildPaymentMethodTile(
              context,
              logoPath:
                  'assets/images/click.png', // Click logotipi uchun rasm yo'li
              title: 'Click orqali to\'lash',
              subtitle: 'Click orqali to\'lash',
              onTap: () {
                // Click to'lov usuli tanlandi
              },
            ),
            SizedBox(height: 10.h),
            _buildPaymentMethodTile(
              context,
              logoPath:
                  'assets/images/payme.png', // Payme logotipi uchun rasm yo'li
              title: 'Payme orqali to\'lash',
              subtitle: 'Payme orqali to\'lash',
              onTap: () {
                // Payme to'lov usuli tanlandi
              },
            ),
            SizedBox(height: 10.h),
            _buildPaymentMethodTile(
              context,
              logoPath:
                  'assets/images/paypal.png', // PayPal logotipi uchun rasm yo'li
              title: 'Paypal orqali to\'lash',
              subtitle: 'Paypal orqali to\'lash',
              onTap: () {
                // PayPal to'lov usuli tanlandi
              },
            ),
            SizedBox(height: 10.h),
            _buildPaymentMethodTile(
              context,
              logoPath: '', // Karta logotipi uchun rasm yo'li
              title: 'Karta orqali to\'lash',
              subtitle: 'Karta raqami orqali to\'lash',

              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  // backgroundColor: mainDarkColor,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: CardPaymentBottomSheet(),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodTile(
    BuildContext context, {
    String logoPath = '',
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        decoration: BoxDecoration(
          // color: darkColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            logoPath.isNotEmpty
                ? Image.asset(logoPath, width: 50.w, height: 50.h)
                : SizedBox(), // Logotip tasviri
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.white70, fontSize: 14.sp),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
