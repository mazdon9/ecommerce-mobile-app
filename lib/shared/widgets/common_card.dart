import 'package:flutter/material.dart';

class CommonCard extends StatelessWidget {
  final Widget child;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final List<BoxShadow>? boxShadow;
  final VoidCallback? onTap;
  final double? elevation;

  const CommonCard({
    super.key,
    required this.child,
    this.borderRadius,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.boxShadow,
    this.onTap,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    Widget cardWidget = Container(
      margin: margin,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(borderRadius ?? 12),
        boxShadow:
            boxShadow ??
            [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: elevation ?? 8,
                offset: const Offset(0, 2),
              ),
            ],
      ),
      child: child,
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: cardWidget);
    }

    return cardWidget;
  }
}
