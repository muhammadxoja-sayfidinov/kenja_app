import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kenja_app/presentation/screens/meal_screen.dart';
import 'package:kenja_app/presentation/screens/profile/main_profile.dart';
import 'package:kenja_app/presentation/screens/statistics_screen.dart';

import 'exercises/exercises_screen.dart';
import 'home_screen.dart';

class MainHome extends StatefulWidget {
  MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    var body;

    switch (_index) {
      case 0:
        body = const HomeScreen();
        break;
      case 1:
        body = const ExercisesScreen();
        break;
      case 2:
        body = StatisticsScreen();
        break;
      case 3:
        body = const MealScreen();
        break;
      case 4:
        body = ProfileScreen();
        break;
    }
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SizedBox.expand(child: body),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: isDark ? Colors.black : Colors.grey[200],
        selectedItemColor: isDark ? Colors.white : Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: _index,
        onTap: (newIndex) => setState(() => _index = newIndex),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
              color: isDark ? Colors.white : Colors.black,
            ),
            label: 'Asosiy',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/ranking.svg',
              color: isDark ? Colors.white : Colors.black,
            ),
            label: 'Mashqlar',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/status-up.svg',
              color: isDark ? Colors.white : Colors.black,
            ),
            label: 'Statistika',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/Dinner.svg',
              color: isDark ? Colors.white : Colors.black,
            ),
            label: 'Taomlar',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/profile-circle.svg',
              color: isDark ? Colors.white : Colors.black,
            ),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
