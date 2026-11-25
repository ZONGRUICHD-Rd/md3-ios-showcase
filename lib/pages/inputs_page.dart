import 'package:flutter/material.dart';
import '../widgets/section_card.dart';

class InputsPage extends StatefulWidget {
  const InputsPage({super.key});

  @override
  State<InputsPage> createState() => _InputsPageState();
}

class _InputsPageState extends State<InputsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    final bool valid = _formKey.currentState?.validate() ?? false;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(valid ? '表单校验通过！' : '请检查表单红色错误提示'),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          const ComponentCategoryHeader(
            title: 'Text Inputs 文本输入',
            description:
                '测试 MD3 Filled & Outlined 输入框在 iOS 软键盘弹出、自动纠错、长按选区菜单 (Copy/Paste) 与表单验证下的表现。',
            icon: Icons.keyboard_alt_outlined,
          ),
          SectionCard(
            title: 'Filled & Outlined TextFields',
            subtitle: '点击空白处可收起 iOS 键盘',
            child: Column(
              children: <Widget>[
                const TextField(
                  decoration: InputDecoration(
                    filled: true,
                    labelText: 'Filled TextField',
                    hintText: '输入测试文本...',
                    helperText: 'MD3 默认填充样式，底部有动态聚焦指示线',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
                const SizedBox(height: 16),
                const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Outlined TextField',
                    hintText: '例如：iPhone 16 Pro',
                    helperText: '外框浮动标签样式',
                    prefixIcon: Icon(Icons.phone_iphone),
                    suffixIcon: Icon(Icons.qr_code_scanner),
                  ),
                ),
                const SizedBox(height: 16),
                const TextField(
                  maxLines: 3,
                  maxLength: 140,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '多行输入与字数统计',
                    hintText: '长按此处输入文本，测试 iOS 原生放大镜与复制粘贴气泡菜单',
                    alignLabelWithHint: true,
                  ),
                ),
              ],
            ),
          ),
          SectionCard(
            title: 'Form Validation & iOS Keyboard Types',
            subtitle: '邮箱键盘、密码显隐切换与错误态校验',
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      labelText: '电子邮箱',
                      prefixIcon: const Icon(Icons.email_outlined),
                      suffixIcon: IconButton(
                        onPressed: _emailController.clear,
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || !value.contains('@')) {
                        return '请输入包含 @ 的有效邮箱地址';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: '访问密码',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(
                            () => _obscurePassword = !_obscurePassword,
                          );
                        },
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.length < 6) {
                        return '密码长度不能少于 6 位';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '数字键盘测试 (端口号)',
                      prefixText: 'https://localhost:',
                      prefixIcon: Icon(Icons.numbers),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: _submitForm,
                    icon: const Icon(Icons.check_circle_outline),
                    label: const Text('验证表单'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
