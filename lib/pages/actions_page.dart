import 'package:flutter/material.dart';
import '../widgets/section_card.dart';

class ActionsPage extends StatefulWidget {
  const ActionsPage({super.key});

  @override
  State<ActionsPage> createState() => _ActionsPageState();
}

class _ActionsPageState extends State<ActionsPage> {
  bool _isLoading = false;
  bool _iconSelected1 = false;
  bool _iconSelected2 = true;
  bool _iconSelected3 = false;
  bool _iconSelected4 = true;

  String _singleSegment = 'day';
  Set<String> _multiSegments = <String>{'s', 'l'};

  void _showTapSnack(String label) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('Triggered: $label'),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(milliseconds: 1200),
        ),
      );
  }

  Future<void> _simulateLoading() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);
    await Future<void>.delayed(const Duration(milliseconds: 1200));
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        const ComponentCategoryHeader(
          title: 'Actions 操作组件',
          description:
              '测试 MD3 Common Buttons、FAB 全尺寸族、Icon Buttons（含选中态切换）及 Segmented Buttons 在 iOS 触摸反馈与水波纹下的表现。',
          icon: Icons.touch_app_outlined,
        ),
        SectionCard(
          title: 'Common Buttons 常规按钮',
          subtitle: 'Elevated / Filled / Filled Tonal / Outlined / Text（含禁用与图标）',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () => _showTapSnack('ElevatedButton'),
                    child: const Text('Elevated'),
                  ),
                  FilledButton(
                    onPressed: () => _showTapSnack('FilledButton'),
                    child: const Text('Filled'),
                  ),
                  FilledButton.tonal(
                    onPressed: () => _showTapSnack('FilledButton.tonal'),
                    child: const Text('Tonal'),
                  ),
                  OutlinedButton(
                    onPressed: () => _showTapSnack('OutlinedButton'),
                    child: const Text('Outlined'),
                  ),
                  TextButton(
                    onPressed: () => _showTapSnack('TextButton'),
                    child: const Text('Text'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: <Widget>[
                  ElevatedButton.icon(
                    onPressed: () => _showTapSnack('Elevated.icon'),
                    icon: const Icon(Icons.add),
                    label: const Text('Elevated'),
                  ),
                  FilledButton.icon(
                    onPressed: _simulateLoading,
                    icon: _isLoading
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.bolt),
                    label: Text(_isLoading ? 'Loading...' : 'Async Action'),
                  ),
                  FilledButton.tonalIcon(
                    onPressed: () => _showTapSnack('Tonal.icon'),
                    icon: const Icon(Icons.bookmark_border),
                    label: const Text('Save'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => _showTapSnack('Outlined.icon'),
                    icon: const Icon(Icons.share_outlined),
                    label: const Text('Share'),
                  ),
                  TextButton.icon(
                    onPressed: () => _showTapSnack('Text.icon'),
                    icon: const Icon(Icons.open_in_new),
                    label: const Text('Details'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Wrap(
                spacing: 10,
                runSpacing: 10,
                children: <Widget>[
                  ElevatedButton(onPressed: null, child: Text('Disabled')),
                  FilledButton(onPressed: null, child: Text('Disabled')),
                  FilledButton.tonal(onPressed: null, child: Text('Disabled')),
                  OutlinedButton(onPressed: null, child: Text('Disabled')),
                  TextButton(onPressed: null, child: Text('Disabled')),
                ],
              ),
            ],
          ),
        ),
        SectionCard(
          title: 'Floating Action Buttons (FAB)',
          subtitle: 'Small (40dp) / Standard (56dp) / Large (96dp) / Extended',
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              FloatingActionButton.small(
                heroTag: 'fab_small',
                onPressed: () => _showTapSnack('FAB Small'),
                tooltip: 'Small FAB',
                child: const Icon(Icons.edit_outlined),
              ),
              FloatingActionButton(
                heroTag: 'fab_std',
                onPressed: () => _showTapSnack('FAB Standard'),
                tooltip: 'Standard FAB',
                child: const Icon(Icons.add),
              ),
              FloatingActionButton.large(
                heroTag: 'fab_large',
                onPressed: () => _showTapSnack('FAB Large'),
                tooltip: 'Large FAB',
                child: const Icon(Icons.camera_alt_outlined),
              ),
              FloatingActionButton.extended(
                heroTag: 'fab_ext',
                onPressed: () => _showTapSnack('FAB Extended'),
                icon: const Icon(Icons.navigation_outlined),
                label: const Text('Navigate'),
              ),
            ],
          ),
        ),
        SectionCard(
          title: 'Icon Buttons 图标按钮',
          subtitle: 'Standard / Filled / Filled Tonal / Outlined（点击测试选中态切换）',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: <Widget>[
                  IconButton(
                    isSelected: _iconSelected1,
                    icon: const Icon(Icons.favorite_border),
                    selectedIcon: const Icon(Icons.favorite),
                    onPressed: () =>
                        setState(() => _iconSelected1 = !_iconSelected1),
                    tooltip: 'Standard Toggle',
                  ),
                  IconButton.filled(
                    isSelected: _iconSelected2,
                    icon: const Icon(Icons.bookmark_border),
                    selectedIcon: const Icon(Icons.bookmark),
                    onPressed: () =>
                        setState(() => _iconSelected2 = !_iconSelected2),
                    tooltip: 'Filled Toggle',
                  ),
                  IconButton.filledTonal(
                    isSelected: _iconSelected3,
                    icon: const Icon(Icons.notifications_none),
                    selectedIcon: const Icon(Icons.notifications_active),
                    onPressed: () =>
                        setState(() => _iconSelected3 = !_iconSelected3),
                    tooltip: 'Filled Tonal Toggle',
                  ),
                  IconButton.outlined(
                    isSelected: _iconSelected4,
                    icon: const Icon(Icons.star_outline),
                    selectedIcon: const Icon(Icons.star),
                    onPressed: () =>
                        setState(() => _iconSelected4 = !_iconSelected4),
                    tooltip: 'Outlined Toggle',
                  ),
                  const IconButton(
                    onPressed: null,
                    icon: Icon(Icons.block),
                    tooltip: 'Disabled',
                  ),
                  const IconButton.filled(
                    onPressed: null,
                    icon: Icon(Icons.block),
                  ),
                ],
              ),
            ],
          ),
        ),
        SectionCard(
          title: 'Segmented Buttons 分段按钮',
          subtitle: '单选 (Single-select) 与多选 (Multi-select) 模式',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '单选：当前选中 $_singleSegment',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 8),
              SegmentedButton<String>(
                segments: const <ButtonSegment<String>>[
                  ButtonSegment<String>(
                    value: 'day',
                    label: Text('Day'),
                    icon: Icon(Icons.calendar_view_day),
                  ),
                  ButtonSegment<String>(
                    value: 'week',
                    label: Text('Week'),
                    icon: Icon(Icons.calendar_view_week),
                  ),
                  ButtonSegment<String>(
                    value: 'month',
                    label: Text('Month'),
                    icon: Icon(Icons.calendar_month),
                  ),
                ],
                selected: <String>{_singleSegment},
                onSelectionChanged: (Set<String> next) {
                  setState(() => _singleSegment = next.first);
                },
              ),
              const SizedBox(height: 16),
              Text(
                '多选：已选 ${_multiSegments.join(', ')}',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 8),
              SegmentedButton<String>(
                multiSelectionEnabled: true,
                emptySelectionAllowed: true,
                segments: const <ButtonSegment<String>>[
                  ButtonSegment<String>(value: 'xs', label: Text('XS')),
                  ButtonSegment<String>(value: 's', label: Text('S')),
                  ButtonSegment<String>(value: 'm', label: Text('M')),
                  ButtonSegment<String>(value: 'l', label: Text('L')),
                  ButtonSegment<String>(value: 'xl', label: Text('XL')),
                ],
                selected: _multiSegments,
                onSelectionChanged: (Set<String> next) {
                  setState(() => _multiSegments = next);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
