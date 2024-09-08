import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/presentation/widgets/next_bottom.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
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
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildDetailCard('1s 30min', 'Vaqt'),
                    _buildDetailCard('50', 'Kkal'),
                    _buildDetailCard('3L', 'Suv ichish'),
                  ],
                ),
                SizedBox(height: 24.h),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 25.h),
              child: MyNextBottom(onTap: () {}, text: 'Asosiyga qaytish'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard(String value, String unit) {
    return Container(
      width: 100.w,
      height: 60.h,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        // color: darkColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            unit,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
