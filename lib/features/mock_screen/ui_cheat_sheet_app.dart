import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// void main() => runApp(const UiCheatSheetApp());

class UiCheatSheetApp extends StatefulWidget {
  const UiCheatSheetApp({super.key});

  @override
  State<UiCheatSheetApp> createState() => _UiCheatSheetAppState();
}

class _UiCheatSheetAppState extends State<UiCheatSheetApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _updateThemeMode(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter UI/UX Cheat Sheet',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF1CB0F6),
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF6F8FB),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.black12),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.black12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFF1CB0F6), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.redAccent),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF1CB0F6),
          foregroundColor: Colors.white,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF1CB0F6),
        brightness: Brightness.dark,
      ),
      home: UiCheatSheetScreen(
        themeMode: _themeMode,
        onThemeModeChanged: _updateThemeMode,
      ),
    );
  }
}

class UiCheatSheetScreen extends StatefulWidget {
  final ThemeMode themeMode;
  final ValueChanged<bool> onThemeModeChanged;

  const UiCheatSheetScreen({
    super.key,
    required this.themeMode,
    required this.onThemeModeChanged,
  });

  @override
  State<UiCheatSheetScreen> createState() => _UiCheatSheetScreenState();
}

class _UiCheatSheetScreenState extends State<UiCheatSheetScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late final AnimationController _animationController;

  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  final _passwordController = TextEditingController();
  final _scrollController = ScrollController();
  final _pageController = PageController(viewportFraction: 0.86);

  bool _obscurePassword = true;
  bool _agree = false;
  bool _notifications = true;
  int _radioValue = 0;
  double _sliderValue = 30;
  String _dropdownValue = 'Option 1';
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  int _bottomNavIndex = 0;
  bool _showScrollTopButton = false;
  List<String> _users = List.generate(18, (index) => 'User ${index + 1}');

  final List<String> _tags = const [
    'Flutter',
    'Kotlin',
    'Compose',
    'Bloc',
    'Dio',
    'Drift',
    'Firebase',
    'GoRouter',
    'Clean Architecture',
  ];

  final Set<int> _selectedTags = {0, 3};
  List<bool> _toggleButtons = [true, false, false];
  int _segmentedIndex = 0;

  double _loadingValue = 0.3;
  bool _visible = true;
  bool _enabled = true;
  double _opacity = 1.0;
  AlignmentGeometry _alignment = Alignment.center;

  bool _boxExpanded = false;
  double _animatedWidth = 120;
  Color _animatedColor = const Color(0xFF1CB0F6);
  BorderRadius _animatedRadius = BorderRadius.circular(16);

  int _counter = 0;

  late final Future<String> _fakeApiFuture = Future.delayed(
    const Duration(seconds: 1),
        () => 'Fake API done',
  );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    _textController.dispose();
    _passwordController.dispose();
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message, {bool success = true}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                success ? Icons.check_circle : Icons.error,
                color: Colors.white,
              ),
              const SizedBox(width: 8),
              Expanded(child: Text(message)),
            ],
          ),
          backgroundColor: success ? Colors.green : Colors.redAccent,
          action: SnackBarAction(
            label: 'OK',
            textColor: Colors.white,
            onPressed: () {},
          ),
          duration: const Duration(seconds: 2),
        ),
      );
  }

  void _submitForm() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      HapticFeedback.mediumImpact();
      _showSnackBar('Form hợp lệ: ${_textController.text}');
    } else {
      HapticFeedback.vibrate();
      _showSnackBar('Form chưa hợp lệ', success: false);
    }
  }

  Future<void> _showAlertDialog() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.warning_amber_rounded),
        title: const Text('Xác nhận'),
        content: const Text('Bạn có chắc muốn thực hiện hành động này?'),
        actionsAlignment: MainAxisAlignment.end,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Hủy'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('OK'),
          ),
        ],
      ),
    );

    if (!mounted) return;
    if (result == true) {
      _showSnackBar('Đã xác nhận OK');
    }
  }

  void _showModalBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Modal Bottom Sheet',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              const ListTile(
                leading: CircleAvatar(child: Icon(Icons.person)),
                title: Text('Profile'),
                subtitle: Text('Xem thông tin cá nhân'),
              ),
              ListTile(
                leading: const Icon(Icons.settings_outlined),
                title: const Text('Settings'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.share_outlined),
                title: const Text('Share'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.pop(context),
              ),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
      helpText: 'Chọn ngày',
    );

    if (!mounted) return;
    if (picked != null) {
      setState(() => _selectedDate = picked);
      _showSnackBar('Đã chọn ngày: ${picked.day}/${picked.month}/${picked.year}');
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
      helpText: 'Chọn giờ',
    );

    if (!mounted) return;
    if (picked != null) {
      setState(() => _selectedTime = picked);
      _showSnackBar('Đã chọn giờ: ${picked.format(context)}');
    }
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;

    setState(() {
      _users = List.generate(18, (index) => 'User ${index + 1}');
    });
    _showSnackBar('Refresh xong');
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  void _toggleAnimatedBox() {
    setState(() {
      _boxExpanded = !_boxExpanded;
      _animatedWidth = _boxExpanded ? 190 : 120;
      _animatedColor =
      _boxExpanded ? Colors.deepPurple : const Color(0xFF1CB0F6);
      _animatedRadius = BorderRadius.circular(_boxExpanded ? 32 : 16);
      _alignment = _boxExpanded ? Alignment.bottomLeft : Alignment.center;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter UI/UX Cheat Sheet'),
        actions: [
          IconButton(
            tooltip: 'Hiện SnackBar',
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => _showSnackBar('Đây là SnackBar'),
          ),
          PopupMenuButton<String>(
            tooltip: 'Menu',
            initialValue: 'share',
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'share',
                child: ListTile(
                  leading: Icon(Icons.share),
                  title: Text('Share'),
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Delete'),
                ),
              ),
            ],
            onSelected: (value) => _showSnackBar('Chọn menu: $value'),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(icon: Icon(Icons.dashboard_outlined), text: 'Layout'),
            Tab(icon: Icon(Icons.text_fields), text: 'Input'),
            Tab(icon: Icon(Icons.touch_app), text: 'Button'),
            Tab(icon: Icon(Icons.list_alt), text: 'List'),
            Tab(icon: Icon(Icons.feedback_outlined), text: 'UX'),
            Tab(icon: Icon(Icons.devices), text: 'Responsive'),
          ],
        ),
      ),
      drawer: _buildDrawer(colorScheme),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildLayoutPage(colorScheme),
          _buildInputPage(colorScheme),
          _buildButtonPage(colorScheme),
          _buildListPage(colorScheme),
          _buildFeedbackPage(colorScheme),
          _buildResponsivePage(colorScheme),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showModalBottomSheet,
        icon: const Icon(Icons.rocket_launch),
        label: const Text('Bottom Sheet'),
        tooltip: 'Mở bottom sheet',
        heroTag: 'cheat_sheet_main_fab',
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _bottomNavIndex,
        onDestinationSelected: (index) {
          setState(() => _bottomNavIndex = index);
          HapticFeedback.selectionClick();
        },
        destinations: const [
          NavigationDestination(
            icon: Badge(label: Text('2'), child: Icon(Icons.home_outlined)),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Saved',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(ColorScheme colorScheme) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1CB0F6), Color(0xFF7AD8FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: colorScheme.surface,
                  child: const Icon(Icons.person, size: 30),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Flutter Cheat Sheet',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const Text(
                  'Map từ Kotlin/Compose sang Flutter',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            selected: true,
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Settings'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.pop(context),
          ),
          ExpansionTile(
            leading: const Icon(Icons.folder_outlined),
            title: const Text('Options'),
            children: const [
              ListTile(title: Text('Option 1')),
              ListTile(title: Text('Option 2')),
            ],
          ),
          const AboutListTile(
            applicationName: 'UI Cheat Sheet',
            applicationVersion: '1.0.0',
            aboutBoxChildren: [
              Text('Sample covering many Flutter UI/UX properties.'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _miniBox(String label) {
    return Container(
      height: 56,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFF1CB0F6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }

  Widget _buildLayoutPage(ColorScheme colorScheme) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
      children: [
        _sectionTitle('Container + BoxDecoration'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 100,
              width: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black12, width: 1),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
                gradient: const LinearGradient(
                  colors: [Color(0xFF1CB0F6), Color(0xFF7AD8FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Text(
                'Box',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Transform.rotate(
              angle: 0.06,
              child: Container(
                constraints: const BoxConstraints(
                  minWidth: 80,
                  maxWidth: 140,
                  minHeight: 80,
                  maxHeight: 140,
                ),
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.all(8),
                alignment: Alignment.bottomRight,
                decoration: BoxDecoration(
                  color: colorScheme.secondaryContainer,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                  border: Border.all(color: colorScheme.primary, width: 2),
                ),
                child: Text(
                  'Constraints',
                  style: TextStyle(color: colorScheme.onSecondaryContainer),
                ),
              ),
            ),
          ],
        ),
        _sectionTitle('Row / Column / Expanded / Flexible'),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(flex: 2, child: _miniBox('Expanded flex 2')),
                  const SizedBox(width: 8),
                  Expanded(child: _miniBox('Expanded flex 1')),
                  const SizedBox(width: 8),
                  Flexible(child: _miniBox('Flexible')),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: const [
                  Icon(Icons.info_outline),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Text rất dài để demo overflow ellipsis. Text rất dài để demo overflow ellipsis.',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        _sectionTitle('Stack + Positioned + Align'),
        SizedBox(
          height: 180,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [
                      colorScheme.primaryContainer,
                      colorScheme.secondaryContainer,
                    ],
                  ),
                ),
              ),
              const Positioned(
                top: 16,
                left: 16,
                child: Chip(label: Text('Positioned top-left')),
              ),
              Positioned(
                bottom: 16,
                right: 16,
                child: FloatingActionButton.small(
                  heroTag: 'stack_fab',
                  onPressed: () => _showSnackBar('FAB trong Stack'),
                  child: const Icon(Icons.add),
                ),
              ),
              const Align(
                alignment: Alignment.center,
                child: FlutterLogo(size: 56),
              ),
            ],
          ),
        ),
        _sectionTitle('Wrap + Table'),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.start,
          children: _tags
              .map(
                (tag) => Chip(
              label: Text(tag),
              avatar: CircleAvatar(child: Text(tag[0])),
            ),
          )
              .toList(),
        ),
        const SizedBox(height: 12),
        Table(
          border: TableBorder.all(color: colorScheme.outlineVariant),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: const [
            TableRow(
              children: [
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Cell 1'),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Cell 2'),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Cell 3'),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Cell 4'),
                  ),
                ),
              ],
            ),
          ],
        ),
        _sectionTitle('AspectRatio / FractionallySizedBox / FittedBox'),
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colorScheme.tertiaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text('AspectRatio 16:9'),
          ),
        ),
        const SizedBox(height: 12),
        FractionallySizedBox(
          widthFactor: 0.7,
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text('FractionallySizedBox widthFactor 0.7'),
          ),
        ),
        const SizedBox(height: 12),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.all(12),
            color: colorScheme.primaryContainer,
            child: const Text(
              'FittedBox scale down nếu text quá dài, rất dài, rất rất dài',
              maxLines: 1,
            ),
          ),
        ),
        _sectionTitle('AnimatedContainer / Alignment'),
        Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOutBack,
              width: _animatedWidth,
              height: 100,
              alignment: _alignment,
              decoration: BoxDecoration(
                color: _animatedColor,
                borderRadius: _animatedRadius,
              ),
              child: const Text(
                'A',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            const Spacer(),
            Column(
              children: [
                FilledButton(
                  onPressed: _toggleAnimatedBox,
                  child: const Text('Change'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _alignment = _alignment == Alignment.center
                          ? Alignment.topRight
                          : Alignment.center;
                    });
                  },
                  child: const Text('Align'),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInputPage(ColorScheme colorScheme) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
        children: [
          _sectionTitle('Text styles'),
          Text(
            'Heading',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: colorScheme.primary, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 4),
          const Text(
            'Body text có maxLines và overflow. Body text có maxLines và overflow. Body text có maxLines và overflow.',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text.rich(
            TextSpan(
              text: 'Text.rich: ',
              style: const TextStyle(fontWeight: FontWeight.bold),
              children: const [
                TextSpan(
                  text: 'italic ',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                TextSpan(
                  text: 'underline',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
                WidgetSpan(
                  child: Icon(Icons.star, size: 16, color: Colors.amber),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          const SelectableText('SelectableText: chọn copy được'),
          _sectionTitle('TextFormField'),
          TextFormField(
            controller: _textController,
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'name@gmail.com',
              prefixIcon: const Icon(Icons.email_outlined),
              helperText: 'Dùng để đăng nhập',
              counterText: '0/60',
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: _textController.clear,
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            maxLength: 60,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Email không được trống';
              if (!value.contains('@')) return 'Email phải chứa @';
              return null;
            },
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                onPressed: () {
                  setState(() => _obscurePassword = !_obscurePassword);
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.length < 6) {
                return 'Password phải ít nhất 6 ký tự';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _dropdownValue,
            decoration: const InputDecoration(
              labelText: 'Dropdown',
              prefixIcon: Icon(Icons.list),
            ),
            items: ['Option 1', 'Option 2', 'Option 3']
                .map(
                  (item) => DropdownMenuItem(
                value: item,
                child: Text(item),
              ),
            )
                .toList(),
            onChanged: (value) {
              setState(() => _dropdownValue = value ?? 'Option 1');
            },
          ),
          const SizedBox(height: 12),
          Autocomplete<String>(
            optionsBuilder: (textEditingValue) {
              if (textEditingValue.text.isEmpty) return const Iterable.empty();
              return ['Flutter', 'Dart', 'Bloc', 'Kotlin', 'Compose'].where(
                    (item) => item
                    .toLowerCase()
                    .contains(textEditingValue.text.toLowerCase()),
              );
            },
            onSelected: (value) => _showSnackBar('Autocomplete chọn: $value'),
          ),
          const SizedBox(height: 12),
          CheckboxListTile(
            value: _agree,
            onChanged: (value) => setState(() => _agree = value ?? false),
            title: const Text('Đồng ý điều khoản'),
            subtitle: const Text('CheckboxListTile'),
            secondary: const Icon(Icons.policy_outlined),
            controlAffinity: ListTileControlAffinity.trailing,
          ),
          SwitchListTile(
            value: _notifications,
            onChanged: (value) => setState(() => _notifications = value),
            title: const Text('Nhận thông báo'),
            subtitle: const Text('SwitchListTile'),
            secondary: const Icon(Icons.notifications_outlined),
          ),
          RadioListTile<int>(
            value: 0,
            groupValue: _radioValue,
            onChanged: (value) => setState(() => _radioValue = value ?? 0),
            title: const Text('Radio 0'),
            secondary: const Icon(Icons.looks_one_outlined),
          ),
          RadioListTile<int>(
            value: 1,
            groupValue: _radioValue,
            onChanged: (value) => setState(() => _radioValue = value ?? 0),
            title: const Text('Radio 1'),
            secondary: const Icon(Icons.looks_two_outlined),
          ),
          Slider(
            value: _sliderValue,
            min: 0,
            max: 100,
            divisions: 10,
            label: '${_sliderValue.round()}',
            activeColor: colorScheme.primary,
            onChanged: (value) => setState(() => _sliderValue = value),
            onChangeStart: (_) => HapticFeedback.selectionClick(),
            onChangeEnd: (_) => _showSnackBar('Slider: ${_sliderValue.round()}'),
          ),
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: _submitForm,
            icon: const Icon(Icons.check),
            label: const Text('Validate form'),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonPage(ColorScheme colorScheme) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
      children: [
        _sectionTitle('Buttons'),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _showSnackBar('ElevatedButton'),
              child: const Text('Elevated'),
            ),
            ElevatedButton.icon(
              onPressed: () => _showSnackBar('ElevatedButton.icon'),
              icon: const Icon(Icons.add),
              label: const Text('Elevated.icon'),
            ),
            FilledButton(
              onPressed: () => _showSnackBar('FilledButton'),
              child: const Text('Filled'),
            ),
            FilledButton.tonal(
              onPressed: () => _showSnackBar('FilledButton.tonal'),
              child: const Text('Tonal'),
            ),
            OutlinedButton(
              onPressed: () => _showSnackBar('OutlinedButton'),
              child: const Text('Outlined'),
            ),
            TextButton(
              onPressed: () => _showSnackBar('TextButton'),
              child: const Text('Text'),
            ),
            IconButton(
              onPressed: () => _showSnackBar('IconButton'),
              icon: const Icon(Icons.favorite_border),
              tooltip: 'IconButton',
            ),
            DropdownButton<String>(
              value: _dropdownValue,
              underline: Container(height: 1, color: colorScheme.primary),
              items: ['Option 1', 'Option 2', 'Option 3']
                  .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                  .toList(),
              onChanged: (value) {
                setState(() => _dropdownValue = value ?? 'Option 1');
              },
            ),
          ],
        ),
        _sectionTitle('Toggle / Segmented / Chips'),
        ToggleButtons(
          isSelected: _toggleButtons,
          onPressed: (index) {
            setState(() => _toggleButtons[index] = !_toggleButtons[index]);
          },
          borderRadius: BorderRadius.circular(12),
          selectedColor: Colors.white,
          fillColor: colorScheme.primary,
          children: const [
            Icon(Icons.format_bold),
            Icon(Icons.format_italic),
            Icon(Icons.format_underlined),
          ],
        ),
        const SizedBox(height: 12),
        SegmentedButton<int>(
          segments: const [
            ButtonSegment(value: 0, icon: Icon(Icons.list), label: Text('List')),
            ButtonSegment(
              value: 1,
              icon: Icon(Icons.grid_view),
              label: Text('Grid'),
            ),
            ButtonSegment(value: 2, icon: Icon(Icons.map), label: Text('Map')),
          ],
          selected: {_segmentedIndex},
          onSelectionChanged: (selection) {
            setState(() => _segmentedIndex = selection.first);
          },
          showSelectedIcon: true,
          multiSelectionEnabled: false,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            FilterChip(
              label: const Text('FilterChip'),
              selected: _selectedTags.contains(0),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedTags.add(0);
                  } else {
                    _selectedTags.remove(0);
                  }
                });
              },
            ),
            InputChip(
              label: const Text('InputChip'),
              onDeleted: () => _showSnackBar('Delete input chip'),
              onPressed: () => _showSnackBar('Press input chip'),
            ),
            ActionChip(
              label: const Text('ActionChip'),
              avatar: const Icon(Icons.bolt),
              onPressed: () => _showSnackBar('Action chip pressed'),
            ),
            ChoiceChip(
              label: const Text('ChoiceChip'),
              selected: _segmentedIndex == 0,
              onSelected: (selected) {
                if (selected) setState(() => _segmentedIndex = 0);
              },
            ),
          ],
        ),
        _sectionTitle('InkWell / GestureDetector / Material'),
        Material(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => _showSnackBar('InkWell ripple'),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.touch_app),
                  SizedBox(width: 8),
                  Text('Chạm để thấy ripple'),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () => _showSnackBar('GestureDetector onTap'),
          onLongPress: () {
            HapticFeedback.mediumImpact();
            _showSnackBar('GestureDetector onLongPress');
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: colorScheme.outline),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: const [
                Icon(Icons.gesture),
                SizedBox(width: 8),
                Text('Tap / Long press'),
              ],
            ),
          ),
        ),
        _sectionTitle('Disabled / IgnorePointer'),
        IgnorePointer(
          ignoring: !_enabled,
          child: Opacity(
            opacity: _enabled ? 1 : 0.45,
            child: FilledButton(
              onPressed: () => _showSnackBar('Button enabled'),
              child: Text('Enabled = $_enabled'),
            ),
          ),
        ),
        TextButton(
          onPressed: () => setState(() => _enabled = !_enabled),
          child: const Text('Toggle enabled'),
        ),
      ],
    );
  }

  Widget _buildListPage(ColorScheme colorScheme) {
    return Stack(
      children: [
        NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            final pixels = notification.metrics.pixels;
            if (pixels > 250 && !_showScrollTopButton) {
              setState(() => _showScrollTopButton = true);
            } else if (pixels <= 250 && _showScrollTopButton) {
              setState(() => _showScrollTopButton = false);
            }
            return false;
          },
          child: Scrollbar(
            controller: _scrollController,
            thumbVisibility: true,
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: ListView(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
                children: [
                  _sectionTitle('Horizontal ListView'),
                  SizedBox(
                    height: 110,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: 170,
                          child: Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () => _showSnackBar('Card $index'),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(Icons.image_outlined, size: 28),
                                    Text(
                                      'Card $index',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    LinearProgressIndicator(
                                      value: (index + 1) / 6,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  _sectionTitle('PageView'),
                  SizedBox(
                    height: 120,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            gradient: LinearGradient(
                              colors: [
                                colorScheme.primaryContainer,
                                colorScheme.secondaryContainer,
                              ],
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text('Page $index'),
                        );
                      },
                    ),
                  ),
                  _sectionTitle('GridView.builder'),
                  SizedBox(
                    height: 240,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 1.05,
                      ),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return GridTile(
                          header: GridTileBar(
                            backgroundColor: Colors.black45,
                            title: Text('Tile $index'),
                          ),
                          footer: const GridTileBar(
                            backgroundColor: Colors.black45,
                            trailing: Icon(Icons.favorite_border),
                          ),
                          child: ColoredBox(
                            color: colorScheme.secondaryContainer,
                          ),
                        );
                      },
                    ),
                  ),
                  _sectionTitle('Dismissible + ListTile'),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _users.length,
                    itemBuilder: (context, index) {
                      final user = _users[index];
                      return Dismissible(
                        key: ValueKey(user),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 16),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        confirmDismiss: (_) async {
                          final confirmed = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Xóa?'),
                              content: Text('Bạn có muốn xóa $user?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, false),
                                  child: const Text('Không'),
                                ),
                                FilledButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text('Có'),
                                ),
                              ],
                            ),
                          );
                          return confirmed ?? false;
                        },
                        onDismissed: (_) {
                          setState(() => _users.removeAt(index));
                          _showSnackBar('Đã xóa $user');
                        },
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                            side: BorderSide(color: colorScheme.outlineVariant),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: colorScheme.primaryContainer,
                              child: Text('${index + 1}'),
                            ),
                            title: Text(user),
                            subtitle: const Text('Vuốt trái để xóa'),
                            trailing: IconButton(
                              icon: const Icon(Icons.more_vert),
                              onPressed: () => _showSnackBar('Menu $user'),
                            ),
                            selected: index == 0,
                            onTap: () => _showSnackBar('Tap $user'),
                            onLongPress: () => HapticFeedback.mediumImpact(),
                          ),
                        ),
                      );
                    },
                  ),
                  _sectionTitle('ExpansionTile + DataTable'),
                  ExpansionTile(
                    title: const Text('ExpansionTile'),
                    subtitle: const Text('Bấm để mở rộng'),
                    leading: const Icon(Icons.expand),
                    initiallyExpanded: false,
                    children: const [
                      ListTile(title: Text('Child 1')),
                      ListTile(title: Text('Child 2')),
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      sortColumnIndex: 0,
                      sortAscending: true,
                      columns: const [
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('Role')),
                      ],
                      rows: const [
                        DataRow(
                          cells: [
                            DataCell(Text('Alice')),
                            DataCell(Text('Dev')),
                          ],
                        ),
                        DataRow(
                          selected: true,
                          cells: [
                            DataCell(Text('Bob')),
                            DataCell(Text('QA')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (_showScrollTopButton)
          Positioned(
            right: 16,
            bottom: 100,
            child: FloatingActionButton.small(
              heroTag: 'scroll_top_fab',
              tooltip: 'Scroll to top',
              onPressed: _scrollToTop,
              child: const Icon(Icons.arrow_upward),
            ),
          ),
      ],
    );
  }

  Widget _buildFeedbackPage(ColorScheme colorScheme) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
      children: [
        _sectionTitle('Loading & Progress'),
        Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 16),
            CircularProgressIndicator(value: _loadingValue),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  const LinearProgressIndicator(),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(value: _loadingValue),
                ],
              ),
            ),
          ],
        ),
        Slider(
          value: _loadingValue,
          min: 0,
          max: 1,
          divisions: 10,
          label: '${(_loadingValue * 100).round()}%',
          onChanged: (value) => setState(() => _loadingValue = value),
        ),
        _sectionTitle('Dialog / BottomSheet / Picker'),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            FilledButton(
              onPressed: _showAlertDialog,
              child: const Text('AlertDialog'),
            ),
            OutlinedButton(
              onPressed: _showModalBottomSheet,
              child: const Text('BottomSheet'),
            ),
            FilledButton.tonal(
              onPressed: _pickDate,
              child: Text(
                _selectedDate == null
                    ? 'Chọn ngày'
                    : 'Ngày: ${_selectedDate!.day}/${_selectedDate!.month}',
              ),
            ),
            OutlinedButton(
              onPressed: _pickTime,
              child: Text(
                _selectedTime == null
                    ? 'Chọn giờ'
                    : 'Giờ: ${_selectedTime!.format(context)}',
              ),
            ),
          ],
        ),
        _sectionTitle('Animated UI'),
        Row(
          children: [
            AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(milliseconds: 300),
              child: Container(width: 60, height: 60, color: colorScheme.primary),
            ),
            const SizedBox(width: 12),
            TextButton(
              onPressed: () {
                setState(() => _opacity = _opacity == 1 ? 0.2 : 1);
              },
              child: const Text('Toggle opacity'),
            ),
          ],
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 350),
          transitionBuilder: (child, animation) {
            return ScaleTransition(
              scale: animation,
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          child: _visible
              ? const Icon(
            Icons.check_circle,
            key: ValueKey('check'),
            size: 48,
            color: Colors.green,
          )
              : const Icon(
            Icons.error,
            key: ValueKey('error'),
            size: 48,
            color: Colors.red,
          ),
        ),
        TextButton(
          onPressed: () => setState(() => _visible = !_visible),
          child: const Text('Toggle icon'),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
          width: _boxExpanded ? 220 : 120,
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _animatedColor,
            borderRadius: _animatedRadius,
          ),
          child: const Text('AnimatedContainer'),
        ),
        const SizedBox(height: 12),
        AnimatedPadding(
          padding: EdgeInsets.all(_boxExpanded ? 24 : 8),
          duration: const Duration(milliseconds: 300),
          child: Container(width: 80, height: 40, color: colorScheme.tertiary),
        ),
        const SizedBox(height: 12),
        AnimatedSlide(
          offset: _boxExpanded ? const Offset(0.2, 0) : Offset.zero,
          duration: const Duration(milliseconds: 300),
          child: const Icon(Icons.rocket_launch, size: 40),
        ),
        AnimatedScale(
          scale: _boxExpanded ? 1.2 : 1,
          duration: const Duration(milliseconds: 300),
          child: const Icon(Icons.star, color: Colors.amber, size: 40),
        ),
        AnimatedRotation(
          turns: _boxExpanded ? 0.5 : 0,
          duration: const Duration(milliseconds: 300),
          child: const Icon(Icons.refresh),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            RotationTransition(
              turns: Tween(begin: 0.0, end: 1.0).animate(_animationController),
              child: const Icon(Icons.refresh, size: 36),
            ),
            const SizedBox(width: 16),
            ScaleTransition(
              scale: _animationController,
              child: const Icon(Icons.favorite, color: Colors.red),
            ),
            const SizedBox(width: 16),
            OutlinedButton(
              onPressed: () {
                setState(() {
                  if (_animationController.isAnimating) {
                    _animationController.stop();
                  } else {
                    _animationController.repeat(reverse: true);
                  }
                });
              },
              child: const Text('Start/Stop'),
            ),
          ],
        ),
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: const Duration(seconds: 1),
          builder: (context, value, child) {
            return Opacity(opacity: value, child: child);
          },
          child: const Text('TweenAnimationBuilder'),
        ),
        _sectionTitle('ShaderMask / FutureBuilder'),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.blue, Colors.purple],
          ).createShader(bounds),
          child: Text(
            'ShaderMask',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
        FutureBuilder<String>(
          future: _fakeApiFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: LinearProgressIndicator(),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(snapshot.data ?? 'No data'),
            );
          },
        ),
        _sectionTitle('UX states: visible / enabled / semantics'),
        Visibility(
          visible: _visible,
          maintainState: true,
          child: Container(
            padding: const EdgeInsets.all(12),
            color: colorScheme.secondaryContainer,
            child: const Text('Visibility widget'),
          ),
        ),
        const SizedBox(height: 12),
        Semantics(
          label: 'Nút tăng counter',
          button: true,
          child: IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () => setState(() => _counter++),
          ),
        ),
        Text('Counter: $_counter'),
        const Tooltip(
          message: 'Giữ một chút để xem tooltip',
          waitDuration: Duration(milliseconds: 300),
          child: Icon(Icons.help_outline),
        ),
      ],
    );
  }

  Widget _buildResponsivePage(ColorScheme colorScheme) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final media = MediaQuery.of(context);
            final isWide = constraints.maxWidth >= 600;
            final isDark = Theme.of(context).brightness == Brightness.dark;

            return ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
              children: [
                _sectionTitle('LayoutBuilder + MediaQuery'),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('width: ${constraints.maxWidth.toStringAsFixed(0)}'),
                        Text('height: ${constraints.maxHeight.toStringAsFixed(0)}'),
                        Text('orientation: $orientation'),
                        Text('device pixel ratio: ${media.devicePixelRatio}'),
                        Text('textScale: ${media.textScaler.scale(1).toStringAsFixed(2)}'),
                        Text('padding: ${media.padding}'),
                      ],
                    ),
                  ),
                ),
                _sectionTitle('Theme & Dark Mode'),
                SwitchListTile(
                  value: isDark,
                  onChanged: widget.onThemeModeChanged,
                  title: const Text('Dark mode'),
                  subtitle: Text('themeMode: ${widget.themeMode}'),
                  secondary: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
                ),
                _sectionTitle('Responsive by width'),
                FractionallySizedBox(
                  widthFactor: isWide ? 0.5 : 0.95,
                  alignment: Alignment.centerLeft,
                  child: FilledButton(
                    onPressed: () {},
                    child: Text(isWide ? 'Wide button 50%' : 'Narrow button 95%'),
                  ),
                ),
                _sectionTitle('SafeArea + Placeholder'),
                SafeArea(
                  child: Container(
                    height: 80,
                    alignment: Alignment.center,
                    child: const Placeholder(color: Colors.blueAccent),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}