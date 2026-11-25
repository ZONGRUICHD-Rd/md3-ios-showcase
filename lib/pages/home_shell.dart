import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'actions_page.dart';
import 'communication_page.dart';
import 'containment_page.dart';
import 'inputs_page.dart';
import 'ios_probe_page.dart';
import 'navigation_page.dart';
import 'selection_page.dart';
import 'theming_page.dart';

class _ComponentIndexItem {
  const _ComponentIndexItem({
    required this.name,
    required this.category,
    required this.mainTab,
    required this.subTab,
  });

  final String name;
  final String category;
  final int mainTab;
  final int subTab;
}

const List<_ComponentIndexItem> _kComponentIndex = <_ComponentIndexItem>[
  _ComponentIndexItem(
    name: 'ElevatedButton / FilledButton / Tonal / Outlined / TextButton',
    category: 'Actions 操作',
    mainTab: 1,
    subTab: 0,
  ),
  _ComponentIndexItem(
    name: 'FloatingActionButton (Small / Standard / Large / Extended)',
    category: 'Actions 操作',
    mainTab: 1,
    subTab: 0,
  ),
  _ComponentIndexItem(
    name: 'IconButton (Standard / Filled / Tonal / Outlined)',
    category: 'Actions 操作',
    mainTab: 1,
    subTab: 0,
  ),
  _ComponentIndexItem(
    name: 'SegmentedButton 分段按钮',
    category: 'Actions 操作',
    mainTab: 1,
    subTab: 0,
  ),
  _ComponentIndexItem(
    name: 'Badge 徽标 / ProgressIndicator 进度条',
    category: 'Communication 通信',
    mainTab: 1,
    subTab: 1,
  ),
  _ComponentIndexItem(
    name: 'SnackBar / MaterialBanner / Tooltip 提示气泡',
    category: 'Communication 通信',
    mainTab: 1,
    subTab: 1,
  ),
  _ComponentIndexItem(
    name: 'Card (Elevated / Filled / Outlined)',
    category: 'Containment 容器',
    mainTab: 2,
    subTab: 0,
  ),
  _ComponentIndexItem(
    name: 'CarouselView 轮播视图',
    category: 'Containment 容器',
    mainTab: 2,
    subTab: 0,
  ),
  _ComponentIndexItem(
    name: 'AlertDialog / AlertDialog.adaptive / Full-screen Dialog',
    category: 'Containment 容器',
    mainTab: 2,
    subTab: 0,
  ),
  _ComponentIndexItem(
    name: 'ModalBottomSheet / DraggableScrollableSheet',
    category: 'Containment 容器',
    mainTab: 2,
    subTab: 0,
  ),
  _ComponentIndexItem(
    name: 'ListTile / ExpansionTile / Divider',
    category: 'Containment 容器',
    mainTab: 2,
    subTab: 0,
  ),
  _ComponentIndexItem(
    name: 'SliverAppBar.medium / SliverAppBar.large / BottomAppBar',
    category: 'Navigation 导航',
    mainTab: 2,
    subTab: 1,
  ),
  _ComponentIndexItem(
    name: 'SearchBar / SearchAnchor / TabBar / NavigationRail',
    category: 'Navigation 导航',
    mainTab: 2,
    subTab: 1,
  ),
  _ComponentIndexItem(
    name: 'Checkbox / Switch / Radio (.adaptive)',
    category: 'Selection 选择',
    mainTab: 3,
    subTab: 0,
  ),
  _ComponentIndexItem(
    name: 'ActionChip / FilterChip / ChoiceChip / InputChip',
    category: 'Selection 选择',
    mainTab: 3,
    subTab: 0,
  ),
  _ComponentIndexItem(
    name: 'Slider / RangeSlider / DatePicker / TimePicker',
    category: 'Selection 选择',
    mainTab: 3,
    subTab: 0,
  ),
  _ComponentIndexItem(
    name: 'DropdownMenu / MenuAnchor 级联菜单',
    category: 'Selection 选择',
    mainTab: 3,
    subTab: 0,
  ),
  _ComponentIndexItem(
    name: 'TextField / TextFormField (Filled / Outlined / Form)',
    category: 'Text Inputs 输入',
    mainTab: 3,
    subTab: 1,
  ),
  _ComponentIndexItem(
    name: 'ColorScheme / DynamicSchemeVariant / Typography / Elevation',
    category: 'Theme & Tokens',
    mainTab: 4,
    subTab: 0,
  ),
  _ComponentIndexItem(
    name: 'SafeArea / HapticFeedback / BouncingScroll / Impeller 帧率',
    category: 'iOS Runtime Probe',
    mainTab: 4,
    subTab: 1,
  ),
];

