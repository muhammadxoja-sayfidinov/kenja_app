import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/core/constants/styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/constants/colors.dart';

class TipsCarousel extends StatefulWidget {
  final PageController pageController;
  final Function(int) onPageChanged;

  TipsCarousel({required this.pageController, required this.onPageChanged});

  @override
  _TipsCarouselState createState() => _TipsCarouselState();
}

class _TipsCarouselState extends State<TipsCarousel> {
  @override
  void initState() {
    super.initState();
    widget.pageController.addListener(() {
      widget.onPageChanged(widget.pageController.page!.round());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: widget.pageController,
            children: [
              _buildTipPage(
                  'Mashg\'ulotlarni bajarish endi esingizdan chiqmaydi. Natijalarga erishish biz bilan juda oson',
                  'assets/images/tip1.png'),
              _buildTipPage(
                  'Semizlikdan qutulish biz bilan yana ham oson. Shunchaki, ilovada maqsadingizni aniq qo\'ying va bajaring',
                  'assets/images/tip2.png'),
              _buildTipPage(
                  'Mushaklarni chiqarish va ko\'rkam ko\'rinishga ega bo\'lish uchun foydalanishda davom eting',
                  'assets/images/tip3.png'),
            ],
          ),
        ),
        16.verticalSpace,
        SmoothPageIndicator(
          controller: widget.pageController,
          count: 3,
          effect: WormEffect(
            dotWidth: 10,
            dotHeight: 10,
            activeDotColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : mainDarkColor,
            dotColor: Colors.grey,
          ),
        ),
        16.verticalSpace
      ],
    );
  }

  Widget _buildTipPage(String text, String imagePath) {
    return Column(
      children: [
        60.verticalSpace,
        ClipRRect(
          borderRadius: BorderRadius.circular(32.r),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            width: 339.w,
            height: 339.w,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: CustomTextStyle.style700,
          ),
        ),
      ],
    );
  }
}
