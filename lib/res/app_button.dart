import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../utils/common_enums.dart';
import '../utils/ui_utils.dart';
import '../utils/utils.dart';
import 'app_custom_color.dart';
import 'app_loader.dart';

class AppButton extends StatefulWidget {
  final ButtonType? buttonType;
  final String? title;
  final TextStyle? titleStyle;
  final double? width;
  final IconData? icon;
  final Color? loaderColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final Gradient? gradient;
  final bool? flexibleHeight;
  final EdgeInsetsGeometry? margin;

  final String? image;
  final double? height;
  final double? fontSize;
  final Widget? child;
  final bool? disableButton;
  final bool? loader;
  final BorderRadius? borderRadius;
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final EdgeInsetsGeometry? padding;

  final Function(bool)? onHighlightChanged;

  const AppButton({
    super.key,
    this.title,
    this.titleStyle,
    this.buttonType = ButtonType.elevated,
    this.width,
    this.icon,
    this.loaderColor,
    this.backgroundColor,
    this.borderColor,
    this.gradient,
    this.image,
    this.height,
    this.fontSize,
    this.child,
    this.margin,
    this.disableButton = false,
    this.loader = false,
    this.borderRadius,
    required this.onPressed,
    this.onLongPress,
    this.padding,
    this.onHighlightChanged,
    this.flexibleHeight = false,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  RxBool buttonPress = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TweenAnimationBuilder(
        duration: const Duration(milliseconds: 1200),
        curve: Curves.elasticOut,
        tween: widget.loader == true || buttonPress.value == true ? Tween(begin: 0.9, end: 0.97) : Tween(begin: 1.0, end: 1.0),
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: widget.width?.w ?? Get.width,
              height: widget.flexibleHeight == false ? (widget.height?.w ?? UiUtils.appButtonHeight + (widget.margin?.vertical ?? 0)) : null,
              margin: widget.padding ?? EdgeInsets.zero,
              decoration: BoxDecoration(
                borderRadius: widget.borderRadius ?? BorderRadius.circular(defaultRadius * 2.5),
                color: widget.backgroundColor ?? (widget.buttonType == ButtonType.outline ? null : customColors(context).kPrimaryColor.withOpacity(withMyOpacity)),
                border: widget.buttonType == ButtonType.outline ? Border.all(color: widget.borderColor ?? customColors(context).kPrimaryColor.withOpacity(disableOpacity)) : null,
                gradient: loadingOrDisableStatus
                    ? (widget.buttonType == ButtonType.gradient
                        ? (widget.gradient ??
                            LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: <Color>[
                                customColors(context).kPrimaryColor.withOpacity(.2),
                                customColors(context).kPrimaryColor,
                                customColors(context).kPrimaryColor,
                                customColors(context).kPrimaryColor.withOpacity(.2),
                              ],
                            ))
                        : null)
                    : null,
              ),
              child: RawMaterialButton(
                splashColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(widget.loader == false ? .1 : 0),
                highlightColor: customColors(context).kPrimaryColor.withOpacity(widget.buttonType == ButtonType.outline ? .1 : .0),
                shape: RoundedRectangleBorder(borderRadius: widget.borderRadius ?? BorderRadius.circular(defaultRadius)),
                hoverElevation: widget.loader == false ? 4.0 : 0.0,
                elevation: widget.loader == false ? 2.0 : 0.0,
                disabledElevation: 0,
                highlightElevation: widget.loader == false ? 8.0 : 0.0,
                onPressed: loadingOrDisableStatus ? widget.onPressed : null,
                onLongPress: loadingOrDisableStatus ? widget.onLongPress : null,
                onHighlightChanged: loadingOrDisableStatus
                    ? (press) {
                        setState(
                          () {
                            buttonPress.value = press;
                            widget.onHighlightChanged != null ? widget.onHighlightChanged!(press) : null;
                          },
                        );
                      }
                    : null,
                child: widget.loader == false
                    ? (widget.child ??
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            //** Icon Widget */
                            if (!isValEmpty(widget.icon)) ...[
                              Icon(widget.icon, color: Colors.white, size: 24),
                              const SizedBox(width: 5),
                            ] else
                              const SizedBox(),

                            //** Image widget */
                            if (!isValEmpty(widget.image)) ...[
                              GetUtils.isVector(widget.image!)
                                  ? SvgPicture.asset(
                                      widget.image!,
                                      height: 22,
                                      alignment: Alignment.bottomLeft,
                                    )
                                  : Image.asset(
                                      widget.image!,
                                      height: 22,
                                      alignment: Alignment.bottomLeft,
                                    ),
                              const SizedBox(width: 5)
                            ] else
                              const SizedBox(),

                            //** Title Widget */
                            if (!isValEmpty(widget.title))
                              Text(
                                widget.title!,
                                textAlign: TextAlign.center,
                                style: widget.titleStyle ??
                                    TextStyle(
                                      fontSize: 16.sp,
                                      color: titleColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                              )
                            else
                              const SizedBox(),
                          ],
                        ))
                    : CircularLoader(
                        color: widget.loaderColor ?? (widget.buttonType == ButtonType.outline ? customColors(context).kPrimaryColor.withOpacity(.7) : Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(.6)),
                      ),
              ),
            ),
          );
        },
      ),
    );
  }

  Color? get titleColor {
    return widget.buttonType == ButtonType.outline ? customColors(context).kPrimaryColor.withOpacity(disableOpacity) : Colors.white.withOpacity(disableOpacity);
  }

  bool get loadingOrDisableStatus {
    return widget.disableButton == false ? (widget.loader == false ? true : false) : false;
  }

  double get withMyOpacity {
    return widget.loader == false ? (widget.disableButton == true ? .2 : 1.0) : .4;
  }

  double get disableOpacity {
    return widget.disableButton == true ? (Get.isDarkMode ? .6 : .9) : 1;
  }
}
