import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/section_card.dart';

class ThemingPage extends StatelessWidget {
  const ThemingPage({super.key, required this.controller});

  final AppThemeController controller;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;

    final List<(String, Color, Color)> colorRoles = <(String, Color, Color)>[
      ('primary', cs.primary, cs.onPrimary),
      ('primaryContainer', cs.primaryContainer, cs.onPrimaryContainer),
      ('secondary', cs.secondary, cs.onSecondary),
      ('secondaryContainer', cs.secondaryContainer, cs.onSecondaryContainer),
      ('tertiary', cs.tertiary, cs.onTertiary),
      ('tertiaryContainer', cs.tertiaryContainer, cs.onTertiaryContainer),
      ('error', cs.error, cs.onError),
      ('errorContainer', cs.errorContainer, cs.onErrorContainer),
      ('surface', cs.surface, cs.onSurface),
      ('surfaceContainerLowest', cs.surfaceContainerLowest, cs.onSurface),
      ('surfaceContainerLow', cs.surfaceContainerLow, cs.onSurface),
      ('surfaceContainer', cs.surfaceContainer, cs.onSurface),
      ('surfaceContainerHigh', cs.surfaceContainerHigh, cs.onSurface),
      ('surfaceContainerHighest', cs.surfaceContainerHighest, cs.onSurface),
    ];

    final List<(String, TextStyle?)> typeScales = <(String, TextStyle?)>[
      ('Display Large (57)', tt.displayLarge),
      ('Display Medium (45)', tt.displayMedium),
      ('Display Small (36)', tt.displaySmall),
      ('Headline Large (32)', tt.headlineLarge),
      ('Headline Medium (28)', tt.headlineMedium),
      ('Headline Small (24)', tt.headlineSmall),
      ('Title Large (22)', tt.titleLarge),
      ('Title Medium (16)', tt.titleMedium),
      ('Title Small (14)', tt.titleSmall),
      ('Body Large (16)', tt.bodyLarge),
      ('Body Medium (14)', tt.bodyMedium),
      ('Body Small (12)', tt.bodySmall),
      ('Label Large (14)', tt.labelLarge),
      ('Label Medium (12)', tt.labelMedium),
      ('Label Small (11)', tt.labelSmall),
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        const ComponentCategoryHeader(
          title: 'Theme & Design Tokens',
          description:
              '实时调节 MD3 Seed Color、DynamicSchemeVariant、明暗模式、字体缩放与目标平台伪装 (iOS vs Android)。',
          icon: Icons.palette_outlined,
        ),
        SectionCard(
          title: '动态主题控制台',
          subtitle: '全局实时生效，测试所有组件在不同主题下的重绘与对比度',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('外观模式 (ThemeMode)', style: tt.labelLarge),
              const SizedBox(height: 8),
              SegmentedButton<ThemeMode>(
                segments: const <ButtonSegment<ThemeMode>>[
                  ButtonSegment<ThemeMode>(
                    value: ThemeMode.system,
                    icon: Icon(Icons.brightness_auto),
                    label: Text('跟随系统'),
                  ),
                  ButtonSegment<ThemeMode>(
                    value: ThemeMode.light,
                    icon: Icon(Icons.light_mode),
                    label: Text('浅色'),
                  ),
                  ButtonSegment<ThemeMode>(
                    value: ThemeMode.dark,
                    icon: Icon(Icons.dark_mode),
                    label: Text('深色'),
                  ),
                ],
                selected: <ThemeMode>{controller.themeMode},
                onSelectionChanged: (Set<ThemeMode> s) =>
                    controller.setThemeMode(s.first),
              ),
              const SizedBox(height: 16),
              Text('种子色彩 (ColorScheme.fromSeed)', style: tt.labelLarge),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: kSeedColorOptions.map((SeedColorOption option) {
                  final bool selected =
                      option.color == controller.seedOption.color;
                  return ChoiceChip(
                    avatar: CircleAvatar(backgroundColor: option.color),
                    label: Text(option.label),
                    selected: selected,
                    onSelected: (_) => controller.setSeedOption(option),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              Text('动态配色算法 (DynamicSchemeVariant)', style: tt.labelLarge),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: DynamicSchemeVariant.values.map(
                  (DynamicSchemeVariant variant) {
                    return ChoiceChip(
                      label: Text(variant.name),
                      selected: controller.schemeVariant == variant,
                      onSelected: (_) => controller.setSchemeVariant(variant),
                    );
                  },
                ).toList(),
              ),
              const SizedBox(height: 16),
              Text('平台交互行为模拟 (TargetPlatform)', style: tt.labelLarge),
              const SizedBox(height: 8),
              SegmentedButton<String>(
                segments: const <ButtonSegment<String>>[
                  ButtonSegment<String>(value: 'native', label: Text('原生默认')),
                  ButtonSegment<String>(value: 'ios', label: Text('强制 iOS')),
                  ButtonSegment<String>(
                    value: 'android',
                    label: Text('强制 Android'),
                  ),
                ],
                selected: <String>{
                  switch (controller.platformOverride) {
                    TargetPlatform.iOS => 'ios',
                    TargetPlatform.android => 'android',
                    _ => 'native',
                  },
                },
                onSelectionChanged: (Set<String> s) {
                  switch (s.first) {
                    case 'ios':
                      controller.setPlatformOverride(TargetPlatform.iOS);
                    case 'android':
                      controller.setPlatformOverride(TargetPlatform.android);
                    default:
                      controller.setPlatformOverride(null);
                  }
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: <Widget>[
                  Text(
                    '字体缩放: ${controller.textScale.toStringAsFixed(2)}x',
                    style: tt.labelLarge,
                  ),
                  Expanded(
                    child: Slider(
                      value: controller.textScale,
                      min: 0.85,
                      max: 1.45,
                      divisions: 12,
                      onChanged: controller.setTextScale,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SectionCard(
          title: 'MD3 Color Roles 色彩角色矩阵',
          subtitle: '包含 5 级 Surface Container 色阶与主辅色对比',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: colorRoles.map(((String, Color, Color) entry) {
              return Container(
                width: 155,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: entry.$2,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: cs.outlineVariant),
                ),
                child: Text(
                  entry.$1,
                  style: tt.labelSmall?.copyWith(
                    color: entry.$3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        SectionCard(
          title: 'Elevation & Surface Tint 层级阴影',
          subtitle: 'Level 0 ~ Level 5 在 iOS 屏幕上的阴影与表面着色表现',
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: const <double>[0, 1, 3, 6, 8, 12].map((double elev) {
              return Material(
                elevation: elev,
                surfaceTintColor: cs.surfaceTint,
                color: cs.surface,
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 96,
                  height: 70,
                  child: Center(
                    child: Text(
                      'elev ${elev.toInt()}',
                      style: tt.labelMedium,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        SectionCard(
          title: 'Typography Scale 15 级字体排版',
          subtitle: 'Display / Headline / Title / Body / Label（含中英文混排）',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: typeScales.map(((String, TextStyle?) item) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  '${item.$1} · 测试 AaBb',
                  style: item.$2,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
