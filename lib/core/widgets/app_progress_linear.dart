

import 'package:duolingo_ui_clone/core/exports/app_export_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class AppProgressLinear extends StatefulWidget {
  final double progress;// ti le so với cha 0, 1
  // final VoidCallback? onClose;
  final double? height;
  // final Color trackColor;
  // final Color fillColor;
  // final Color highlightColor;
  final String? label;
  final String? hint;
  final ProgressVariant? progressBarState;



  const AppProgressLinear({
    super.key,
    required this.progress,
    // this.onClose,
    this.height,
    this.label,
    this.hint,
    this.progressBarState = ProgressVariant.basic,

  });

  @override
  State<AppProgressLinear> createState() => _AppProgressLinearState();
}

class _AppProgressLinearState extends State<AppProgressLinear> {


  // void _nextQuestion() {
  //   setState(() {
  //     if (completedCount < totalQuestions) completedCount++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // final totalQuestions = widget.progress;
    // final completedCount = widget.tolalComplete;

    final palette = ProgressBarPalette.resolve(widget.progressBarState ?? ProgressVariant.basic);
    // final done = completedCount >= totalQuestions;

    Decoration fillDecoration;
    if(palette.fillGradient != null) {
      fillDecoration = BoxDecoration(
        gradient: palette.fillGradient,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      );
    } else {
      fillDecoration = BoxDecoration(
        color: palette.fillColor,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      );
    }

    return Column(
      children: [
        // phải check lại
        if (widget.progressBarState == ProgressVariant.perfect)
          const Text("HOÀN HẢO", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),

        LayoutBuilder( // co the biet chinh xac cha cho layout bao nhieu
          builder: (context, constraints) {
            return Stack( // viet sau len truoc
              children: [
                Container( //nen viet truoc
                  height: widget.height ?? AppSpacing.S16,
                  width: constraints.maxWidth,

                  decoration: BoxDecoration(
                    color: palette.trackColor,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                ),

                // fill color
                AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.elasticOut,
                  height: widget.height ?? AppSpacing.S16,
                  width: constraints.maxWidth * widget.progress.clamp(0.0, 1.0),
                  decoration: fillDecoration,
                  child: Stack(
                    children: [
                      // Lớp Highlight bóng loáng
                      Padding(
                        padding: EdgeInsets.only(left: 6,top: 4, right: 6),
                        child: FractionallySizedBox(
                          heightFactor: 0.35, //chiem 1/3 cha
                          widthFactor: 1.0,   // full width
                          alignment: Alignment.topCenter, // dinh len đỉnh
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              // color: palette.highlightColor.withOpacity(0.6), // có thể làm mờ
                              color: palette.highlightColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                // Phải dùng Positioned.fill chứ không dùng Center trần: Center trần trong Stack
                // với constraint chiều cao không giới hạn sẽ co lại bằng chiều cao text và dính lên đỉnh,
                // không căn giữa theo chiều dọc của thanh được.

                if (widget.hint != null)
                  Positioned.fill(          // chiếm đúng kích thước Stack → căn giữa chuẩn
                    child: Center(
                      child: Text(
                        widget.hint!,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: palette.hintColor,
                        ),
                      ),
                    ),
                  ),

                // 3. Text (Căn giữa theo phần Fill) - THUẬT TOÁN DECLARATIVE
                if (widget.label != null)
                  FractionallySizedBox( //có khả năng chiếm đúng một TỈ LỆ (fraction) chiều rộng của thằng cha (Stack).
                    widthFactor: widget.progress.clamp(0.0, 1.0), // Chiếm đúng % chiều rộng của Fill .Nếu progress = 0.5, FractionallySizedBox sẽ tự động rộng đúng 50% Stack.
                    child: Center(
                      child: Transform.translate(
                        offset: const Offset(0, -24), // Đẩy text lên trên 24px (trục Y)
                        child: Text(
                          widget.label!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: palette.textColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          }
        )
      ],
    );
  }
}

enum ProgressVariant {
  basic,
  chainThree,
  chainSeven,
  perfect,
}

class ProgressBarPalette {

  ProgressBarPalette({
    this.trackColor = AppColors.graySurface200,
    this.fillColor,
    this.fillGradient,
    this.textColor,
    required this.highlightColor,
    this.hintColor = AppColors.grayBorder300,
  });

  final Color? trackColor; // nen
  final Color? fillColor; // progress
  final Gradient? fillGradient;
  final Color? textColor;
  final Color highlightColor; // progres hightlitgh
  final Color hintColor;

  static ProgressBarPalette resolve(ProgressVariant variant ) {
    switch(variant){
      case ProgressVariant.basic:
        return ProgressBarPalette(
            fillColor: AppColors.duoGreenSecondary,
            highlightColor: AppColors.greenSurface750y200,
            textColor: AppColors.duoGreenSecondary,
        );
      case ProgressVariant.chainThree:
        return ProgressBarPalette(
            fillColor: AppColors.duoYellowSecondary,
            highlightColor: AppColors.yellowSurface800,
          textColor: AppColors.duoYellowSecondary,

        );
      case ProgressVariant.chainSeven:
        return ProgressBarPalette(
            fillColor: AppColors.duoOrange,
            highlightColor: AppColors.duoOrangeSecondary,
          textColor: AppColors.duoOrange,

        );
      case ProgressVariant.perfect:
        return ProgressBarPalette(
          fillGradient: LinearGradient(
            colors: [
              AppColors.blueCyanLight, // Màu xanh cyan sáng
              AppColors.blueCyanDark,  // Màu xanh dương đậm
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          highlightColor: AppColors.graySurfaceRootOpacity40, // Vệt sáng trắng mờ
          textColor: AppColors.duoBlue,
        );
    }
  }
}

// dùng
// class QuizScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<QuizBloc, QuizState>(
//       builder: (context, state) {
//         // 1. Screen tự tính toán tỉ lệ (Mapper)
//         final double progressRatio = state.totalQuestions > 0
//             ? state.completedCount / state.totalQuestions
//             : 0.0;
//
//         // 2. Screen tự format label
//         final String label = "${state.completedCount}/${state.totalQuestions}";
//
//         // 3. Truyền xuống Dumb Component
//         return Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: AppProgressLinear(
//             progress: progressRatio,
//             label: label,
//             progressBarState: state.isPerfect ? ProgressVariant.perfect : ProgressVariant.basic,
//           ),
//         );
//       },
//     );
//   }
// }