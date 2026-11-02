import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_colors.dart';

class OtpInput extends StatefulWidget {
  const OtpInput({super.key, this.length = 6, required this.onChanged});

  final int length;
  final ValueChanged<String> onChanged;

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _nodes;

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(widget.length, (_) => TextEditingController());

    _nodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }

    for (final node in _nodes) {
      node.dispose();
    }

    super.dispose();
  }

  void _onChanged(int index, String value) {
    if (value.isNotEmpty && index < widget.length - 1) {
      _nodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _nodes[index - 1].requestFocus();
    }

    widget.onChanged(_controllers.map((controller) => controller.text).join());
  }

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color, width: 1.3),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 8.0;

        // المساحة المتاحة بعد خصم المسافات بين الخانات
        final availableWidth =
            constraints.maxWidth - (spacing * (widget.length - 1));

        // عرض الخانة يتناسب مع الشاشة
        final boxWidth = (availableWidth / widget.length).clamp(35.0, 52.0);

        final boxHeight = (boxWidth * 1.25).clamp(44.0, 64.0);

        return Directionality(
          textDirection: TextDirection.ltr,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.length, (index) {
              return Padding(
                padding: EdgeInsets.only(
                  right: index == widget.length - 1 ? 0 : spacing,
                ),
                child: SizedBox(
                  width: boxWidth,
                  height: boxHeight,
                  child: TextField(
                    controller: _controllers[index],
                    focusNode: _nodes[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(1),
                    ],
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                    onChanged: (value) => _onChanged(index, value),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.field,
                      contentPadding: EdgeInsets.zero,
                      enabledBorder: _border(AppColors.fieldBorder),
                      focusedBorder: _border(AppColors.teal),
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
