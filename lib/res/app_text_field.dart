import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/res/app_custom_color.dart';
import 'package:todo_app/utils/utils.dart';
import '../utils/app_text_style.dart';

class AppTextField extends StatefulWidget {
  final String? labelText;
  final TextEditingController controller;
  final bool? enabled;
  final bool? readOnly;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final FocusNode? focusNode;
  final Function(String)? onChanged;

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? prefixOnTap;
  final VoidCallback? suffixOnTap;
  final bool? autofocus;
  final Color? fillColor;
  final Color? cursorColor;
  final TextStyle? style;
  final double? radius;
  final VoidCallback? onTap;

  /// Error widget
  final String? errorMessage;
  final bool? validation;
  final TextStyle? errorStyle;
  final double? errorSpacing;
  final double? errorHeight;
  final int? errorMaxLine;
  final BoxConstraints? suffixIconConstraints;

  const AppTextField({
    super.key,
    this.labelText,
    required this.controller,
    this.enabled = true,
    this.readOnly = false,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.focusNode,
    this.onChanged,
    this.errorMessage,
    this.validation,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixOnTap,
    this.suffixOnTap,
    this.autofocus = false,
    this.fillColor,
    this.cursorColor,
    this.errorStyle,
    this.errorSpacing,
    this.errorHeight,
    this.errorMaxLine,
    this.style,
    this.radius,
    this.suffixIconConstraints,
    this.onTap,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late FocusNode _focusNode;
  bool _hasText = false;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    widget.controller.addListener(_updateText);
    _focusNode.addListener(_updateFocus);

    // ✅ Ensure correct float state on rebuild (e.g., back navigation)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _hasText = widget.controller.text.isNotEmpty;
      });
    });
  }

  void _updateText() {
    setState(() {
      _hasText = widget.controller.text.isNotEmpty;
    });
  }

  void _updateFocus() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateText);
    _focusNode.removeListener(_updateFocus);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool shouldFloat = _hasText || _isFocused;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: shouldFloat ? 8 : 16),
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.validation == false ? Theme.of(context).colorScheme.error : customColors(context).textFieldBorder,
            ),
            borderRadius: filedBorderRadius,
            color: widget.fillColor ?? Colors.white,
          ),
          child: Stack(
            children: [
              if (widget.labelText != null)
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  left: 0,
                  top: shouldFloat ? 0 : 2,
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style: AppTextStyle.mediumStyle(context)!.copyWith(
                      fontSize: shouldFloat ? 12.sp : 14.sp,
                      color: customColors(context).textFieldTitle,
                    ),
                    child: Text(
                      widget.labelText ?? "",
                      style: AppTextStyle.textFieldStyle(context).copyWith(
                        fontSize: shouldFloat ? 12.sp : 14.sp,
                        color: customColors(context).textFieldTitle,
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: EdgeInsets.only(top: shouldFloat ? 18 : 0),
                child: TextFormField(
                  controller: widget.controller,
                  onTap: widget.onTap,
                  focusNode: _focusNode,
                  enabled: widget.enabled,
                  readOnly: widget.readOnly ?? false,
                  obscureText: widget.obscureText ?? false,
                  keyboardType: widget.keyboardType,
                  textInputAction: widget.textInputAction,
                  inputFormatters: widget.inputFormatters,
                  cursorColor: widget.cursorColor ?? Colors.black,
                  autofocus: widget.autofocus ?? false,
                  maxLines: widget.maxLines ?? 1,
                  minLines: widget.minLines,
                  maxLength: widget.maxLength,
                  onChanged: widget.onChanged,
                  style: textFormFieldStyle,
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    counterText: "",
                    prefixIcon: widget.prefixIcon != null
                        ? InkWell(
                            onTap: widget.prefixOnTap,
                            child: widget.prefixIcon,
                          )
                        : null,
                    suffixIcon: widget.suffixIcon != null
                        ? InkWell(
                            onTap: widget.suffixOnTap,
                            child: widget.suffixIcon,
                          )
                        : null,
                    suffixIconConstraints: widget.suffixIconConstraints,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (widget.errorMessage != null && widget.errorMessage!.isNotEmpty)
          FieldErrorWidget(
            context,
            errorMaxLine: widget.errorMaxLine,
            errorHeight: widget.errorHeight,
            errorSpacing: widget.errorSpacing,
            validation: widget.validation,
            errorStyle: widget.errorStyle,
            errorMessage: widget.errorMessage,
          ),
      ],
    );
  }

  BorderRadius get filedBorderRadius => BorderRadius.all(Radius.circular(widget.radius ?? (defaultRadius * 2)));

  TextStyle get textFormFieldStyle => widget.style ?? AppTextStyle.textFieldStyle(context);
}

/// [FieldErrorWidget] You can also use the widget globally in a way where you have created your own custom TextField
class FieldErrorWidget extends StatelessWidget {
  final double? errorHeight;
  final double? errorSpacing;
  final int? errorMaxLine;
  final bool? validation;
  final String? errorMessage;
  final TextStyle? errorStyle;
  final BuildContext? mainContext;

  const FieldErrorWidget(
    this.mainContext, {
    super.key,
    this.errorHeight,
    this.errorSpacing,
    this.errorMaxLine,
    this.validation = true,
    required this.errorMessage,
    this.errorStyle,
  });

  @override
  Widget build(context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
      tween: validation == false ? Tween(begin: 0.0, end: (errorHeight ?? 18) + (errorSpacing ?? 5)) : Tween(begin: 0.0, end: 0.0),
      builder: (context, value, child) => Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.only(top: errorSpacing ?? 5, left: 10),
        height: value * 1,
        child: Text(
          errorMessage ?? "",
          textAlign: TextAlign.left,
          maxLines: errorMaxLine ?? 1,
          overflow: TextOverflow.ellipsis,
          style: errorStyle ??
              TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.error,
              ),
        ),
      ),
    );
  }
}
