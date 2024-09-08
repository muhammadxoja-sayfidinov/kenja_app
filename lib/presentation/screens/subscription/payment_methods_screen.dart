import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import 'card_payment_screen.dart';

class PaymentMethodsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark ? backgroundDarker : darker,
        elevation: 0,
        title: Text(
          'To\'lov usullari',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            _buildPaymentMethodTile(
              context,
              logoPath: 'assets/images/click.png',
              // Click logotipi uchun rasm yo'li
              title: 'Click orqali to\'lash',
              subtitle: 'Click orqali to\'lash',
              onTap: () {
                // Click to'lov usuli tanlandi
              },
              isDark: isDark,
            ),
            SizedBox(height: 10.h),
            _buildPaymentMethodTile(
              context,
              logoPath: 'assets/images/payme.png',
              // Payme logotipi uchun rasm yo'li
              title: 'Payme orqali to\'lash',
              subtitle: 'Payme orqali to\'lash',
              onTap: () {
                // Payme to'lov usuli tanlandi
              },
              isDark: isDark,
            ),
            SizedBox(height: 10.h),
            _buildPaymentMethodTile(
              context,
              logoPath: 'assets/images/paypal.png',
              // PayPal logotipi uchun rasm yo'li
              title: 'Paypal orqali to\'lash',
              subtitle: 'Paypal orqali to\'lash',
              onTap: () {
                // PayPal to'lov usuli tanlandi
              },
              isDark: isDark,
            ),
            SizedBox(height: 10.h),
            _buildPaymentMethodTile(
              context,
              logoPath: '',
              // Karta logotipi uchun rasm yo'li
              title: 'Karta orqali to\'lash',
              subtitle: 'Karta raqami orqali to\'lash',

              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: isDark ? backgroundDarker : darker,
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
              isDark: isDark,
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
    required bool isDark,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: isDark ? backgroundDarker : darker,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            logoPath.isNotEmpty
                ? Image.asset(logoPath, width: 50.w, height: 50.h)
                : const SizedBox(), // Logotip tasviri
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
            ),
          ],
        ),
      ),
    );
  }
}
