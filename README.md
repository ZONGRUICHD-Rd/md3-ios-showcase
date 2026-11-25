# Material Design 3 iOS Showcase (`md3_ios_showcase`)

基于 **Flutter (Material Design 3)** 构建的 iOS 全组件测试应用，用于实机与模拟器验证 Material Design 3 全部组件在 iOS 平台下的视觉渲染、交互手势、安全区适配、触感反馈与主题动态切换效果，并通过 **GitHub Actions** 自动构建无签名 `.ipa` 与模拟器包。

## 覆盖组件清单

| 分类 | 包含组件 |
| --- | --- |
| **Actions 操作** | `ElevatedButton`, `FilledButton`, `FilledButton.tonal`, `OutlinedButton`, `TextButton`（含图标与禁用态）、`FloatingActionButton` 全尺寸 (`small`/`standard`/`large`/`extended`)、`IconButton` 四种变体及选中态、`SegmentedButton`（单选/多选） |
| **Communication 通信** | `Badge` / `Badge.count`、`LinearProgressIndicator`、`CircularProgressIndicator`（含 `.adaptive`）、`SnackBar`（Fixed/Floating）、`MaterialBanner`、`Tooltip`（Plain/Rich） |
| **Containment 容器** | `Card` (`Elevated` / `Filled` / `Outlined`)、`CarouselView`、`AlertDialog` / `AlertDialog.adaptive` / `Dialog.fullscreen`、`showModalBottomSheet` / `DraggableScrollableSheet`、`ListTile`、`ExpansionTile`、`Divider` |
| **Navigation 导航** | `AppBar`、`SliverAppBar.medium` / `SliverAppBar.large`、`BottomAppBar`、`NavigationBar`、`NavigationRail`（自适应宽屏）、`NavigationDrawer`、`TabBar` (Primary & Secondary)、`SearchBar` / `SearchAnchor` |
| **Selection 选择** | `Checkbox`（含三态与 `.adaptive`）、`Switch`（含 `thumbIcon` 与 `.adaptive`）、`RadioListTile`（含 `.adaptive`）、`ActionChip` / `FilterChip` / `ChoiceChip` / `InputChip`、`Slider` / `RangeSlider` / `Slider.adaptive`、`DatePicker` / `DateRangePicker` / `TimePicker`、`DropdownMenu` / `MenuAnchor` |
| **Text Inputs 输入** | `TextField` / `TextFormField`（Filled / Outlined）、多行字数统计、密码显隐、表单校验、iOS 软键盘类型与长按选区菜单 |
| **Theme & Tokens** | 8 种预设 Seed Color、9 种 `DynamicSchemeVariant`、亮色/暗色/跟随系统、字体缩放、`TargetPlatform`（iOS vs Android 实时切换对照）、Color Roles 矩阵、Elevation 0–5、15 级 Typography Scale |
| **iOS Runtime Probe** | 实时 `MediaQuery` 安全区与灵动岛/Home Indicator 指标、`HapticFeedback` 五种震动测试、`BouncingScrollPhysics` + `CupertinoScrollbar`、边缘右滑返回路由对照、Impeller/Metal 动画测试 |

## GitHub Actions 构建说明

工作流文件位于 `.github/workflows/ios-build.yml`，在 `macos-latest` 上自动执行：

1. 若仓库中尚未包含 `ios/` 原生工程，自动通过 `flutter create --platforms=ios` 生成最新兼容的 Xcode Runner，并写入应用显示名称 `MD3 Showcase`。
2. 执行 `flutter analyze --no-fatal-infos` 与 `flutter test`。
3. 构建并上传两个产物（Artifacts）：
   - `MD3-iOS-Showcase-unsigned-ipa`（`MD3-iOS-Showcase-unsigned.ipa`）：无签名真机包，可使用 **TrollStore**、**AltStore**、**SideStore** 或 **Sideloadly** 安装到 iPhone 测试。
   - `MD3-iOS-Showcase-simulator-app`（`MD3-iOS-Showcase-simulator.app.zip`）：iOS 模拟器包，解压后可直接拖入 macOS Xcode Simulator 运行。

## 推送到 GitHub 触发构建

```bash
git remote add origin https://github.com/<你的用户名>/md3-ios-showcase.git
git push -u origin main
```

推送后打开 GitHub 仓库的 **Actions** 标签页，即可看到构建任务并在完成后下载 `.ipa` 与模拟器包。
