// lib/features/main/home/screens/home_screen.dart
import 'package:flutter/material.dart';

import '../../../../data/mappers/lesson_node_mapper.dart';
import '../../../../domain/entities/lesson_entities.dart';
import '../../../../domain/usecases/resolve_node_status_usecase.dart';
import '../layout/path_door.dart';
import '../layout/path_layout_engine.dart';
import '../layout/section_scroll_tracker.dart';
import '../sections/course_switcher_panel.dart';
import '../widgets/lesson_node_data.dart';
import '../widgets/lesson_popup_manager.dart';
import '../widgets/section_card_view_data.dart';
import '../widgets/section_divider.dart';
import '../widgets/split_pressable_card.dart';
import '../widgets/unit_color_scope.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LessonPopupManager? _popupManager;

  late final ScrollController _scrollCtrl;
  late final SectionScrollTracker _tracker;
  late final List<List<int>> _doorOffsets;
  late final List<SectionCardViewData> _flatDoors;
  late final List<GlobalKey> _doorKeys;

  late final HomeTree _homeTree;
  final ResolveNodeStatusUseCase _resolveStatus = ResolveNodeStatusUseCase();

  @override
  void initState() {
    super.initState();

    // 1. Domain trước
    _initializeDomainData();

    // 2. ✅ FIX: 3 dòng init bị mất
    _scrollCtrl = ScrollController();
    _tracker = SectionScrollTracker(controller: _scrollCtrl, threshold: 150)..start();

    // 3. Tính offsets cho toàn bộ cây (xuyên section)
    final doorSizes = [
      for (final s in _homeTree.course.sections)
        for (final d in s.doors) d.lessons.length,
    ];
    _doorOffsets = const PathLayoutEngine().build(doorSizes);

    // 4. ViewData phẳng + anchors cho card đổi theo cuộn
    _flatDoors = [
      for (final s in _homeTree.course.sections)
        for (final d in s.doors) SectionCardViewData(section: s, door: d),
    ];
    _doorKeys = List.generate(_flatDoors.length, (_) => GlobalKey());
    _tracker.attachAnchors(_doorKeys);
  }

  // ... _initializeDomainData giữ NGUYÊN như bạn đang có ...
  void _initializeDomainData() {
    final section1 = Section(
      id: 'section_1',
      number: '1',
      title: 'Phần 1',
      description: 'Học các từ vựng cơ bản và cách chào hỏi.',

      doors: [
        Door(
          id: 'door_1',
          number: 1,
          title: 'Giới thiệu gốc gác',
          themeColor: DomainThemeColor.green,
          lessons: const [
            Lesson(id: '0', title: 'Bài 1', type: DomainLessonType.star, partCount: 4),
            Lesson(id: '1', title: 'Bài 2', type: DomainLessonType.book, partCount: 4),
            Lesson(id: '2', title: 'Bài 3', type: DomainLessonType.headphone, partCount: 5),
            Lesson(id: '3', title: 'Bài 4', type: DomainLessonType.video, partCount: 3),
            Lesson(id: '4', title: 'Bài 5', type: DomainLessonType.weight, partCount: 4),
            Lesson(id: '5', title: 'Bài 6', type: DomainLessonType.book, partCount: 4),
            Lesson(id: '6', title: 'Bài 7', type: DomainLessonType.star, partCount: 3),
            Lesson(id: '7', title: 'Bài 8', type: DomainLessonType.video, partCount: 6),
            Lesson(id: '8', title: 'Bài 9', type: DomainLessonType.headphone, partCount: 4),
            Lesson(id: '9', title: 'Bài 10', type: DomainLessonType.book, partCount: 5),
            Lesson(id: '10', title: 'Bài 11', type: DomainLessonType.weight, partCount: 3),
            Lesson(id: '11', title: 'Bài 12', type: DomainLessonType.star, partCount: 5),
            Lesson(id: '12', title: 'Bài 13', type: DomainLessonType.video, partCount: 4),
            Lesson(id: '13', title: 'Bài 14', type: DomainLessonType.book, partCount: 3),
            Lesson(id: '14', title: 'Bài 15', type: DomainLessonType.headphone, partCount: 6),
            Lesson(id: '15', title: 'Bài 16', type: DomainLessonType.weight, partCount: 5),
            Lesson(id: '16', title: 'Bài 17', type: DomainLessonType.star, partCount: 4),

          ],
        ),
        Door(
          id: 'door_2',
          number: 2,
          title: 'Chào hỏi cơ bản',
          themeColor: DomainThemeColor.blue,

          lessons: const [
            Lesson(id: '17', title: 'Bài 18', type: DomainLessonType.star, partCount: 4),
            Lesson(id: '18', title: 'Bài 19', type: DomainLessonType.book, partCount: 4),
            Lesson(id: '19', title: 'Bài 20', type: DomainLessonType.headphone, partCount: 5),
            Lesson(id: '20', title: 'Bài 21', type: DomainLessonType.video, partCount: 3),
            Lesson(id: '21', title: 'Bài 22', type: DomainLessonType.weight, partCount: 4),
            Lesson(id: '22', title: 'Bài 23', type: DomainLessonType.book, partCount: 4),
            Lesson(id: '23', title: 'Bài 24', type: DomainLessonType.star, partCount: 3),
            Lesson(id: '24', title: 'Bài 25', type: DomainLessonType.video, partCount: 6),
            Lesson(id: '25', title: 'Bài 26', type: DomainLessonType.headphone, partCount: 4),
            Lesson(id: '26', title: 'Bài 27', type: DomainLessonType.book, partCount: 5),

          ],
        ),
      ],
    );

    final section2 = Section(
      id: 'section_2',
      number: '2',
      title: 'Phần 2',
      description: 'Tìm hiểu về các thành viên trong gia đình.',
      doors: [
        Door(
          id: 'door_3',
          number: 3,
          title: 'Gia đình của tôi',
          themeColor: DomainThemeColor.pink,

          lessons: const [
            Lesson(id: '27', title: 'Bài 28', type: DomainLessonType.book, partCount: 6),
            Lesson(id: '28', title: 'Bài 29', type: DomainLessonType.video, partCount: 5),
            Lesson(id: '29', title: 'Bài 30', type: DomainLessonType.headphone, partCount: 3),
            Lesson(id: '30', title: 'Bài 31', type: DomainLessonType.weight, partCount: 4),
            Lesson(id: '31', title: 'Bài 32', type: DomainLessonType.star, partCount: 6),
            Lesson(id: '32', title: 'Bài 33', type: DomainLessonType.video, partCount: 3),
            Lesson(id: '33', title: 'Bài 34', type: DomainLessonType.book, partCount: 5),
            Lesson(id: '34', title: 'Bài 35', type: DomainLessonType.headphone, partCount: 4),
            Lesson(id: '35', title: 'Bài 36', type: DomainLessonType.weight, partCount: 6),
            Lesson(id: '36', title: 'Bài 37', type: DomainLessonType.star, partCount: 3),
            Lesson(id: '37', title: 'Bài 38', type: DomainLessonType.video, partCount: 5),
            Lesson(id: '38', title: 'Bài 39', type: DomainLessonType.book, partCount: 4),
            Lesson(id: '39', title: 'Bài 40', type: DomainLessonType.headphone, partCount: 5),

          ],
        ),
        Door(
          id: 'door_4',
          number: 4,
          title: 'Hoạt động gia đình',
          themeColor: DomainThemeColor.red,

          lessons: const [
            Lesson(id: '40', title: 'Bài 40', type: DomainLessonType.star, partCount: 4),
            Lesson(id: '41', title: 'Bài 41', type: DomainLessonType.book, partCount: 5),
            Lesson(id: '42',  title: 'Bài 42',type: DomainLessonType.headphone, partCount: 3),
            Lesson(id: '43',  title: 'Bài 43',type: DomainLessonType.video, partCount: 6),
            Lesson(id: '44', title: 'Bài 44', type: DomainLessonType.weight, partCount: 4),
          ],
        ),
      ],
    );

    final section3 = Section(
      id: 'section_3',
      number: '3',
      title: 'Phần 3',
      description: 'Tham gia lễ hội âm nhạc và học từ vựng mới.',
      doors: [
        Door(
          id: 'door_5',
          number: 5,
          title: 'Lễ hội âm nhạc',
          themeColor: DomainThemeColor.blue,

          lessons: const [
            Lesson(id: '45', title: 'Bài 41', type: DomainLessonType.headphone, partCount: 4),
            Lesson(id: '46', title: 'Bài 42', type: DomainLessonType.video, partCount: 5),
            Lesson(id: '47', title: 'Bài 43', type: DomainLessonType.star, partCount: 3),
            Lesson(id: '48', title: 'Bài 44', type: DomainLessonType.book, partCount: 6),
            Lesson(id: '49', title: 'Bài 45', type: DomainLessonType.weight, partCount: 4),
            Lesson(id: '50', title: 'Bài 46', type: DomainLessonType.headphone, partCount: 5),
            Lesson(id: '51', title: 'Bài 47', type: DomainLessonType.video, partCount: 3),
            Lesson(id: '52', title: 'Bài 48', type: DomainLessonType.star, partCount: 4),
          ],
        ),
      ],
    );

    const progress = UserProgress(
      completedLessonIds: {'0', '1', '17', '18'},
      currentLessonId: '2',
      completedParts: {'2': 2, '19': 3},
    );

    final course = Course(
      id: 'course_english',
      title: 'Tiếng Anh',
      sections: [section1, section2, section3],
    );

    _homeTree = HomeTree(course: course, progress: progress);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _popupManager ??= LessonPopupManager(context);
  }

  @override
  void dispose() {
    _popupManager?.dispose();
    _tracker.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _onNodeTap(LessonNodeData data, Rect nodeRect) {
    if (data.status == LessonNodeStatus.locked) return;
    _popupManager?.show(
      nodeRect: nodeRect,
      data: data,
      onStart: () => _onStartLesson(data),
    );
  }

  void _onStartLesson(LessonNodeData data) {
    debugPrint('Bắt đầu bài học: ${data.id}');
  }

  Widget _buildNodeFor(Lesson lesson, Door door, Section section) {
    final status = _resolveStatus(
      lesson: lesson,
      door: door,
      tree: _homeTree,
      progress: _homeTree.progress,
    );
    final data = LessonNodeMapper.toViewData(
      lesson: lesson,
      door: door,
      domainStatus: status,
      progress: _homeTree.progress,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: LessonNodeTile(data: data, onTap: _onNodeTap),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: Stack(
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: (_) {
              _popupManager?.hide();
              return false;
            },
            child: SingleChildScrollView(
              controller: _scrollCtrl,
              padding: const EdgeInsets.only(top: 150, bottom: 40),
              child: Column(children: _buildSections()),
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ValueListenableBuilder<int>(
              valueListenable: _tracker.activeIndex,
              builder: (_, index, __) {
                final data = _flatDoors[index.clamp(0, _flatDoors.length - 1)];
                // ✅ Giờ constructor SplitPressableCard có tham số `data` rồi
                return SplitPressableCard(data: data);
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSections() {
    final widgets = <Widget>[];
    var flatIndex = 0;

    for (var s = 0; s < _homeTree.course.sections.length; s++) {
      final section = _homeTree.course.sections[s];
      if (s > 0) {
        widgets.add(SectionDivider(title: section.title));
      }

      for (final door in section.doors) {
        final key = _doorKeys[flatIndex];
        final offsets = _doorOffsets[flatIndex];
        // ✅ XÓA dòng `final cardData = _flatDoors[flatIndex];` (biến chết)
        flatIndex++;

        widgets.add(SizedBox(key: key, height: 0));

        widgets.add(
          UnitColorScope(
            color: LessonNodeMapper.mapThemeColorForScope(door.themeColor),
            child: PathDoor(
              offsets: offsets,
              children: door.lessons
                  .map((l) => _buildNodeFor(l, door, section))
                  .toList(),
            ),
          ),
        );
      }
    }
    return widgets;
  }

  void _showCourseSwitcher(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'dismiss',
      barrierColor: Colors.black.withValues(alpha: 0.5), // API mới, thay withOpacity đã deprecated
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (_, __, ___) => const Align(
        alignment: Alignment.topCenter,
        child: Material(child: CourseSwitcherPanel()), // panel chứa list course + thanh XP
      ),
      transitionBuilder: (_, anim, __, child) => SlideTransition(
        position: Tween(begin: const Offset(0, -1), end: Offset.zero)
            .animate(CurvedAnimation(parent: anim, curve: Curves.easeOut)),
        child: child,
      ),
    );
  }


}