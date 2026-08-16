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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 110,
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
      ],
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
              padding: const EdgeInsets.all(3), // khe hở giữa viền và icon (giống ảnh)
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isSelected ? AppColors.duoBlue : Colors.transparent,
                  width: 2,
                ),
              ),
              child: SvgPicture.asset(icon, width: 56, height: 42, fit: BoxFit.contain),
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