import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_sizes.dart';

class CustomSubmitButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final Widget? prefixIcon;
  final Widget? nextIcon;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final double? borderWidth;
  final bool enabled;
  final bool isLoading;

  const CustomSubmitButton({
    super.key,
    required this.text,
    required this.onTap,
    this.prefixIcon,
    this.nextIcon,
    this.child,
    this.padding,
    this.borderRadius,
    this.color,
    this.textColor,
    this.borderColor,
    this.borderWidth,
    this.enabled = true,
    this.isLoading = false,
  });

  @override
  State<CustomSubmitButton> createState() => _CustomSubmitButtonState();
}

class _CustomSubmitButtonState extends State<CustomSubmitButton>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 120),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    _elevationAnimation = Tween<double>(begin: 6.0, end: 2.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _handleTap() async {
    if (!widget.enabled || widget.isLoading) return;

    HapticFeedback.selectionClick();
    await _scaleController.forward();
    HapticFeedback.lightImpact();
    await _scaleController.reverse();
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = widget.borderRadius ?? BorderRadius.circular(25);
    final buttonColor = _getButtonColor();

    return AnimatedBuilder(
      animation: Listenable.merge([_scaleAnimation, _elevationAnimation]),
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: borderRadius,
              border: _buildBorder(),
              boxShadow: _buildShadow(),
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius: borderRadius,
              child: InkWell(
                borderRadius: borderRadius,
                onTap: (widget.enabled && !widget.isLoading) ? _handleTap : null,
                splashColor: Colors.white.withValues(alpha: 0.15),
                highlightColor: Colors.white.withValues(alpha: 0.05),
                child: Container(
                  width: double.infinity,
                  padding:
                      widget.padding ??
                      EdgeInsets.symmetric(vertical: getHeight(17)),
                  child: _buildButtonContent(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getButtonColor() {
    if (!widget.enabled || widget.isLoading) {
      return Colors.grey.shade400;
    }

    if (widget.color != null) {
      return widget.color!;
    }

    return const Color(0xFF930405);
  }

  Border? _buildBorder() {
    if (widget.borderColor == null) return null;

    final borderWidth = widget.borderWidth ?? 1.0;
    final borderColor = widget.enabled
        ? widget.borderColor!
        : widget.borderColor!.withValues(alpha: 0.5);

    return Border.all(color: borderColor, width: borderWidth);
  }

  List<BoxShadow> _buildShadow() {
    if (!widget.enabled) {
      return [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ];
    }

    final elevation = _elevationAnimation.value;

    return [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.15),
        blurRadius: elevation * 2,
        offset: Offset(0, elevation),
      ),
      BoxShadow(
        color: const Color(0xFF930405).withValues(alpha: 0.2),
        blurRadius: elevation * 1.5,
        offset: Offset(0, elevation * 0.5),
        spreadRadius: -1,
      ),
    ];
  }

  Widget _buildButtonContent() {
    final textStyle = GoogleFonts.inter(
      fontSize: getWidth(16),
      fontWeight: FontWeight.w600,
      color: widget.enabled
          ? (widget.textColor ?? AppColors.textWhite)
          : Colors.grey.shade600,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.prefixIcon != null) ...[
          AnimatedOpacity(
            opacity: widget.enabled ? 1.0 : 0.5,
            duration: const Duration(milliseconds: 150),
            child: SizedBox(
              height: getHeight(22),
              width: getWidth(22),
              child: widget.prefixIcon!,
            ),
          ),
          SizedBox(width: getWidth(8)),
        ],
        if (widget.child == null && !widget.isLoading) ...[
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 150),
            style: textStyle,
            child: Text(widget.text),
          ),
        ],
        if (widget.isLoading) ...[
          SizedBox(
            height: getHeight(20),
            width: getWidth(20),
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                widget.textColor ?? AppColors.textWhite,
              ),
            ),
          ),
        ],
        if (widget.child != null)
          AnimatedOpacity(
            opacity: widget.enabled ? 1.0 : 0.5,
            duration: const Duration(milliseconds: 150),
            child: widget.child!,
          ),
        if (widget.nextIcon != null) ...[
          SizedBox(width: getWidth(8)),
          AnimatedOpacity(
            opacity: widget.enabled ? 1.0 : 0.5,
            duration: const Duration(milliseconds: 150),
            child: SizedBox(
              height: getHeight(22),
              width: getWidth(22),
              child: widget.nextIcon!,
            ),
          ),
        ],
      ],
    );
  }
}
