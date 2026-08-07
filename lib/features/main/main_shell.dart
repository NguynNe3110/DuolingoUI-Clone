import 'package:duolingo_ui_clone/core/theme/app_colors.dart';
import 'package:duolingo_ui_clone/core/theme/app_radius.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_icon.dart';

// class MainShell extends StatelessWidget {
//   final StatefulNavigationShell navigationShell;
//   const MainShell({super.key, required this.navigationShell});
//
//   static const int moreIndex = 5;
//
//   @override
//   Widget build(BuildContext context) {
//     // 👇 context này là của MainShell, dùng để showDialog, go route, lấy theme...
//     final List<String> tabIcons = [
//       AppIcon.home,
//       AppIcon.mission,
//       AppIcon.trophyGold,
//       AppIcon.home,
//       AppIcon.home,
//       AppIcon.more,
//     ];
//
//     return Scaffold(
//       body: navigationShell,
//       bottomNavigationBar: SafeArea(
//         child: Container(
//           height: 70,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             border: Border(top: BorderSide(color: AppColors.grayBorder200, width: 2)),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               for (int i = 0; i < moreIndex; i++)
//                 _buildItem(
//                   pathIcon: tabIcons[i],
//                   isSelected: i == navigationShell.currentIndex,
//                   index: i,
//                   onTap: () => _goBranch(i, context), // ✅ truyền context của MainShell
//                 ),
//               _buildItem(
//                 pathIcon: tabIcons[moreIndex],
//                 isSelected: moreIndex == navigationShell.currentIndex,
//                 index: moreIndex,
//                 onTap: () => _goBranch(moreIndex, context), // ✅ truyền context
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // ✅ Thêm tham số BuildContext
//   void _goBranch(int index, BuildContext context) {
//     if (index == moreIndex) {
//       if (navigationShell.currentIndex == moreIndex) {
//         // Đang ở More rồi → mở sheet
//         _showMoreSheet(context);
//       } else {
//         // Chưa ở More → nhảy vào branch More (auto redirect đến /more/pronounce)
//         navigationShell.goBranch(index);
//       }
//     } else {
//       navigationShell.goBranch(
//         index,
//         initialLocation: index == navigationShell.currentIndex,
//       );
//     }
//   }
//
//   // ✅ Nhận BuildContext để dùng Navigator và GoRouter
//   void _showMoreSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.transparent,
//       builder: (sheetContext) => Container(
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//         ),
//         child: SafeArea(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               _sheetItem(
//                 icon: Icons.mic,
//                 iconColor: Colors.red,
//                 title: 'Phát âm',
//                 onTap: () => _openFromSheet(sheetContext, context, '/more/pronounce'),
//               ),
//               _sheetItem(
//                 icon: Icons.videocam,
//                 iconColor: Colors.purple,
//                 title: 'Cuộc gọi video',
//                 onTap: () => _openFromSheet(sheetContext, context, '/more/call'),
//               ),
//               _sheetItem(
//                 icon: Icons.fitness_center,
//                 iconColor: Colors.blue,
//                 title: 'Trung tâm luyện tập',
//                 onTap: () => _openFromSheet(sheetContext, context, '/more/practices'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Tách hàm để đóng sheet + điều hướng
//   void _openFromSheet(BuildContext sheetContext, BuildContext appContext, String path) {
//     Navigator.of(sheetContext).pop(); // đóng sheet
//     appContext.go(path);               // điều hướng (dùng context của MainShell)
//   }
//
//   Widget _sheetItem({
//     required IconData icon,
//     required Color iconColor,
//     required String title,
//     required VoidCallback onTap,
//   }) {
//     return ListTile(
//       leading: Icon(icon, color: iconColor),
//       title: Text(title),
//       onTap: onTap,
//     );
//   }
//
//   Widget _buildItem({
//     required String pathIcon,
//     required bool isSelected,
//     required int index,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       behavior: HitTestBehavior.opaque,
//       child: Container(
//         height: 45,
//         width: 45,
//         decoration: isSelected
//             ? BoxDecoration(
//           color: AppColors.blueSurface200,
//           borderRadius: BorderRadius.circular(AppRadius.md),
//           border: Border.all(color: AppColors.blueBorder450, width: 2),
//         )
//             : null,
//         child: Center(
//           child: SvgPicture.asset(pathIcon, width: 24, height: 24),
//         ),
//       ),
//     );
//   }
// }

