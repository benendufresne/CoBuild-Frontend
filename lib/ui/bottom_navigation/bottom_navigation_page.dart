import 'package:cobuild/bloc/controller/app_controller/app_bloc.dart';
import 'package:cobuild/bloc/controller/app_controller/app_event.dart';
import 'package:cobuild/bloc/controller/bottom_navigation_bloc/bottom_navigation_controller.dart';
import 'package:cobuild/global/version_management/verion_management.dart';
import 'package:cobuild/ui/bottom_navigation/custom_bottom_nav.dart';
import 'package:cobuild/ui/home_page/home_page.dart';
import 'package:cobuild/ui/my_profile/my_profile.dart';
import 'package:cobuild/ui/notifications/notifications_listing.dart';
import 'package:cobuild/ui/report_damage/reported_damages_list.dart';
import 'package:cobuild/utils/app_helpers/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Landing page of After login/signup
class BottomNavigationPage extends StatefulWidget {
  final int initialIndex;
  const BottomNavigationPage({super.key, this.initialIndex = 0});

  @override
  State<StatefulWidget> createState() => BottomNavigationPageState();
}

class BottomNavigationPageState extends State<BottomNavigationPage>
    with TickerProviderStateMixin {
  late BottomNavigationController controller;
  late AppController appController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final DeBouncer deBouncer = DeBouncer(milliseconds: 300);
  bool checkingLocation = false;
  final List<Widget> _pages = const [
    HomePage(),
    ReportedDamangeList(),
    NotificationsScreen(),
    MyProfilePage()
  ];

  @override
  void initState() {
    super.initState();
    controller = context.read<BottomNavigationController>();
    controller.tabController = TabController(
        length: _pages.length, vsync: this, initialIndex: widget.initialIndex);
    appController = context.read<AppController>();
    _getUserProfile();
    VersionManagement().checkAppVersion();
  }

  void _getUserProfile() {
    appController.add(GetUserProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: controller.state.store.currentBottomNavPage,
        builder: (context, value, widget) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Scaffold(
              key: _scaffoldKey,
              bottomNavigationBar: const CustomBottomNav(),
              body: _pages[controller.state.store.currentBottomNavPage.value],
            ),
          );
        });
  }
}
