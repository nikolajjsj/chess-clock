import 'package:chessclock/screens/custom_screen.dart';
import 'package:chessclock/screens/default_screen.dart';
import 'package:chessclock/screens/settings/settings_screen.dart';
import 'package:chessclock/widgets/FAB/home_fab.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this)
      ..addListener(() => _tabController.previousIndex != _tabController.index
          ? setState(() {})
          : null);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chess Clock'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.of(context).push(SettingsScreen.route()),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: false,
        currentIndex: _tabController.index,
        onTap: (index) => setState(() => _tabController.index = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm_rounded),
            label: 'DEFAULT',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm_add_rounded),
            label: 'CUSTOM',
          ),
        ],
      ),
      floatingActionButton: _tabController.index == 1 ? const HomeFAB() : null,
      body: TabBarView(
        controller: _tabController,
        children: [
          const DefaultScreen(),
          const CustomScreen(),
        ],
      ),
    );
  }
}
