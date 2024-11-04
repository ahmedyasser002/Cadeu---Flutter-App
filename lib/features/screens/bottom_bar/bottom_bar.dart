import 'package:demo_project/constants/app_colors.dart';
import 'package:demo_project/constants/app_icons.dart';
import 'package:demo_project/constants/app_text_style.dart';
import 'package:demo_project/features/screens/account/account_screen.dart';
import 'package:demo_project/features/screens/occasions/occasions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      OccasionsScreen(),
      const AccountScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppIcons.activeOcassions ,),
            Text('Occasions' , style: AppTextStyle.jost500(AppColors.bottomBarOrange, 9),)
          ],
        ),
        inactiveIcon: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppIcons.ocassions),
            Text('Occasions' , style: AppTextStyle.jost500(AppColors.black, 9),) 
      
          ],
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppIcons.activeAccount),
            Text('Account' , style: AppTextStyle.jost500(AppColors.bottomBarOrange, 9),)
          ],
        ),
        inactiveIcon: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppIcons.account),
            Text('Account' , style: AppTextStyle.jost500(AppColors.black, 9),)
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return  PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarItems(),
        backgroundColor: const Color(0xFFFFFFFF),
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
  
        navBarStyle: NavBarStyle
            .style12, 
    );
  }
}
