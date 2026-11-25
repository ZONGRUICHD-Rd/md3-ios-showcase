import 'package:flutter/material.dart';
import '../widgets/section_card.dart';

class SelectionPage extends StatefulWidget {
  const SelectionPage({super.key});

  @override
  State<SelectionPage> createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  bool? _triCheck;
  bool _normalCheck = true;
  bool _adaptiveCheck = true;

  bool _switch1 = true;
  bool _switch2 = false;
  bool _adaptiveSwitch = true;

  String _radioValue = 'ios';

  final Set<String> _selectedFilters = <String>{'iOS', 'Dark Mode'};
  String _selectedChoice = 'Medium';
  final List<String> _inputTags = <String>['Material 3', 'Flutter', 'Swift/Metal'];

  double _sliderValue = 0.4;
  double _discreteSliderValue = 40;
  RangeValues _rangeValues = const RangeValues(20, 75);

  DateTime? _pickedDate;
  DateTimeRange? _pickedRange;
  TimeOfDay? _pickedTime;

  String _dropdownValue = 'System';
  String _menuSelection = '未选择';

  Future<void> _pickDate() async {
    final DateTime now = DateTime.now();
    final DateTime? result = await showDatePicker(
      context: context,
      initialDate: _pickedDate ?? now,
      firstDate: DateTime(now.year - 2),
      lastDate: DateTime(now.year + 2),
    );
    if (result != null) {
      setState(() => _pickedDate = result);
    }
  }

