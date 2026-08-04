

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // phần nội dung: render widget của tab hiện tại
      // navigationShell là 1 widget, nó tự động render child của branch đang active
      body: navigationShell,

      // thanh bottom navigation
      // bottomSheet: ,
      // bottomSheetScrimBuilder: ,


      // thanh bottom navigation
      bottomNavigationBar: NavigationBar(
        //khai báo selectIndex hiện tại
        selectedIndex: navigationShell.currentIndex,
        //xu khi khi click tab
        onDestinationSelected: (index) => _goBranch(index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),

        ],
      ),


    );
  }

  // hàm xử lý khi click tab
  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      // Nếu click vào tab đang mở, có muốn scroll về top không? (giống behavior của iOS/Android)
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}