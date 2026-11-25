import 'package:flutter/material.dart';
import '../widgets/section_card.dart';

class CommunicationPage extends StatefulWidget {
  const CommunicationPage({super.key});

  @override
  State<CommunicationPage> createState() => _CommunicationPageState();
}

class _CommunicationPageState extends State<CommunicationPage> {
  double _progress = 0.62;
  int _badgeCount = 7;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        const ComponentCategoryHeader(
          title: 'Communication 通信与反馈',
          description:
              '测试 Badges 徽标、Progress Indicators 进度指示器、SnackBar、MaterialBanner 与 Tooltips 在 iOS 上的展示效果。',
          icon: Icons.campaign_outlined,
        ),
        SectionCard(
          title: 'Badges 徽标',
          subtitle: '小红点、数字计数与超过 999 自动截断',
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  if (_badgeCount > 0) {
                    setState(() => _badgeCount--);
                  }
                },
                icon: const Icon(Icons.remove_circle_outline),
              ),
              IconButton(
                onPressed: () => setState(() => _badgeCount++),
                icon: const Icon(Icons.add_circle_outline),
              ),
            ],
          ),
          child: Wrap(
            spacing: 28,
            runSpacing: 16,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              const Badge(
                child: Icon(Icons.mail_outline, size: 28),
              ),
              Badge.count(
                count: _badgeCount,
                isLabelVisible: _badgeCount > 0,
                child: const Icon(Icons.notifications_none, size: 28),
              ),
              Badge.count(
                count: 1024,
                child: const Icon(Icons.forum_outlined, size: 28),
              ),
              Badge(
                label: const Text('NEW'),
                backgroundColor: colorScheme.tertiary,
                textColor: colorScheme.onTertiary,
                child: const Icon(Icons.auto_awesome_outlined, size: 28),
              ),
            ],
          ),
        ),
        SectionCard(
          title: 'Progress Indicators 进度指示器',
          subtitle: 'Linear & Circular（确定进度 / 不确定动画 / iOS 自适应对照）',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text('确定进度: ${(_progress * 100).round()}%'),
                  Expanded(
                    child: Slider(
                      value: _progress,
                      onChanged: (double v) => setState(() => _progress = v),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text('Linear Determinate / Indeterminate'),
              const SizedBox(height: 8),
              LinearProgressIndicator(value: _progress),
              const SizedBox(height: 12),
              const LinearProgressIndicator(),
              const SizedBox(height: 18),
              Wrap(
                spacing: 24,
                runSpacing: 16,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      CircularProgressIndicator(value: _progress),
                      const SizedBox(height: 6),
                      const Text('Determinate'),
                    ],
                  ),
                  const Column(
                    children: <Widget>[
                      CircularProgressIndicator(),
                      SizedBox(height: 6),
                      Text('Indeterminate'),
                    ],
                  ),
                  const Column(
                    children: <Widget>[
                      CircularProgressIndicator.adaptive(),
                      SizedBox(height: 6),
                      Text('.adaptive (iOS菊花)'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        SectionCard(
          title: 'SnackBar & MaterialBanner',
          subtitle: '测试底部安全区 (Home Indicator) 避让与操作按钮响应',
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              FilledButton.tonal(
                onPressed: () {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: const Text('标准 SnackBar（固定底部）'),
                        action: SnackBarAction(
                          label: '撤销',
                          onPressed: () {},
                        ),
                      ),
                    );
                },
                child: const Text('Fixed SnackBar'),
              ),
              FilledButton(
                onPressed: () {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        showCloseIcon: true,
                        content: const Text('悬浮 Floating SnackBar（含关闭按钮与操作）'),
                        action: SnackBarAction(
                          label: '查看',
                          onPressed: () {},
                        ),
                      ),
                    );
                },
                child: const Text('Floating SnackBar'),
              ),
              OutlinedButton(
                onPressed: () {
                  final ScaffoldMessengerState messenger =
                      ScaffoldMessenger.of(context);
                  messenger.hideCurrentMaterialBanner();
                  messenger.showMaterialBanner(
                    MaterialBanner(
                      leading: const Icon(Icons.wifi_off),
                      content: const Text(
                        'MaterialBanner：当前处于离线预览模式，可用于测试顶部横幅布局。',
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: messenger.hideCurrentMaterialBanner,
                          child: const Text('重试'),
                        ),
                        TextButton(
                          onPressed: messenger.hideCurrentMaterialBanner,
                          child: const Text('关闭'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Show Banner'),
              ),
            ],
          ),
        ),
        SectionCard(
          title: 'Tooltips 提示气泡',
          subtitle: '长按或点击触发 Plain / Rich Tooltip',
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: <Widget>[
              Tooltip(
                message: '这是一个标准 MD3 Plain Tooltip',
                triggerMode: TooltipTriggerMode.tap,
                child: FilledButton.tonalIcon(
                  onPressed: () {},
                  icon: const Icon(Icons.info_outline),
                  label: const Text('点击触发 Plain Tooltip'),
                ),
              ),
              Tooltip(
                triggerMode: TooltipTriggerMode.tap,
                richMessage: TextSpan(
                  children: <InlineSpan>[
                    const TextSpan(
                      text: 'Rich Tooltip\n',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '支持多行富文本说明与样式定制',
                      style: TextStyle(color: colorScheme.onInverseSurface),
                    ),
                  ],
                ),
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.help_outline),
                  label: const Text('点击触发 Rich Tooltip'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
