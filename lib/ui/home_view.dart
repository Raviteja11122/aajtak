import 'package:flutter/material.dart';
import 'package:india_today_task/core/constants/app_colors.dart';
import 'package:india_today_task/core/view_models/home_view_models.dart';
import 'package:india_today_task/ui/keep_alive.dart';
import 'package:line_icons/line_icons.dart';
import 'package:stacked/stacked.dart';

import 'home.dart';
import 'talk_to_an_astrologer.dart';

class HomeView extends StatelessWidget {

  HomeView({Key key}): super(key: key);
  final Map<int, dynamic> _tabs = {
    0: const Home(),
    1: const TalkToAstrologer(),
    2: Container(),
    3: Container(),
    4: Container()
  };

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, _) => Scaffold(
        key: model.scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Image.asset("assets/logo.png", width: 50, height: 50),
          centerTitle: true,
          iconTheme: Theme.of(context).iconTheme.copyWith(color: AppColors.iconColor),
          leading: InkWell(
            child: Image.asset("assets/hamburger.png", width: 20, height: 20),
            onTap: () => model.scaffoldKey.currentState.openDrawer(),
          ),
          actions: [
            IconButton(
              icon: const Icon(LineIcons.userCircle, size: 30),
              onPressed: () {}
            )
          ],
        ),
        drawer: const Drawer(),
        bottomNavigationBar: BottomNavigationBar(
          onTap: model.setTabIndex,
          currentIndex: model.tabIndex,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(LineIcons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(LineIcons.comment), label: "Talk to astrologer"),
            BottomNavigationBarItem(icon: Icon(LineIcons.questionCircle), label: "Ask Question"),
            BottomNavigationBarItem(icon: Icon(LineIcons.book), label: "Report"),
            BottomNavigationBarItem(icon: Icon(LineIcons.rocketChat), label: "Chat With Astrolger")
          ]
        ),
        body: _tabs[model.tabIndex],
      ),
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) => model.initialize(),
    );
  }
}
