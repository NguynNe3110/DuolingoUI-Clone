//
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:go_router/go_router.dart';
//
// import '../../core/theme/app_icon.dart';
//
// class MainShell extends StatelessWidget {
//   final StatefulNavigationShell navigationShell;
//
//   const MainShell({super.key, required this.navigationShell});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // phần nội dung: render widget của tab hiện tại
//       // navigationShell là 1 widget, nó tự động render child của branch đang active
//       body: navigationShell,
//
//       // thanh bottom navigation
//       // bottomSheet: ,
//       // bottomSheetScrimBuilder: ,
//
//
//       // thanh bottom navigation
//       bottomNavigationBar: NavigationBar( // navigation Bar bắt buộc phải chứa navigationDestination trong destination
//         //khai báo selectIndex hiện tại
//         selectedIndex: navigationShell.currentIndex,
//         //xu khi khi click tab
//         onDestinationSelected: (index) => _goBranch(index),
//         destinations: [
//           // NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
//           // NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
//           // NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
//           _buildItem(pathIcon: AppIcon.home, isSelected: true), // vì thế khoogn thể trả về widget ở đây
//           _buildItem(pathIcon: AppIcon.home, isSelected: false),// muốn làm được mình phải tự vẽ thanh navigationBar
//           _buildItem(pathIcon: AppIcon.home, isSelected: false), // dùng constaint và kết hợp với row
//           _buildItem(pathIcon: AppIcon.home, isSelected: false), // có thể dùng vòng for và so sánh với index để bắt sự kiện select
//           _buildItem(pathIcon: AppIcon.home, isSelected: false),
//           _buildItem(pathIcon: AppIcon.home, isSelected: false),
//         ],
//       ),
//
//
//     );
//   }
//
//   // hàm xử lý khi click tab
//   void _goBranch(int index) {
//     navigationShell.goBranch(
//       index,
//       // Nếu click vào tab đang mở, có muốn scroll về top không? (giống behavior của iOS/Android)
//       initialLocation: index == navigationShell.currentIndex,
//     );
//   }
//
//   Widget _buildItem({required String pathIcon, required bool isSelected}) {
//     return Expanded(
//       child: Container(
//         height: 45,
//         width: 45,
//         decoration: isSelected ?
//         BoxDecoration(
//           color: const Color(0xFFBBECFD),
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(
//             color: const Color(0xFF8EDFFF),
//             width: 2,
//           ),
//         ) : null,
//         child: SvgPicture.asset(
//           AppIcon.home,
//           width: 24,
//           height: 24,
//         ),
//       ),
//     );
//   }
// }



// =========================== update - VIP ==================================================
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:go_router/go_router.dart';
// import '../../core/theme/app_icon.dart';
//
// // ==========================================
// // 1. DATA MODEL (Tương đương data class Kotlin)
// // ==========================================
// class BottomNavItem {
//   final String iconPath;
//   final String? activeIconPath;
//   final String label;
//
//   const BottomNavItem({
//     required this.iconPath,
//     this.activeIconPath,
//     required this.label,
//   });
// }
//
// // ==========================================
// // 2. MAIN SHELL WIDGET
// // ==========================================
// class MainShell extends StatelessWidget {
//   final StatefulNavigationShell navigationShell;
//
//   const MainShell({super.key, required this.navigationShell});
//
//   // Danh sách cấu hình (Data) - Dễ dàng thêm bớt, sửa label/icon
//   static const List<BottomNavItem> _navItems = [
//     BottomNavItem(iconPath: AppIcon.home, label: 'Home'),
//     BottomNavItem(iconPath: AppIcon.home, label: 'Search'), // Thay icon thật của bạn
//     BottomNavItem(iconPath: AppIcon.home, label: 'Profile'),
//     // Thêm các tab khác tùy ý...
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: navigationShell,
//       bottomNavigationBar: SafeArea(
//         child: Container(
//           height: 75, // Chiều cao cố định để tránh bị giật khi Label ẩn hiện
//           margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.05),
//                 blurRadius: 10,
//                 offset: const Offset(0, -2),
//               ),
//             ],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               // Vòng lặp for chạy qua Data Model
//               for (int i = 0; i < _navItems.length; i++)
//                 _buildNavItem(
//                   item: _navItems[i],
//                   index: i,
//                   isSelected: i == navigationShell.currentIndex,
//                 )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _goBranch(int index) {
//     navigationShell.goBranch(
//       index,
//       initialLocation: index == navigationShell.currentIndex,
//     );
//   }
//
//   // ==========================================
//   // 3. UI COMPONENT (Render dựa trên Data & State)
//   // ==========================================
//   Widget _buildNavItem({
//     required BottomNavItem item,
//     required int index,
//     required bool isSelected,
//   }) {
//     // Logic chọn icon (Giống việc bạn chọn painterResource trong Compose)
//     final String currentIcon = (isSelected && item.activeIconPath != null)
//         ? item.activeIconPath!
//         : item.iconPath;
//
//     return Expanded(
//       child: GestureDetector(
//         onTap: () => _goBranch(index),
//         behavior: HitTestBehavior.opaque,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // --- PHẦN ICON ---
//             Container(
//               height: 40,
//               width: 40,
//               decoration: isSelected
//                   ? BoxDecoration(
//                 color: const Color(0xFFBBECFD),
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(color: const Color(0xFF8EDFFF), width: 2),
//               )
//                   : null,
//               child: Center(
//                 child: SvgPicture.asset(
//                   currentIcon,
//                   width: 24,
//                   height: 24,
//                   colorFilter: ColorFilter.mode(
//                     isSelected ? const Color(0xFF0055FF) : Colors.grey,
//                     BlendMode.srcIn,
//                   ),
//                 ),
//               ),
//             ),
//
//             // --- PHẦN LABEL (Ẩn hiện mượt mà) ---
//             // Tương đương AnimatedVisibility trong Jetpack Compose
//             AnimatedCrossFade(
//               firstChild: const SizedBox.shrink(), // Trạng thái Ẩn (Chiều cao = 0)
//               secondChild: Padding(
//                 padding: const EdgeInsets.only(top: 4.0),
//                 child: Text(
//                   item.label,
//                   style: const TextStyle(
//                     fontSize: 11,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF0055FF),
//                   ),
//                 ),
//               ),
//               crossFadeState: isSelected
//                   ? CrossFadeState.showSecond
//                   : CrossFadeState.showFirst,
//               duration: const Duration(milliseconds: 250),
//               sizeCurve: Curves.easeInOut, // Giúp height thay đổi mượt mà, không bị giật
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// =========================================================================================