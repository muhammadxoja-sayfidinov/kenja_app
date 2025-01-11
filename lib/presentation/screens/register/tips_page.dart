import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenja_app/presentation/widgets/next_bottom_white.dart';
import 'package:kenja_app/presentation/widgets/skip_bottom.dart';

import '../../widgets/next_bottom.dart';
import '../../widgets/register/tips_carousel.dart';
import 'login_page.dart';

final tipsPageControllerProvider = Provider<PageController>((ref) {
  return PageController();
});

class TipsScreen extends ConsumerStatefulWidget {
  @override
  _TipsScreenState createState() => _TipsScreenState();
}

class _TipsScreenState extends ConsumerState<TipsScreen> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    final pageController = ref.watch(tipsPageControllerProvider);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                currentPage == 2 ? 48.verticalSpace : SizedBox(),
                isDark
                    ? MyNextBottomWhite(
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
                                    builder: (context) => const LoginPage()));
                          }
                        },
                        text: 'Davom etish',
                      )
                    : MyNextBottom(
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
                    ? Column(
                        children: [
                          12.verticalSpace,
                          MySkipBottom(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()));
                            },
                          ),
                        ],
                      )
                    : SizedBox()
              ],
            ),
          ),
          24.verticalSpace,
        ],
      ),
    );
  }
}
