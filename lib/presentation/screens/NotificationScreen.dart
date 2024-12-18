import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/core/constants/colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark ? mainDarkColor : white,
        title: const Text('Bildirishnomalar'),
      ),
      body: Column(
        children: [
          24.verticalSpace,
          _buildCard(isDark: isDark),
          const SizedBox(height: 20),
          _buildCard(shadow: true, isDark: isDark),
        ],
      ),
    );
  }

  Widget _buildCard({bool shadow = false, required bool isDark}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? darkColor : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: shadow
            ? [
                const BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                )
              ]
            : [],
        border: shadow
            ? null
            : Border.all(
                color: Colors.grey.shade300,
                width: 1,
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          SizedBox(height: 16),
          Text(
            "Ilovamiz 1.0 beta versiyada ishga tushurildi",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : mainDarkColor,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Mana bir necha yildirki, insoniyat COVID-19 pandemiyasi sharoitida yashamoqda...",
            style: TextStyle(
              fontSize: 14,
              color: isDark ? Colors.white : darkColor,
            ),
          ),
          SizedBox(height: 8),
          Align(
            alignment: Alignment.bottomRight,
            child: Icon(
              Icons.circle,
              color: Colors.redAccent,
              size: 12,
            ),
          ),
        ],
      ),
    );
  }
}