class HomeShell extends StatefulWidget {
  const HomeShell({super.key, required this.themeController});

  final AppThemeController themeController;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _mainIndex = 0;
  final List<int> _subTabIndices = <int>[0, 0, 0, 0, 0];

  void _navigateTo(int mainTab, [int subTab = 0]) {
    setState(() {
      _mainIndex = mainTab;
      _subTabIndices[mainTab] = subTab;
    });
  }

  int get _drawerSelectedIndex {
    return switch (_mainIndex) {
      0 => 0,
      1 => 1 + _subTabIndices[1],
      2 => 3 + _subTabIndices[2],
      3 => 5 + _subTabIndices[3],
      4 => 7 + _subTabIndices[4],
      _ => 0,
    };
  }

  void _onDrawerSelected(int drawerIndex) {
    Navigator.pop(context);
    switch (drawerIndex) {
      case 0:
        _navigateTo(0, 0);
      case 1:
        _navigateTo(1, 0);
      case 2:
        _navigateTo(1, 1);
      case 3:
        _navigateTo(2, 0);
      case 4:
        _navigateTo(2, 1);
      case 5:
        _navigateTo(3, 0);
      case 6:
        _navigateTo(3, 1);
      case 7:
        _navigateTo(4, 0);
      case 8:
        _navigateTo(4, 1);
    }
  }

  void _cycleThemeMode() {
    final ThemeMode next = switch (widget.themeController.themeMode) {
      ThemeMode.system => ThemeMode.light,
      ThemeMode.light => ThemeMode.dark,
      ThemeMode.dark => ThemeMode.system,
    };
    widget.themeController.setThemeMode(next);
  }

  IconData get _themeModeIcon {
    return switch (widget.themeController.themeMode) {
      ThemeMode.system => Icons.brightness_auto,
      ThemeMode.light => Icons.light_mode,
      ThemeMode.dark => Icons.dark_mode,
    };
  }

