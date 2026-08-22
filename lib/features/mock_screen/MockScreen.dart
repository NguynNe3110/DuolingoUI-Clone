import 'package:duolingo_ui_clone/core/widgets/app_answer_card.dart';
import 'package:duolingo_ui_clone/core/widgets/app_group_input_field.dart';
import 'package:duolingo_ui_clone/core/widgets/app_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:go_router/go_router.dart';

import '../../../../core/widgets/app_button.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_icon.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/widgets/app_duo_sentence.dart';
import '../../core/widgets/app_pressable_card.dart';
import '../../core/widgets/app_speech_bubble.dart';

class Mockscreen extends StatelessWidget {
  Mockscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MockData();
  }
}

class MockData extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  List<String> a = ['nguyen','nguyen','nguyen','nguyen',];

  final _duoSentence = GlobalKey<DuoSentenceState>();
  MockData({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(

        backgroundColor: const Color(0xFFABFFF8),
        title: const Text('Mock Screen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(

              children: [
                // gồm 1 vài text và button
                // Mock1(),
                AppButton(
                  iconPath: AppIcon.home,
                  label: 'XEM NHIỆM VỤ NGAY',
                  variant: ButtonVariant.secondary,
                  onPressed: () => {},

                ),


                SizedBox(height: 12,),
                // AppPressableCard(
                //   color: Colors.white,
                //   edgeColor: const Color(0xFFE5E5E5),
                //   onTap: () {},
                //   child: Padding(
                //     padding: const EdgeInsets.all(16),
                //     child: Row(
                //       children: [
                //         Icon(Icons.search, color: Colors.blue),
                //         const SizedBox(width: 12),
                //         Text('Tìm theo tên'),
                //       ],
                //     ),
                //   ),
                // ),
                Text('welcome', style: TextStyle(
                  color: const Color(0xFF8A5CF6),
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.dotted,   // 👈 chìa khóa
                  decorationThickness: 2,
                )),



                // SingleChoiceQuestion(
                //   options: a,
                //     onAnswered: (index) {
                //     }
                // ),

                // dùng như dưới

                AppDuoSentence(
                  key: _duoSentence,
                  text: 'This is not a translation',
                  meanings: {
                    'this': ['cái này'],
                    'is': ['thì, là'],
                    'not': ['không'],
                    'a': ['một'],
                    'translation': ['bản dịch'],
                  },

                  onSpeak: () => _duoSentence.currentState?.play(),  // ← gọi play(),
                  onDone: () => {},
                ),
                // GroupBDemo(),

                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: Color(0xFFBBECFD),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xFF8EDFFF),
                      width: 2,
                    ),
                  ),
                  child: SvgPicture.asset(
                    AppIcon.home,
                    width: 24,
                    height: 24,
                  ),
                ),

                // Container(
                //   child: Image.asset('assets/images/duolingo.png',
                //   width: 400,),
                // ),

                // _buildInputCard(),

                AppAnswerCard(child: Text("day là idle"), status: AnswerCardStatus.idle),
                SizedBox(height: 12,),
                AppAnswerCard(child: Text("day là retry"), status: AnswerCardStatus.retry),
                SizedBox(height: 12,),
                AppAnswerCard(child: Text("day là wrong"), status: AnswerCardStatus.wrong),
                SizedBox(height: 12,),
                AppAnswerCard(child: Text("day là correct"), status: AnswerCardStatus.correct),
                SizedBox(height: 12,),
                AppAnswerCard(child: Text("day là selected"), status: AnswerCardStatus.selected),
                SizedBox(height: 12,),

                CustomPaint(
                  painter: BubblePainter(fill: Colors.white, border: const Color(0xFFE5E5E5)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 22), // chừa chỗ cho đuôi
                    child: Text('Chào bạn! Tớ là Duo!'),
                  ),
                ),

                AppInputField(
                  hint: 'nhap gi vao day',
                  controller: _usernameController,
                ),

                AppPressableCard(
                  onPressed: () => {},

                  widget: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppButton(
                        label: 'ĐĂNG NHẬP ĐIỆN THOẠI',
                        iconPath: AppIcon.phone ,
                        variant: ButtonVariant.neutral,
                        onPressed: () => {},
                      ),

                      const SizedBox(height: AppSpacing.S16),

                      Row(
                        children: [
                          Expanded(
                            child: AppButton(
                                label: 'FACEBOOK',
                                iconPath: AppIcon.facebook,
                                variant: ButtonVariant.neutral,
                                onPressed: () => {}
                            ),
                          ),
                          const SizedBox(width: AppSpacing.S16),
                          Expanded(
                            child: AppButton(
                                label: 'GOOGLE',
                                iconPath: AppIcon.google,
                                variant: ButtonVariant.neutral,
                                onPressed: () => {}
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}


class BubblePainter extends CustomPainter {
  final Color fill, border;
  final Axis tailDirection; // dọc (down) hay ngang (left) như 2 ảnh bạn chụp
  BubblePainter({required this.fill, required this.border, this.tailDirection = Axis.vertical});

  @override
  void paint(Canvas canvas, Size size) {
    const tailH = 10.0;
    final body = Rect.fromLTWH(0, 0, size.width, size.height - tailH);
    final path = Path()..addRRect(RRect.fromRectAndRadius(body, const Radius.circular(12)));
    final tx = 40.0; // vị trí đuôi
    path..moveTo(tx, body.bottom - 1)
      ..lineTo(tx + 8, body.bottom + tailH)   // đỉnh đuôi
      ..lineTo(tx + 16, body.bottom - 1)
      ..close();
    canvas.drawPath(path, Paint()..color = fill);
    canvas.drawPath(path, Paint()..color = border..style = PaintingStyle.stroke..strokeWidth = 2);
  }
  @override
  bool shouldRepaint(covariant CustomPainter o) => false;
}
