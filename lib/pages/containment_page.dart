import 'package:flutter/material.dart';
import '../widgets/section_card.dart';

class ContainmentPage extends StatefulWidget {
  const ContainmentPage({super.key});

  @override
  State<ContainmentPage> createState() => _ContainmentPageState();
}

class _ContainmentPageState extends State<ContainmentPage> {
  bool _tileSwitch = true;

  void _showBasicDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          icon: const Icon(Icons.delete_outline),
          title: const Text('MD3 AlertDialog'),
          content: const Text(
            '这是标准的 Material Design 3 弹窗，带有顶部图标、圆角表面容器与操作按钮。',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('取消'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('确认'),
            ),
          ],
        );
      },
    );
  }

  void _showAdaptiveDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog.adaptive(
          title: const Text('AlertDialog.adaptive'),
          content: const Text(
            '在 iOS 平台上会自动渲染为原生 CupertinoAlertDialog 风格，切换到 Android 平台则为 MD3 样式。',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('好'),
            ),
          ],
        );
      },
    );
  }

  void _showFullscreenDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog.fullscreen(
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(dialogContext),
              ),
              title: const Text('Full-screen Dialog'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('保存'),
                ),
              ],
            ),
            body: ListView(
              padding: const EdgeInsets.all(20),
              children: const <Widget>[
                TextField(
                  decoration: InputDecoration(
                    labelText: '日程标题',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: '备注内容',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showModalSheet({required bool draggable}) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: draggable,
      builder: (BuildContext sheetContext) {
        if (!draggable) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.share_outlined),
                  title: const Text('分享到 AirDrop'),
                  onTap: () => Navigator.pop(sheetContext),
                ),
                ListTile(
                  leading: const Icon(Icons.link),
                  title: const Text('复制链接'),
                  onTap: () => Navigator.pop(sheetContext),
                ),
                ListTile(
                  leading: const Icon(Icons.download_outlined),
                  title: const Text('保存到文件'),
                  onTap: () => Navigator.pop(sheetContext),
                ),
                const SizedBox(height: 8),
              ],
            ),
          );
        }

        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.5,
          minChildSize: 0.35,
          maxChildSize: 0.9,
          builder: (BuildContext context, ScrollController scrollController) {
            return ListView.builder(
              controller: scrollController,
              itemCount: 24,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(child: Text('${index + 1}')),
                  title: Text('可拖拽列表项 #${index + 1}'),
                  subtitle: const Text('测试 iOS 惯性滚动与拖拽手柄阻尼'),
                  onTap: () => Navigator.pop(sheetContext),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        const ComponentCategoryHeader(
          title: 'Containment 容器与展示',
          description:
              '测试 Cards、MD3 CarouselView、Bottom Sheets、Dialogs（含 iOS 自适应弹窗）、Lists、ExpansionTile 与 Dividers。',
          icon: Icons.dashboard_outlined,
        ),
        SectionCard(
          title: 'Cards 卡片变体',
          subtitle: 'Elevated / Filled / Outlined',
          child: Column(
            children: <Widget>[
              Card(
                child: ListTile(
                  leading: const Icon(Icons.layers_outlined),
                  title: const Text('Elevated Card'),
                  subtitle: const Text('默认阴影 + 表面色调提升'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
              ),
              const SizedBox(height: 8),
              Card.filled(
                child: ListTile(
                  leading: const Icon(Icons.palette_outlined),
                  title: const Text('Filled Card'),
                  subtitle: const Text('使用 surfaceContainerHighest 填充'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
              ),
              const SizedBox(height: 8),
              Card.outlined(
                child: ListTile(
                  leading: const Icon(Icons.crop_square),
                  title: const Text('Outlined Card'),
                  subtitle: const Text('1dp outlineVariant 描边轮廓'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
        SectionCard(
          title: 'CarouselView 轮播视图',
          subtitle: 'Flutter 3.24+ 官方 MD3 Carousel（滑动测试 iOS 弹性手感）',
          child: SizedBox(
            height: 170,
            child: CarouselView(
              itemExtent: 230,
              shrinkExtent: 140,
              onTap: (int index) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text('点击了 Carousel 卡片 #${index + 1}'),
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(milliseconds: 1100),
                    ),
                  );
              },
              children: List<Widget>.generate(6, (int index) {
                final List<Color> palette = <Color>[
                  colorScheme.primaryContainer,
                  colorScheme.secondaryContainer,
                  colorScheme.tertiaryContainer,
                  colorScheme.surfaceContainerHighest,
                  colorScheme.primary.withValues(alpha: 0.25),
                  colorScheme.tertiary.withValues(alpha: 0.25),
                ];
                return Container(
                  color: palette[index % palette.length],
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'MD3 Card ${index + 1}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        'Hero / Uncontained Item',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
        SectionCard(
          title: 'Dialogs & Bottom Sheets 弹窗与抽屉',
          subtitle: '测试 iOS 模态弹出、自适应 Cupertino 弹窗及全屏弹窗',
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              FilledButton(
                onPressed: _showBasicDialog,
                child: const Text('AlertDialog'),
              ),
              FilledButton.tonal(
                onPressed: _showAdaptiveDialog,
                child: const Text('Adaptive Dialog'),
              ),
              OutlinedButton(
                onPressed: _showFullscreenDialog,
                child: const Text('Full-screen Dialog'),
              ),
              FilledButton.tonalIcon(
                onPressed: () => _showModalSheet(draggable: false),
                icon: const Icon(Icons.vertical_align_bottom),
                label: const Text('Modal Sheet'),
              ),
              OutlinedButton.icon(
                onPressed: () => _showModalSheet(draggable: true),
                icon: const Icon(Icons.drag_handle),
                label: const Text('Draggable Sheet'),
              ),
            ],
          ),
        ),
        SectionCard(
          title: 'Lists, ExpansionTile & Dividers',
          subtitle: '单行 / 双行 / 三行列表项、折叠面板与分割线',
          child: Column(
            children: <Widget>[
              const ListTile(
                leading: CircleAvatar(child: Text('A')),
                title: Text('单行列表项 (One-line)'),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
              ),
              const Divider(indent: 16, endIndent: 16),
              SwitchListTile(
                secondary: const Icon(Icons.notifications_active_outlined),
                title: const Text('双行带开关列表 (Two-line)'),
                subtitle: const Text('实时切换测试列表交互'),
                value: _tileSwitch,
                onChanged: (bool v) => setState(() => _tileSwitch = v),
              ),
              const Divider(indent: 16, endIndent: 16),
              ListTile(
                isThreeLine: true,
                leading: const Icon(Icons.article_outlined),
                title: const Text('三行列表项 (Three-line)'),
                subtitle: const Text(
                  'Material Design 3 会自动根据三行文本调整顶部对齐与垂直间距，确保排版舒适。',
                ),
                trailing: Badge.count(count: 3),
              ),
              const Divider(),
              const ExpansionTile(
                leading: Icon(Icons.expand_more),
                title: Text('ExpansionTile 折叠展开'),
                subtitle: Text('点击展开查看内部子项'),
                children: <Widget>[
                  ListTile(
                    title: Text('子项 1：iOS 流畅高度动画'),
                    dense: true,
                  ),
                  ListTile(
                    title: Text('子项 2：Shape & Divider 自动处理'),
                    dense: true,
                  ),
                  SizedBox(
                    height: 36,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('左侧内容'),
                        VerticalDivider(),
                        Text('右侧内容'),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