  @override
  Widget build(BuildContext context) {
    final bool isWide = MediaQuery.sizeOf(context).width >= 720;

    final Widget body = switch (_mainIndex) {
      0 => _CatalogOverviewPage(onNavigate: _navigateTo),
      1 => _DualTabContainer(
          tabLabels: const <String>['Actions 操作', 'Communication 通信'],
          selectedSubTab: _subTabIndices[1],
          onSubTabChanged: (int idx) =>
              setState(() => _subTabIndices[1] = idx),
          children: const <Widget>[
            ActionsPage(),
            CommunicationPage(),
          ],
        ),
      2 => _DualTabContainer(
          tabLabels: const <String>['Containment 容器', 'Navigation 导航'],
          selectedSubTab: _subTabIndices[2],
          onSubTabChanged: (int idx) =>
              setState(() => _subTabIndices[2] = idx),
          children: const <Widget>[
            ContainmentPage(),
            NavigationPage(),
          ],
        ),
      3 => _DualTabContainer(
          tabLabels: const <String>['Selection 选择', 'Text Inputs 输入'],
          selectedSubTab: _subTabIndices[3],
          onSubTabChanged: (int idx) =>
              setState(() => _subTabIndices[3] = idx),
          children: const <Widget>[
            SelectionPage(),
            InputsPage(),
          ],
        ),
      _ => _DualTabContainer(
          tabLabels: const <String>['Theme & Tokens', 'iOS Probe 探针'],
          selectedSubTab: _subTabIndices[4],
          onSubTabChanged: (int idx) =>
              setState(() => _subTabIndices[4] = idx),
          children: <Widget>[
            ThemingPage(controller: widget.themeController),
            const IosProbePage(),
          ],
        ),
    };

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          tooltip: '打开 NavigationDrawer',
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        title: const Text('MD3 iOS Showcase'),
        actions: <Widget>[
          IconButton(
            tooltip: '切换亮色/暗色/跟随系统',
            icon: Icon(_themeModeIcon),
            onPressed: _cycleThemeMode,
          ),
          IconButton(
            tooltip: 'iOS 运行环境探针',
            icon: const Icon(Icons.phone_iphone),
            onPressed: () => _navigateTo(4, 1),
          ),
        ],
      ),
      drawer: NavigationDrawer(
        selectedIndex: _drawerSelectedIndex,
        onDestinationSelected: _onDrawerSelected,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
            child: Text(
              'Material Design 3 目录',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view),
            label: Text('组件总览 Catalog'),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 8, 28, 8),
            child: Divider(),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.touch_app_outlined),
            selectedIcon: Icon(Icons.touch_app),
            label: Text('Actions 操作按钮'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.campaign_outlined),
            selectedIcon: Icon(Icons.campaign),
            label: Text('Communication 通信反馈'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: Text('Containment 容器与弹窗'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore),
            label: Text('Navigation 导航组件'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.tune_outlined),
            selectedIcon: Icon(Icons.tune),
            label: Text('Selection 选择与日期'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.keyboard_alt_outlined),
            selectedIcon: Icon(Icons.keyboard_alt),
            label: Text('Text Inputs 文本输入'),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 8, 28, 8),
            child: Divider(),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.palette_outlined),
            selectedIcon: Icon(Icons.palette),
            label: Text('Theme & Tokens 主题'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.phone_iphone),
            selectedIcon: Icon(Icons.phone_iphone),
            label: Text('iOS Runtime Probe 探针'),
          ),
        ],
      ),
      body: isWide
          ? Row(
              children: <Widget>[
                NavigationRail(
                  selectedIndex: _mainIndex,
                  labelType: NavigationRailLabelType.all,
                  onDestinationSelected: (int index) =>
                      setState(() => _mainIndex = index),
                  destinations: const <NavigationRailDestination>[
                    NavigationRailDestination(
                      icon: Icon(Icons.grid_view_outlined),
                      selectedIcon: Icon(Icons.grid_view),
                      label: Text('总览'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.touch_app_outlined),
                      selectedIcon: Icon(Icons.touch_app),
                      label: Text('操作反馈'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.dashboard_outlined),
                      selectedIcon: Icon(Icons.dashboard),
                      label: Text('容器导航'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.tune_outlined),
                      selectedIcon: Icon(Icons.tune),
                      label: Text('选择输入'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.phone_iphone),
                      selectedIcon: Icon(Icons.phone_iphone),
                      label: Text('主题/iOS'),
                    ),
                  ],
                ),
                const VerticalDivider(width: 1),
                Expanded(child: body),
              ],
            )
          : body,
      bottomNavigationBar: isWide
          ? null
          : NavigationBar(
              selectedIndex: _mainIndex,
              onDestinationSelected: (int index) =>
                  setState(() => _mainIndex = index),
              destinations: const <Widget>[
                NavigationDestination(
                  icon: Icon(Icons.grid_view_outlined),
                  selectedIcon: Icon(Icons.grid_view),
                  label: '总览',
                ),
                NavigationDestination(
                  icon: Badge(child: Icon(Icons.touch_app_outlined)),
                  selectedIcon: Icon(Icons.touch_app),
                  label: '操作反馈',
                ),
                NavigationDestination(
                  icon: Icon(Icons.dashboard_outlined),
                  selectedIcon: Icon(Icons.dashboard),
                  label: '容器导航',
                ),
                NavigationDestination(
                  icon: Icon(Icons.tune_outlined),
                  selectedIcon: Icon(Icons.tune),
                  label: '选择输入',
                ),
                NavigationDestination(
                  icon: Icon(Icons.phone_iphone),
                  selectedIcon: Icon(Icons.phone_iphone),
                  label: '主题/iOS',
                ),
              ],
            ),
    );
  }
}

class _DualTabContainer extends StatefulWidget {
  const _DualTabContainer({
    required this.tabLabels,
    required this.selectedSubTab,
    required this.onSubTabChanged,
    required this.children,
  });

  final List<String> tabLabels;
  final int selectedSubTab;
  final ValueChanged<int> onSubTabChanged;
  final List<Widget> children;

  @override
  State<_DualTabContainer> createState() => _DualTabContainerState();
}

