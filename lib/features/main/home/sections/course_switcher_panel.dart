import 'package:duolingo_ui_clone/core/exports/app_export_theme.dart';
import 'package:duolingo_ui_clone/core/widgets/app_progress_linear.dart';
import 'package:duolingo_ui_clone/core/widgets/app_text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icon.dart';
import '../../../../core/theme/app_text_theme.dart';
import '../../../../data/mock_data/mock_course.dart';
import '../../../../domain/entities/lesson_entities.dart';
//
// class CourseSwitcherPanel extends StatefulWidget{
//
//   final String icon;
//   final String courseName;
//
//   const CourseSwitcherPanel({
//     required this.icon,
//     required this.courseName
//   });
//
//   @override
//   State<CourseSwitcherPanel> createState() {
//     return _CourseSwitcherPanelState();
//   }
// }
//
// class _CourseSwitcherPanelState extends State<CourseSwitcherPanel> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // SizedBox(
//         //   height: 110,
//         //   child: ListView.builder(
//         //     scrollDirection: Axis.horizontal,
//         //     itemCount: state.courses.length,
//         //     itemBuilder: (context, index) {
//         //       final course = state.courses[index];
//         //       return CourseItem(
//         //         icon: course.icon,
//         //         courseName: course.name,
//         //         isSelected: course.id == state.selectedCourseId,
//         //         onTap: () => context
//         //             .read<CourseSwitcherBloc>()
//         //             .add(CourseSelected(courseId: course.id)), // Event riêng, one event per class
//         //       );
//         //     },
//         //   ),
//         // )
//
//       ],
//     );
//   }
// }

class CourseSwitcherPanel extends StatefulWidget {
  const CourseSwitcherPanel({super.key});

  @override
  State<CourseSwitcherPanel> createState() => _CourseSwitcherPanelState();
}

class _CourseSwitcherPanelState extends State<CourseSwitcherPanel> {
  // TẠM: state cục bộ để mock UI.
  // Bài 6+ (BLoC): xóa biến này, dùng BlocProvider/BlocBuilder thay thế.
  CourseSwitcherState state = CourseSwitcherState.mock;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.courses.length,
              itemBuilder: (context, index) {
                final course = state.courses[index];
                return CourseItem(
                  icon: course.icon,
                  courseName: course.name,
                  isSelected: course.id == state.selectedCourseId,
                  onTap: () => _onCourseTap(course),
                );
              },
            ),
          ),
          // TODO: card progress "Điểm Tiếng Anh của bạn là 28" sẽ là widget riêng
          _CourseGrade(),

        ],
      ),
    );
  }

  void _onCourseTap(MockCourse course) { // cho nay phai la course
    // Tương lai (đúng chuẩn kiến trúc):
    // context.read<CourseSwitcherBloc>().add(CourseSelected(courseId: course.id));
    setState(() {
      state = state.copyWith(selectedCourseId: course.id);
    });
  }
}
// @override
// Widget build(BuildContext context) { hay, phù hợp với list ngắn
//   return Column(
//     mainAxisSize: MainAxisSize.min,
//     children: [
//       SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             for (final course in state.courses)
//               CourseItem(
//                 icon: course.icon,
//                 courseName: course.name,
//                 isSelected: course.id == state.selectedCourseId,
//                 onTap: () => _onCourseTap(course),
//               ),
//           ],
//         ),
//       ),
//       // TODO: card progress "Điểm Tiếng Anh của bạn là 28"
//     ],
//   );
// }
class CourseItem extends StatelessWidget {
  const CourseItem({
    super.key,
    required this.icon,
    required this.courseName,
    this.isSelected = false,
    this.onTap,
  });

  final String icon;
  final String courseName;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Box chứa icon: viền xanh khi selected, trong suốt khi không
            Container(
              padding: const EdgeInsets.all(4), // khe hở giữa viền và icon (giống ảnh)
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isSelected ? AppColors.duoBlue : Colors.transparent,
                  width: 3,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(9),
                child: SvgPicture.asset(
                    icon,
                    width: 80,
                    // height: 42,
                    fit: BoxFit.cover// contain
                ),
              )
            ),
            const SizedBox(height: 8),
            Text(
              courseName,
              maxLines: 1,
              style: AppTextTheme.light.labelLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}

class _CourseGrade extends StatelessWidget {  // Đổi tên thành PascalCase
  const _CourseGrade({super.key});  // Thêm constructor

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),  // Thêm margin
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grayBorder200, width: 2),
        borderRadius: BorderRadius.circular(AppRadius.r14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,  // <-- THÊM DÒNG NÀY
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // spaceAround -> spaceBetween đẹp hơn với 3 item
              children: [
                const Text('28'),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: AppProgressLinear(progress: 0.875),
                  ),
                ),
                const Text('29'),
              ],
            ),
            const SizedBox(height: 8),    // Thay Text('') bằng SizedBox
            const Text('Điểm Tiếng Anh của bạn là 28'),
            // const SizedBox(height: 8),  // Thay Text('') bằng SizedBox
            AppTextButton(
              text: 'TÌM HIỂU THÊM',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}