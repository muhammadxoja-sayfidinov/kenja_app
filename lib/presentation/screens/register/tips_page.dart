import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/presentation/widgets/next_bottom.dart';
import 'package:kenja_app/presentation/widgets/skip_bottom.dart';

import '../../state_management/tips_provider.dart';
import '../../widgets/register/tips_carousel.dart';
import '../mainHome.dart';
import 'login_page.dart';

class TipsScreen extends ConsumerStatefulWidget {
  @override
  _TipsScreenState createState() => _TipsScreenState();
}

class _TipsScreenState extends ConsumerState<TipsScreen> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final pageController = ref.watch(tipsPageControllerProvider);

    return SafeArea(
      child: Scaffold(
        // backgroundColor: mainDarkColor,
        body: Column(
          children: [
            Expanded(
              child: TipsCarousel(
                pageController: pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  MyNextBottom(
                    onTap: () {
                      if (pageController.page! < 2) {
                        pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease);
                      }
                      if (currentPage == 2) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      }
                    },
                    text: 'Davom etish',
                  ),
                  currentPage < 2
                      ? MySkipBottom(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainHome()));
                          },
                        )
                      : SizedBox(
                          width: 339.w,
                          height: 44.h,
                        )
                ],
              ),
            ),
            24.verticalSpace,
          ],
        ),
      ),
    );
  }
}