class _DualTabContainerState extends State<_DualTabContainer>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: widget.children.length,
      vsync: this,
      initialIndex: widget.selectedSubTab,
    );
    _controller.addListener(() {
      if (!_controller.indexIsChanging &&
          _controller.index != widget.selectedSubTab) {
        widget.onSubTabChanged(_controller.index);
      }
    });
  }

  @override
  void didUpdateWidget(covariant _DualTabContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedSubTab != _controller.index) {
      _controller.animateTo(widget.selectedSubTab);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TabBar.secondary(
          controller: _controller,
          tabs: widget.tabLabels
              .map((String label) => Tab(text: label))
              .toList(),
        ),
        Expanded(
          child: TabBarView(
            controller: _controller,
            children: widget.children,
          ),
        ),
      ],
    );
  }
}

class _CatalogOverviewPage extends StatelessWidget {
  const _CatalogOverviewPage({required this.onNavigate});

  final void Function(int mainTab, int subTab) onNavigate;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;

    final List<({String title, String subtitle, IconData icon, int main, int sub})>
        categories =
        <({String title, String subtitle, IconData icon, int main, int sub})>[
      (
        title: 'Actions 操作',
        subtitle: 'Buttons, FABs, IconButtons, Segmented',
        icon: Icons.touch_app_outlined,
        main: 1,
        sub: 0,
      ),
      (
        title: 'Communication 通信',
        subtitle: 'Badges, Progress, SnackBar, Banner, Tooltip',
        icon: Icons.campaign_outlined,
        main: 1,
        sub: 1,
      ),
      (
        title: 'Containment 容器',
        subtitle: 'Cards, CarouselView, BottomSheet, Dialogs, List',
        icon: Icons.dashboard_outlined,
        main: 2,
        sub: 0,
      ),
      (
        title: 'Navigation 导航',
        subtitle: 'AppBars, BottomAppBar, Tabs, Search, NavRail',
        icon: Icons.explore_outlined,
        main: 2,
        sub: 1,
      ),
      (
        title: 'Selection 选择',
        subtitle: 'Checkbox, Switch, Radio, Chips, Sliders, Pickers',
        icon: Icons.tune_outlined,
        main: 3,
        sub: 0,
      ),
      (
        title: 'Text Inputs 输入',
        subtitle: 'Filled/Outlined TextField, Form, iOS Keyboard',
        icon: Icons.keyboard_alt_outlined,
        main: 3,
        sub: 1,
      ),
      (
        title: 'Theme & Tokens',
        subtitle: 'Seed Color, 9 Scheme Variants, 15 Type Scales',
        icon: Icons.palette_outlined,
        main: 4,
        sub: 0,
      ),
      (
        title: 'iOS Runtime Probe',
        subtitle: 'SafeArea, Haptics, Bouncing, Swipe-Back, Impeller',
        icon: Icons.phone_iphone,
        main: 4,
        sub: 1,
      ),
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        Card.filled(
          color: cs.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Material Design 3 × iOS 全组件测试套件',
                  style: tt.titleLarge?.copyWith(
                    color: cs.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '覆盖 MD3 规范全部分类组件及 iOS 自适应控件 (.adaptive)、安全区、触感反馈与 Impeller 渲染检测。',
                  style: tt.bodyMedium?.copyWith(
                    color: cs.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),
        SearchAnchor.bar(
          barHintText: '快速跳转到任意 MD3 组件 (如 Carousel / DatePicker)...',
          suggestionsBuilder: (
            BuildContext context,
            SearchController controller,
          ) {
            final String q = controller.text.trim().toLowerCase();
            final Iterable<_ComponentIndexItem> matches =
                _kComponentIndex.where(
              (_ComponentIndexItem item) =>
                  item.name.toLowerCase().contains(q) ||
                  item.category.toLowerCase().contains(q),
            );
            return matches.map((_ComponentIndexItem item) {
              return ListTile(
                leading: const Icon(Icons.arrow_forward),
                title: Text(item.name),
                subtitle: Text(item.category),
                onTap: () {
                  controller.closeView(null);
                  onNavigate(item.mainTab, item.subTab);
                },
              );
            });
          },
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final int crossAxisCount = constraints.maxWidth >= 680 ? 4 : 2;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categories.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.15,
              ),
              itemBuilder: (BuildContext context, int index) {
                final item = categories[index];
                return Card.outlined(
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () => onNavigate(item.main, item.sub),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(item.icon, color: cs.primary, size: 28),
                          const Spacer(),
                          Text(
                            item.title,
                            style: tt.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.subtitle,
                            style: tt.bodySmall?.copyWith(
                              color: cs.onSurfaceVariant,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
