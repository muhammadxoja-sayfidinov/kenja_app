import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/core/constants/styles.dart';
import 'package:kenja_app/presentation/widgets/next_bottom.dart';
import 'package:kenja_app/presentation/widgets/next_bottom_white.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/images/Success.png',
                  width: 220.w,
                ),
                SizedBox(height: 24.h),
                Text(
                  'Tabriklaymiz, siz birinchi mashqni muvaffaqiyatli tugatdingiz',
                  style: CustomTextStyle.style500,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.h),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    // Light background color like in the image
                    borderRadius: BorderRadius.circular(20),
                  ),
                  // Rounded corners
                  child: Row(
                    children: [
                      _buildDetailCard('1s 30min', 'Vaqt'),
                      const VerticalDivider(
                        color: Colors.grey,
                        // Divider color
                        thickness: 1,
                        // Divider thickness
                        width: 20,

                        // Space around the divider
                        indent: 10,
                        // Top padding for the divider
                        endIndent: 10, // Bottom padding for the divider
                      ),
                      _buildDetailCard('50', 'Kkal'),
                      const VerticalDivider(
                        color: Colors.grey,
                        // Divider color
                        thickness: 1,
                        // Divider thickness
                        width: 20,
                        // Space around the divider
                        indent: 10,
                        // Top padding for the divider
                        endIndent: 10, // Bottom padding for the divider
                      ),
                      _buildDetailCard('3L', 'Suv ichish'),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 25.h),
              child: isDark
                  ? MyNextBottomWhite(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      text: 'Asosiyga qaytish')
                  : MyNextBottom(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      text: 'Asosiyga qaytish'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard(String value, String unit) {
    return Container(
      width: 104.w,
      height: 60.h,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(value, style: CustomTextStyle.style600),
          Text(unit, style: CustomTextStyle.style400),
        ],
      ),
    );
  }
}
