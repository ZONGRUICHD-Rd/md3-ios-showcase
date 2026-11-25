import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/section_card.dart';

class IosProbePage extends StatefulWidget {
  const IosProbePage({super.key});

  @override
  State<IosProbePage> createState() => _IosProbePageState();
}

class _IosProbePageState extends State<IosProbePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  bool _animRunning = true;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _toggleAnimation() {
    setState(() {
      _animRunning = !_animRunning;
      if (_animRunning) {
        _animController.repeat();
      } else {
        _animController.stop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mq = MediaQuery.of(context);
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        const ComponentCategoryHeader(
          title: 'iOS Runtime Probe 运行环境探针',
          description:
              '实时检测 iOS 安全区、灵动岛/刘海边距、Haptic 震动反馈、Bouncing 物理回弹、右滑返回手势与 Impeller 渲染帧率。',
          icon: Icons.phone_iphone,
        ),
        SectionCard(
          title: '屏幕与安全区实时指标 (MediaQuery)',
          subtitle: '旋转屏幕或弹出键盘可实时观察数值变化',
          child: Column(
            children: <Widget>[
              _MetricRow(
                label: '实际运行平台 (defaultTargetPlatform)',
                value: defaultTargetPlatform.name,
              ),
              _MetricRow(
                label: '主题生效平台 (Theme.platform)',
                value: theme.platform.name,
              ),
              _MetricRow(
                label: '逻辑分辨率 (dp)',
                value:
                    '${mq.size.width.toStringAsFixed(1)} × ${mq.size.height.toStringAsFixed(1)}',
              ),
              _MetricRow(
                label: '像素密度 (DevicePixelRatio)',
                value: '${mq.devicePixelRatio.toStringAsFixed(2)}x',
              ),
              _MetricRow(
                label: 'Top / Bottom 安全区 (SafeArea)',
                value:
                    'Top: ${mq.padding.top.toStringAsFixed(1)}  |  Bottom: ${mq.padding.bottom.toStringAsFixed(1)}',
              ),
              _MetricRow(
                label: '系统亮度 & 字体倍率',
                value:
                    '${mq.platformBrightness.name}  |  ${mq.textScaler.scale(1.0).toStringAsFixed(2)}x',
              ),
            ],
          ),
        ),
        const SectionCard(
          title: 'iOS Taptic Engine 触感反馈测试',
          subtitle: '真机运行点击可体验不同强度的原生震动反馈',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              FilledButton.tonal(
                onPressed: HapticFeedback.lightImpact,
                child: Text('Light Impact'),
              ),
              FilledButton.tonal(
                onPressed: HapticFeedback.mediumImpact,
                child: Text('Medium Impact'),
              ),
              FilledButton.tonal(
                onPressed: HapticFeedback.heavyImpact,
                child: Text('Heavy Impact'),
              ),
              OutlinedButton(
                onPressed: HapticFeedback.selectionClick,
                child: Text('Selection Click'),
              ),
              OutlinedButton(
                onPressed: HapticFeedback.vibrate,
                child: Text('Vibrate'),
              ),
            ],
          ),
        ),
        SectionCard(
          title: 'MD3 与 Cupertino 混合路由与滚动测试',
          subtitle: '测试 iOS 边缘右滑返回与 Bouncing 弹簧滚动物理',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: <Widget>[
                  FilledButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const _SwipeBackDetailPage(
                            title: 'MaterialPageRoute (iOS 自动右滑返回)',
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.swipe_right),
                    label: const Text('Push MD3 Route'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute<void>(
                          builder: (_) => const _SwipeBackDetailPage(
                            title: 'CupertinoPageRoute (原生转场)',
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.phone_iphone),
                    label: const Text('Push Cupertino Route'),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Container(
                height: 140,
                decoration: BoxDecoration(
                  color: cs.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: cs.outlineVariant),
                ),
                child: CupertinoScrollbar(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    itemCount: 15,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        dense: true,
                        leading: const Icon(Icons.waves, size: 18),
                        title: Text('BouncingScrollPhysics 条目 #${index + 1}'),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        SectionCard(
          title: 'Impeller / Metal 动画流畅度测试',
          subtitle: '观察高刷屏幕 (120Hz ProMotion) 矢量图形旋转与渐变渲染',
          trailing: IconButton(
            onPressed: _toggleAnimation,
            icon: Icon(_animRunning ? Icons.pause : Icons.play_arrow),
            tooltip: _animRunning ? '暂停' : '播放',
          ),
          child: Center(
            child: SizedBox(
              height: 110,
              child: AnimatedBuilder(
                animation: _animController,
                builder: (BuildContext context, Widget? child) {
                  return Transform.rotate(
                    angle: _animController.value * 2 * math.pi,
                    child: child,
                  );
                },
                child: Container(
                  width: 82,
                  height: 82,
                  decoration: BoxDecoration(
                    gradient: SweepGradient(
                      colors: <Color>[
                        cs.primary,
                        cs.tertiary,
                        cs.secondary,
                        cs.primary,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Icon(
                    Icons.auto_awesome,
                    color: cs.onPrimary,
                    size: 36,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 4,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SwipeBackDetailPage extends StatelessWidget {
  const _SwipeBackDetailPage({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.swipe_right_alt,
                size: 64,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 16),
              const Text(
                '请尝试从屏幕最左侧边缘向右滑动，测试 iOS 原生交互式返回手势与页面视差过渡。',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('返回上一页'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