  Future<void> _pickDateRange() async {
    final DateTime now = DateTime.now();
    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 1),
      initialDateRange: _pickedRange,
    );
    if (result != null) {
      setState(() => _pickedRange = result);
    }
  }

  Future<void> _pickTime() async {
    final TimeOfDay? result = await showTimePicker(
      context: context,
      initialTime: _pickedTime ?? TimeOfDay.now(),
    );
    if (result != null) {
      setState(() => _pickedTime = result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final WidgetStateProperty<Icon?> switchThumbIcon =
        WidgetStateProperty.resolveWith<Icon?>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return const Icon(Icons.check);
        }
        return const Icon(Icons.close);
      },
    );

    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        const ComponentCategoryHeader(
          title: 'Selection 选择与调节',
          description:
              '测试 Checkboxes、Switches、Radios（含 .adaptive iOS 控件对照）、Chips、Sliders、Date/Time Pickers 与 Menus。',
          icon: Icons.tune_outlined,
        ),
        SectionCard(
          title: 'Checkboxes & Switches 复选框与开关',
          subtitle: '含三态复选框、带图标 MD3 Switch 以及 .adaptive 原生控件',
          child: Column(
            children: <Widget>[
              Wrap(
                spacing: 16,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Checkbox(
                        value: _normalCheck,
                        onChanged: (bool? v) =>
                            setState(() => _normalCheck = v ?? false),
                      ),
                      const Text('MD3'),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Checkbox(
                        tristate: true,
                        value: _triCheck,
                        onChanged: (bool? v) => setState(() => _triCheck = v),
                      ),
                      const Text('Tristate'),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Checkbox.adaptive(
                        value: _adaptiveCheck,
                        onChanged: (bool? v) =>
                            setState(() => _adaptiveCheck = v ?? false),
                      ),
                      const Text('.adaptive'),
                    ],
                  ),
                ],
              ),
              const Divider(),
              Wrap(
                spacing: 16,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Switch(
                        value: _switch1,
                        onChanged: (bool v) => setState(() => _switch1 = v),
                      ),
                      const SizedBox(width: 4),
                      const Text('MD3'),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Switch(
                        value: _switch2,
                        thumbIcon: switchThumbIcon,
                        onChanged: (bool v) => setState(() => _switch2 = v),
                      ),
                      const SizedBox(width: 4),
                      const Text('Thumb Icon'),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Switch.adaptive(
                        value: _adaptiveSwitch,
                        onChanged: (bool v) =>
                            setState(() => _adaptiveSwitch = v),
                      ),
                      const SizedBox(width: 4),
                      const Text('.adaptive'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        SectionCard(
          title: 'Radio 单选按钮',
          subtitle: 'MD3 RadioListTile 与 .adaptive 对照',
          child: Column(
            children: <Widget>[
              RadioListTile<String>(
                title: const Text('iOS Impeller / Metal 渲染'),
                subtitle: const Text('默认高帧率矢量管线'),
                value: 'ios',
                groupValue: _radioValue,
                onChanged: (String? v) {
                  if (v != null) setState(() => _radioValue = v);
                },
              ),
              RadioListTile<String>(
                title: const Text('MD3 跨平台一致风格'),
                subtitle: const Text('统一圆角、色调与按压水波纹'),
                value: 'md3',
                groupValue: _radioValue,
                onChanged: (String? v) {
                  if (v != null) setState(() => _radioValue = v);
                },
              ),
              RadioListTile<String>.adaptive(
                title: const Text('自适应 Radio (.adaptive)'),
                value: 'adaptive',
                groupValue: _radioValue,
                onChanged: (String? v) {
                  if (v != null) setState(() => _radioValue = v);
                },
              ),
            ],
          ),
        ),
        SectionCard(
          title: 'Chips 纸片标签',
          subtitle: 'ActionChip / FilterChip / ChoiceChip / InputChip',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  ActionChip(
                    avatar: const Icon(Icons.event, size: 18),
                    label: const Text('ActionChip'),
                    onPressed: () {},
                  ),
                  ActionChip.elevated(
                    avatar: const Icon(Icons.bolt, size: 18),
                    label: const Text('Elevated Action'),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <String>['iOS', 'Dark Mode', 'Dynamic Color', 'RTL']
                    .map((String tag) {
                  return FilterChip(
                    label: Text(tag),
                    selected: _selectedFilters.contains(tag),
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          _selectedFilters.add(tag);
                        } else {
                          _selectedFilters.remove(tag);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <String>['Small', 'Medium', 'Large'].map((String size) {
                  return ChoiceChip(
                    label: Text(size),
                    selected: _selectedChoice == size,
                    onSelected: (_) => setState(() => _selectedChoice = size),
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _inputTags.map((String tag) {
                  return InputChip(
                    avatar: CircleAvatar(child: Text(tag[0])),
                    label: Text(tag),
                    onDeleted: () {
                      setState(() => _inputTags.remove(tag));
                    },
                  );
                }).toList(),
              ),
              if (_inputTags.isEmpty)
                TextButton(
                  onPressed: () {
                    setState(() {
                      _inputTags
                          .addAll(<String>['Material 3', 'Flutter', 'Swift/Metal']);
                    });
                  },
                  child: const Text('恢复 InputChips'),
                ),
            ],
          ),
        ),
        SectionCard(
          title: 'Sliders 滑块',
          subtitle: '连续滑块、分段刻度滑块、双端范围滑块与 .adaptive',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('连续滑块: ${(_sliderValue * 100).round()}%'),
              Slider(
                value: _sliderValue,
                onChanged: (double v) => setState(() => _sliderValue = v),
              ),
              Text('分段刻度滑块 (5 档): ${_discreteSliderValue.round()}'),
              Slider(
                value: _discreteSliderValue,
                min: 0,
                max: 100,
                divisions: 5,
                label: _discreteSliderValue.round().toString(),
                onChanged: (double v) =>
                    setState(() => _discreteSliderValue = v),
              ),
              Text(
                'RangeSlider: ${_rangeValues.start.round()} - ${_rangeValues.end.round()}',
              ),
              RangeSlider(
                values: _rangeValues,
                min: 0,
                max: 100,
                divisions: 10,
                labels: RangeLabels(
                  _rangeValues.start.round().toString(),
                  _rangeValues.end.round().toString(),
                ),
                onChanged: (RangeValues values) =>
                    setState(() => _rangeValues = values),
              ),
              const Text('Slider.adaptive (iOS 呈现 CupertinoSlider)'),
              Slider.adaptive(
                value: _sliderValue,
                onChanged: (double v) => setState(() => _sliderValue = v),
              ),
            ],
          ),
        ),
        SectionCard(
          title: 'Date & Time Pickers 日期与时间选择器',
          subtitle: '测试 MD3 日历弹窗、区间选择及表盘时间选择器',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: <Widget>[
                  FilledButton.tonalIcon(
                    onPressed: _pickDate,
                    icon: const Icon(Icons.calendar_today),
                    label: const Text('DatePicker'),
                  ),
                  FilledButton.tonalIcon(
                    onPressed: _pickDateRange,
                    icon: const Icon(Icons.date_range),
                    label: const Text('DateRangePicker'),
                  ),
                  FilledButton.tonalIcon(
                    onPressed: _pickTime,
                    icon: const Icon(Icons.schedule),
                    label: const Text('TimePicker'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                '已选日期: ${_pickedDate?.toIso8601String().split('T').first ?? '未选择'}  |  '
                '区间: ${_pickedRange == null ? '未选择' : '${_pickedRange!.start.month}/${_pickedRange!.start.day} - ${_pickedRange!.end.month}/${_pickedRange!.end.day}'}  |  '
                '时间: ${_pickedTime?.format(context) ?? '未选择'}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        SectionCard(
          title: 'Menus 菜单组件',
          subtitle: 'MD3 DropdownMenu（外露下拉）与 MenuAnchor（多级嵌套菜单）',
          child: Wrap(
            spacing: 16,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              DropdownMenu<String>(
                initialSelection: _dropdownValue,
                label: const Text('帧率策略'),
                onSelected: (String? value) {
                  if (value != null) setState(() => _dropdownValue = value);
                },
                dropdownMenuEntries: const <DropdownMenuEntry<String>>[
                  DropdownMenuEntry<String>(
                    value: 'System',
                    label: 'System (ProMotion 120Hz)',
                  ),
                  DropdownMenuEntry<String>(value: '60fps', label: '锁定 60Hz'),
                  DropdownMenuEntry<String>(value: 'Eco', label: '节能模式'),
                ],
              ),
              MenuAnchor(
                builder: (
                  BuildContext context,
                  MenuController controller,
                  Widget? child,
                ) {
                  return OutlinedButton.icon(
                    onPressed: () {
                      if (controller.isOpen) {
                        controller.close();
                      } else {
                        controller.open();
                      }
                    },
                    icon: const Icon(Icons.menu_open),
                    label: Text('MenuAnchor: $_menuSelection'),
                  );
                },
                menuChildren: <Widget>[
                  MenuItemButton(
                    leadingIcon: const Icon(Icons.content_copy),
                    onPressed: () => setState(() => _menuSelection = '复制'),
                    child: const Text('复制配置'),
                  ),
                  MenuItemButton(
                    leadingIcon: const Icon(Icons.ios_share),
                    onPressed: () => setState(() => _menuSelection = '导出'),
                    child: const Text('导出报告'),
                  ),
                  SubmenuButton(
                    leadingIcon: const Icon(Icons.tune),
                    menuChildren: <Widget>[
                      MenuItemButton(
                        onPressed: () =>
                            setState(() => _menuSelection = '子项 A'),
                        child: const Text('子菜单项 A'),
                      ),
                      MenuItemButton(
                        onPressed: () =>
                            setState(() => _menuSelection = '子菜单项 B'),
                        child: const Text('子菜单项 B'),
                      ),
                    ],
                    child: const Text('高级选项'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
