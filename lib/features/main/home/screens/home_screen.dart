// lib/features/main/home/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../data/mappers/lesson_node_mapper.dart';
import '../../../../data/mock_data/mock_home_tree.dart';
import '../../../../domain/entities/lesson_entities.dart';
import '../../../../domain/usecases/resolve_node_status_usecase.dart';
import '../../lesson/screens/lesson_screen.dart';
import '../layout/path_door.dart';
import '../layout/path_layout_engine.dart';
import '../layout/section_scroll_tracker.dart';
import '../sections/course_switcher_panel.dart';
import '../sections/home_header.dart';
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
  bool _isPanelOpen = false;

  void _togglePanel() => setState(() => _isPanelOpen = !_isPanelOpen);

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
    _tracker = SectionScrollTracker(controller: _scrollCtrl, threshold: 150)
      ..start();

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

  void _initializeDomainData() {
    _homeTree = MockHomeTree.build();
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
    context.go('/lesson-loading?next=/lesson');
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
    return LessonNodeTile(data: data, onTap: _onNodeTap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body:
          // Column(
          //   children: [
          //     HomeHeader(
          //       onFlagTap: () => {},
          //       onStreakTap: () => {},
          //       onGemTap: () => {},
          //       onEnergyTap: () => {},
          //     ),
          SafeArea(
            child: Column(
              children: [
                HomeHeader(
                  onEnergyTap: () => {},
                  onFlagTap: () => {
                    _togglePanel(),
                  }, // hoặc k cần () => . chỉ cần  viết truc tiep _togglePanel là duoc
                  onGemTap: () => {},
                  onStreakTap: () => {},
                ),
                Expanded(
                  child: Stack(
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
                            final data =
                                _flatDoors[index.clamp(
                                  0,
                                  _flatDoors.length - 1,
                                )];
                            // ✅ Giờ constructor SplitPressableCard có tham số `data` rồi
                            return SplitPressableCard(data: data);
                          },
                        ),
                      ),

                      IgnorePointer(
                        ignoring: !_isPanelOpen,
                        child: AnimatedOpacity(
                          opacity: _isPanelOpen ? 1 : 0,
                          duration: const Duration(milliseconds: 250),
                          child: GestureDetector(
                            onTap: _togglePanel, // chạm ra ngoài để đóng
                            child: Container(color: Colors.black54),
                          ),
                        ),
                      ),

                      // ── Layer 3: top bar + panel trượt từ trên xuống ──────
                      // Đặt CUỐI trong Stack → nằm trên cùng → flag luôn bấm được
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            //_buildTopBar(),
                            _buildTopSheet(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            //   ],
            // )
          ),
    );
  }

  Widget _buildTopSheet() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      transitionBuilder: (child, animation) => SizeTransition(
        sizeFactor: animation,
        axisAlignment: -1, // ⭐ neo cạnh trên → "xổ" xuống như rèm
        child: child,
      ),
      child: _isPanelOpen ? CourseSwitcherPanel() : const SizedBox.shrink(),
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
}
