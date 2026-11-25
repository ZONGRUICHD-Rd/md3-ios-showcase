import 'package:flutter_test/flutter_test.dart';
import 'package:md3_ios_showcase/main.dart';

void main() {
  testWidgets('MD3 Showcase renders all tabs without errors', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const Md3ShowcaseApp());
    await tester.pumpAndSettle();

    expect(find.text('MD3 iOS Showcase'), findsOneWidget);
    expect(find.text('Actions 操作'), findsOneWidget);

    // Switch to Actions & Communication tab
    await tester.tap(find.text('操作反馈'));
    await tester.pumpAndSettle();
    expect(find.text('Common Buttons 常规按钮'), findsOneWidget);

    await tester.tap(find.text('Communication 通信'));
    await tester.pumpAndSettle();
    expect(find.text('Badges 徽标'), findsOneWidget);

    // Switch to Containment & Navigation tab
    await tester.tap(find.text('容器导航'));
    await tester.pumpAndSettle();
    expect(find.text('Cards 卡片变体'), findsOneWidget);

    await tester.tap(find.text('Navigation 导航'));
    await tester.pumpAndSettle();
    expect(find.text('SearchBar & SearchAnchor 搜索框'), findsOneWidget);

    // Switch to Selection & Inputs tab
    await tester.tap(find.text('选择输入'));
    await tester.pumpAndSettle();
    expect(find.text('Checkboxes & Switches 复选框与开关'), findsOneWidget);

    await tester.tap(find.text('Text Inputs 输入'));
    await tester.pumpAndSettle();
    expect(find.text('Filled & Outlined TextFields'), findsOneWidget);

    // Switch to Theme & iOS Probe tab (use bounded pump due to repeating animation)
    await tester.tap(find.text('主题/iOS'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('动态主题控制台'), findsOneWidget);

    await tester.tap(find.text('iOS Probe 探针'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('屏幕与安全区实时指标 (MediaQuery)'), findsOneWidget);

    // Verify theme mode toggle button works
    await tester.tap(find.byTooltip('切换亮色/暗色/跟随系统'));
    await tester.pump(const Duration(milliseconds: 200));
    expect(tester.takeException(), isNull);
  });
}
