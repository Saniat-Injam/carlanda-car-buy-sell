import 'package:carlanda_car_buy_sell/core/utils/constants/app_colors.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/icon_path.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/to_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum OverlayPosition { top, bottom }

class CustomDropDownButton extends StatefulWidget {
  final List<String> items;
  final String iconPath;
  final ValueChanged<String> onSelected;
  final String? initialValue;
  final String hintText;
  final Color? iconColor;
  final OverlayPosition overlayPosition;

  const CustomDropDownButton({
    super.key,
    required this.items,
    required this.iconPath,
    required this.onSelected,
    this.initialValue,
    this.hintText = "Select",
    this.iconColor,
    this.overlayPosition = OverlayPosition.bottom,
  });

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton>
    with SingleTickerProviderStateMixin {
  bool isDropdownOpen = false;
  late final AnimationController _animationController;
  late final Animation<double> _animation;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _buttonKey = GlobalKey();
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _toggleDropdown() {
    if (isDropdownOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    setState(() => isDropdownOpen = true);
    _createOverlay();
    _animationController.forward(from: 0);
  }

  void _closeDropdown() {
    _animationController.reverse().then((_) {
      if (mounted) {
        setState(() => isDropdownOpen = false);
        _removeOverlay();
      }
    });
  }

  void _createOverlay() {
    _overlayEntry = _buildOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _buildOverlayEntry() {
    final RenderBox renderBox =
        _buttonKey.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final position = renderBox.localToGlobal(Offset.zero);

    const double rowHeight = 48;
    final bool showAbove = widget.overlayPosition == OverlayPosition.top;

    // Calculate overlay height
    final double overlayHeight = widget.items.length * rowHeight;

    // Set vertical offset relative to button
    final double verticalOffset = showAbove
        ? -overlayHeight - 6
        : size.height + 6;

    return OverlayEntry(
      builder: (context) {
        return AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            // Calculate the current animated height
            final double currentHeight = overlayHeight * _animation.value;

            // For top position, adjust the top offset during animation
            final double animatedVerticalOffset = showAbove
                ? (position.dy + verticalOffset) +
                      (overlayHeight - currentHeight)
                : position.dy + verticalOffset;

            return Positioned(
              left: position.dx,
              top: animatedVerticalOffset,
              width: size.width,
              height: currentHeight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: currentHeight,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(),
                    child: child,
                  ),
                ),
              ),
            );
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: widget.items.map((item) {
                final bool isSelected = selectedValue == item;
                return InkWell(
                  onTap: () {
                    setState(() => selectedValue = item);
                    widget.onSelected(item);
                    _closeDropdown();
                  },
                  child: Container(
                    width: double.infinity,
                    height: rowHeight,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.centerLeft,
                    color: isSelected ? AppColors.primary : Colors.white,
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w400,
                        color: isSelected ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayText = selectedValue ?? widget.hintText;
    final bool hasSelection =
        selectedValue != null && selectedValue!.isNotEmpty;

    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          key: _buttonKey,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: isDropdownOpen ? AppColors.primary : Colors.grey.shade300,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                widget.iconPath,
                width: 18,
                height: 18,
                colorFilter: widget.iconColor != null
                    ? ColorFilter.mode(
                        widget.iconColor ?? Colors.white,
                        BlendMode.srcIn,
                      )
                    : null,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  displayText,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: hasSelection
                        ? Colors.black87
                        : const Color(0xFF93969C),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              AnimatedRotation(
                turns: isDropdownOpen ? 0.5 : 0,
                duration: const Duration(milliseconds: 200),
                child: SvgPicture.asset(
                  IconPath.dropDown,
                  colorFilter: ColorFilter.mode(
                    "#93969C".toColor(),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
