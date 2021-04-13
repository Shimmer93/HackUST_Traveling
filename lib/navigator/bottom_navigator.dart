import 'package:flutter/material.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hackust_traveling/Pages/plaza_page.dart';

import 'package:package_info/package_info.dart';

import 'package:hackust_traveling/Pages/home_page.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  var _controller = PageController(initialPage: 0);
  int _currentIndex = 0;

  @override
  void initState() {
    // getPackageInfo();
    //Jacky: PackageInfo.fromPlatform() does not run on my machine
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        children: <Widget>[
          Plaza(),
          //SearchPage(
          //  hideLeft: true,
          //),
          //TravelPage(),
          //MyPage(),
        ],
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 12,
          unselectedFontSize: 12,
          currentIndex: _currentIndex,
          onTap: (index) {
            _controller.jumpToPage(index);
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            // _bottomItem(Icons.add, 'New', 0),
            _bottomItem(Icons.home, 'Plaza', 0),
            _bottomItem(Icons.camera_alt, 'Cam', 1),
            _bottomItem(Icons.account_circle, 'My', 2),
          ]),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar( //导航栏
  //       title: Text("App Name"),
  //       leading: Builder(builder: (context) {
  //         return IconButton(
  //           icon: Icon(Icons.dashboard, color: Colors.white), //自定义图标
  //           onPressed: () {
  //             // 打开抽屉菜单
  //             Scaffold.of(context).openDrawer();
  //             },
  //         );
  //       }),
  //       actions: <Widget>[ //导航栏右侧菜单
  //         IconButton(icon: Icon(Icons.share), onPressed: () {}),
  //       ],
  //     ),
  //     //drawer: new MyDrawer(), //抽屉
  //     bottomNavigationBar: BottomNavigationBar( // 底部导航
  //       items: <BottomNavigationBarItem>[
  //         BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
  //         BottomNavigationBarItem(icon: Icon(Icons.business), title: Text('Business')),
  //         BottomNavigationBarItem(icon: Icon(Icons.school), title: Text('School')),
  //       ],
  //       currentIndex: _selectedIndex,
  //       fixedColor: Colors.blue,
  //       onTap: _onItemTapped,
  //     ),
  //     floatingActionButton: FloatingActionButton( //悬浮按钮
  //         child: Icon(Icons.add),
  //         onPressed:_onAdd
  //     ),
  //   );
  // }
  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }
  // void _onAdd(){
  // }
  //底部导航item
  BottomNavigationBarItem _bottomItem(IconData icon, String title, int index) {
    return BottomNavigationBarItem(
        icon: Icon(
          icon,
          color: _defaultColor,
        ),
        activeIcon: Icon(
          icon,
          color: _activeColor,
        ),
        title: Text(
          title,
          style: TextStyle(
              color: _currentIndex != index ? _defaultColor : _activeColor),
        ));
  }
}