class MainShell extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  const MainShell({super.key, required this.navigationShell});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  static const int moreIndex = 5;
  bool _isMoreOpen = false; // ≈ remember { mutableStateOf(false) } trong Compose

  // ---------- XỬ LÝ SỰ KIỆN ----------
  void _onTabTap(int index) {
    if (index == moreIndex) {
      // Tab "...": CHỈ bật/tắt overlay, KHÔNG goBranch
      setState(() => _isMoreOpen = !_isMoreOpen);
      return;
    }
    // Tab thật: đóng overlay (nếu đang mở) rồi mới đổi branch
    setState(() => _isMoreOpen = false);
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  void _onMoreItemTap(String path) {
    setState(() => _isMoreOpen = false);
    context.go(path); // route nằm TRONG branch 5 → bottom nav giữ nguyên
  }

  void _closeMore() => setState(() => _isMoreOpen = false);

  @override
  Widget build(BuildContext context) {
    final shell = widget.navigationShell;
    final List<String> tabIcons = [
      AppIcon.home, AppIcon.mission, AppIcon.trophyGold,
      AppIcon.home, AppIcon.home,     // thay icon thật
      AppIcon.more,
    ];

    return PopScope(
      // Back khi overlay đang mở → chỉ đóng overlay, không thoát app
      canPop: !_isMoreOpen,
      onPopInvokedWithResult: (didPop, _) {  // Flutter cũ: onPopInvoked
        if (!didPop) _closeMore();
      },
      child: Scaffold(
        // BODY = Stack: nội dung tab hiện tại + overlay More
        body: Stack(
          children: [
            // 1. Nội dung tab hiện tại (Profile, Home...)
            shell,

            // 2. Lớp phủ tối — chỉ che body, KHÔNG che bottom nav
            if (_isMoreOpen)
              GestureDetector(
                onTap: _closeMore, // chạm vùng tối để đóng
                child: Container(color: Colors.black.withOpacity(0.65)),
              ),

            // 3. Ba nút chức năng dính đáy, nằm trên bottom nav
            if (_isMoreOpen)
              Positioned(
                left: 0, right: 0, bottom: 0,
                child: _buildMoreOptions(),
              ),
          ],
        ),

        bottomNavigationBar: SafeArea(
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: AppColors.grayBorder200, width: 2)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < moreIndex; i++)
                  _buildItem(
                    pathIcon: tabIcons[i],
                    // Overlay mở → tab cũ KHÔNG được highlight
                    isSelected: !_isMoreOpen && i == shell.currentIndex,
                    onTap: () => _onTabTap(i),
                  ),
                _buildItem(
                  pathIcon: tabIcons[moreIndex],
                  // Highlight "..." khi overlay mở HOẶC đang ở 1 trong 3 màn more
                  isSelected: _isMoreOpen || shell.currentIndex == moreIndex,
                  onTap: () => _onTabTap(moreIndex),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------- OVERLAY 3 CHỨC NĂNG ----------
  Widget _buildMoreOptions() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _moreOptionItem(Icons.mic, Colors.red, 'Phát âm', '/more/pronounce'),
        const Divider(height: 1, color: AppColors.grayBorder200),
        _moreOptionItem(Icons.videocam, Colors.purple, 'Cuộc gọi video', '/more/call'),
        const Divider(height: 1, color: AppColors.grayBorder200),
        _moreOptionItem(Icons.fitness_center, Colors.blue, 'Trung tâm luyện tập', '/more/practices'),
      ],
    );
  }

  Widget _moreOptionItem(IconData icon, Color color, String label, String path) {
    return Material(
      color: const Color(0xFF535353), // nền tối giống screenshot
      child: InkWell(
        onTap: () => _onMoreItemTap(path),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(width: 16),
              Text(label, style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15)),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- TAB ITEM ----------
  Widget _buildItem({
    required String pathIcon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 45, width: 45,
        decoration: isSelected
            ? BoxDecoration(
            color: AppColors.blueSurface200,
            borderRadius: BorderRadius.circular(AppRadius.r10),
            border: Border.all(color: AppColors.blueBorder450, width: 2))
            : null,
        child: Center(child: SvgPicture.asset(pathIcon, width: 24, height: 24)),
      ),
    );
  }
}