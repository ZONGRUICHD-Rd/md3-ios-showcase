import 'package:flutter/material.dart';
import '../widgets/section_card.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage>
    with TickerProviderStateMixin {
  late final TabController _primaryTabController;
  late final TabController _secondaryTabController;
  int _railIndex = 0;
  NavigationRailLabelType _railLabelType = NavigationRailLabelType.selected;

  static const List<String> _searchItems = <String>[
    'FilledButton',
    'FloatingActionButton',
    'NavigationBar',
    'NavigationRail',
    'CarouselView',
    'DatePicker',
    'TimePicker',
    'SearchAnchor',
    'SegmentedButton',
    'SnackBar',
    'Switch.adaptive',
    'TextField',
  ];

  @override
  void initState() {
    super.initState();
    _primaryTabController = TabController(length: 3, vsync: this);
    _secondaryTabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _primaryTabController.dispose();
    _secondaryTabController.dispose();
    super.dispose();
  }

  void _openSliverAppBarDemo(String mode) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => _SliverAppBarDemoPage(mode: mode),
      ),
    );
  }

  void _openBottomAppBarDemo() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const _BottomAppBarDemoPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        const ComponentCategoryHeader(
          title: 'Navigation 导航组件',
          description:
              '测试 Top AppBar (Small/Medium/Large)、BottomAppBar、Primary/Secondary Tabs、SearchBar 与 NavigationRail。',
          icon: Icons.explore_outlined,
        ),
        SectionCard(
          title: 'Top & Bottom App Bars 独立演示页',
          subtitle: '点击进入子页面，同时可测试 iOS 边缘右滑返回 (Swipe Back)',
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              FilledButton.icon(
                onPressed: () => _openSliverAppBarDemo('medium'),
                icon: const Icon(Icons.view_agenda_outlined),
                label: const Text('SliverAppBar.medium'),
              ),
              FilledButton.tonalIcon(
                onPressed: () => _openSliverAppBarDemo('large'),
                icon: const Icon(Icons.view_day_outlined),
                label: const Text('SliverAppBar.large'),
              ),
              OutlinedButton.icon(
                onPressed: _openBottomAppBarDemo,
                icon: const Icon(Icons.dock_outlined),
                label: const Text('BottomAppBar + FAB'),
              ),
            ],
          ),
        ),
        SectionCard(
          title: 'SearchBar & SearchAnchor 搜索框',
          subtitle: '点击输入文字测试 MD3 全屏搜索视图与 iOS 键盘弹出',
          child: SearchAnchor.bar(
            barHintText: '搜索 MD3 组件...',
            suggestionsBuilder: (
              BuildContext context,
              SearchController controller,
            ) {
              final String query = controller.text.toLowerCase();
              final Iterable<String> matches = _searchItems.where(
                (String item) => item.toLowerCase().contains(query),
              );
              return matches.map(
                (String item) => ListTile(
                  leading: const Icon(Icons.widgets_outlined),
                  title: Text(item),
                  onTap: () {
                    controller.closeView(item);
                  },
                ),
              );
            },
          ),
        ),
        SectionCard(
          title: 'Tabs 选项卡',
          subtitle: 'MD3 Primary TabBar（带图标）与 Secondary TabBar（可滚动）',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TabBar(
                controller: _primaryTabController,
                tabs: const <Widget>[
                  Tab(icon: Icon(Icons.flight), text: '航班'),
                  Tab(icon: Icon(Icons.hotel), text: '酒店'),
                  Tab(icon: Icon(Icons.explore), text: '探索'),
                ],
              ),
              SizedBox(
                height: 64,
                child: TabBarView(
                  controller: _primaryTabController,
                  children: const <Widget>[
                    Center(child: Text('Primary Tab 1: 航班动态')),
                    Center(child: Text('Primary Tab 2: 酒店预订')),
                    Center(child: Text('Primary Tab 3: 目的地探索')),
                  ],
                ),
              ),
              const Divider(),
              TabBar.secondary(
                controller: _secondaryTabController,
                isScrollable: true,
                tabs: const <Widget>[
                  Tab(text: '全部组件'),
                  Tab(text: 'iOS 适配'),
                  Tab(text: '深色模式'),
                  Tab(text: '动效与手势'),
                ],
              ),
              SizedBox(
                height: 52,
                child: TabBarView(
                  controller: _secondaryTabController,
                  children: const <Widget>[
                    Center(child: Text('Secondary Tab: 全部组件')),
                    Center(child: Text('Secondary Tab: iOS 适配')),
                    Center(child: Text('Secondary Tab: 深色模式')),
                    Center(child: Text('Secondary Tab: 动效与手势')),
                  ],
                ),
              ),
            ],
          ),
        ),
        SectionCard(
          title: 'NavigationRail 侧边导航栏内嵌预览',
          subtitle: '切换标签显示模式，模拟平板 / 横屏布局',
          trailing: SegmentedButton<NavigationRailLabelType>(
            segments: const <ButtonSegment<NavigationRailLabelType>>[
              ButtonSegment<NavigationRailLabelType>(
                value: NavigationRailLabelType.none,
                label: Text('无'),
              ),
              ButtonSegment<NavigationRailLabelType>(
                value: NavigationRailLabelType.selected,
                label: Text('选中'),
              ),
              ButtonSegment<NavigationRailLabelType>(
                value: NavigationRailLabelType.all,
                label: Text('全部'),
              ),
            ],
            selected: <NavigationRailLabelType>{_railLabelType},
            onSelectionChanged: (Set<NavigationRailLabelType> s) {
              setState(() => _railLabelType = s.first);
            },
          ),
          child: SizedBox(
            height: 250,
            child: Row(
              children: <Widget>[
                NavigationRail(
                  selectedIndex: _railIndex,
                  labelType: _railLabelType,
                  leading: FloatingActionButton.small(
                    heroTag: 'rail_fab_preview',
                    onPressed: () {},
                    child: const Icon(Icons.edit),
                  ),
                  onDestinationSelected: (int index) {
                    setState(() => _railIndex = index);
                  },
                  destinations: const <NavigationRailDestination>[
                    NavigationRailDestination(
                      icon: Icon(Icons.inbox_outlined),
                      selectedIcon: Icon(Icons.inbox),
                      label: Text('收件箱'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.send_outlined),
                      selectedIcon: Icon(Icons.send),
                      label: Text('已发送'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.delete_outline),
                      selectedIcon: Icon(Icons.delete),
                      label: Text('回收站'),
                    ),
                  ],
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  child: Center(
                    child: Text(
                      'NavigationRail 当前页: #${_railIndex + 1}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SliverAppBarDemoPage extends StatelessWidget {
  const _SliverAppBarDemoPage({required this.mode});

  final String mode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          if (mode == 'medium')
            SliverAppBar.medium(
              title: const Text('SliverAppBar.medium'),
              actions: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            )
          else
            SliverAppBar.large(
              title: const Text('SliverAppBar.large'),
              actions: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
          SliverList.builder(
            itemCount: 30,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: Text('滚动条目 #${index + 1}'),
                subtitle: const Text('向上滑动测试 AppBar 折叠吸顶效果，从屏幕左边缘右滑返回'),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _BottomAppBarDemoPage extends StatelessWidget {
  const _BottomAppBarDemoPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BottomAppBar Demo')),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            '观察底部 BottomAppBar 在 iOS Home Indicator 安全区域上的自动留白与 FAB 停靠效果。',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'bottom_app_bar_fab',
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
              tooltip: 'Menu',
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
              tooltip: 'Search',
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_border),
              tooltip: 'Favorite',
            ),
          ],
        ),
      ),
    );
  }
}
