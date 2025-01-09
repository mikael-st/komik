import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:komik/assets/palette.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Palette.details, width: 2))),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            labelTextStyle: WidgetStateProperty.all(
              TextStyle(
                color: Palette.white,
                fontSize: 12,
              )
            )
          ),
          child: NavigationBar(
          onDestinationSelected: (value) {
            print(value);
          },
          destinations: [
            NavigationDestination(
              icon: HeroIcon(
                HeroIcons.bookmarkSquare,
                style: HeroIconStyle.solid,
                size: 24,
                color: Palette.white,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: HeroIcon(
                HeroIcons.folder,
                style: HeroIconStyle.solid,
                size: 24,
                color: Palette.white,
              ),
              label: 'Collections',
            ),
            NavigationDestination(
              icon: HeroIcon(
                HeroIcons.clock,
                size: 24,
                color: Palette.white,
              ),
              label: 'Reading',
            ),
          ],
          selectedIndex: 0,
          backgroundColor: Palette.items,
          indicatorColor: Palette.transparent,
        )),
      );
  }
}