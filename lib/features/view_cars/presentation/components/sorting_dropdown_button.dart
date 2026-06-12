import 'package:carlanda_car_buy_sell/core/utils/constants/icon_path.dart';
import 'package:carlanda_car_buy_sell/features/view_cars/controller/view_cars_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SortingDropdownbutton extends StatefulWidget {
  const SortingDropdownbutton({super.key});

  @override
  State<SortingDropdownbutton> createState() => _SortingDropdownbuttonState();
}

class _SortingDropdownbuttonState extends State<SortingDropdownbutton>
    with SingleTickerProviderStateMixin {
  final ViewCarsController controller = Get.find<ViewCarsController>();

  bool isDropdownOpen = false;
  late AnimationController _animationController;
  late Animation<double> _animation;
  OverlayEntry? _overlayEntry;
  final GlobalKey _buttonKey = GlobalKey();
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
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
    setState(() {
      isDropdownOpen = true;
    });
    _animationController.forward();
    _createOverlay();
  }

  void _closeDropdown() {
    setState(() {
      isDropdownOpen = false;
    });
    _animationController.reverse();
    _removeOverlay();
  }

  void _createOverlay() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    final RenderBox renderBox =
        _buttonKey.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;

    // Calculate the width needed for the longest text in dropdown
    const textStyle = TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600);
    double maxWidth = 0;
    for (String option in controller.filterResults) {
      final width = _getTextWidth(option, textStyle);
      if (width > maxWidth) maxWidth = width;
    }
    // Add padding (32px total) and some extra space
    final dropdownWidth = (maxWidth + 50.0).clamp(size.width, 300.0);

    return OverlayEntry(
      builder: (context) => Positioned(
        width: dropdownWidth,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 4.0),
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(8.0),
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _animation.value,
                  alignment: Alignment.topCenter,
                  child: Opacity(
                    opacity: _animation.value,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 8.0,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: controller.filterResults.map((String option) {
                          return InkWell(
                            onTap: () {
                              controller.selectFilter(option: option);
                              _closeDropdown();
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 12.0,
                              ),
                              decoration: BoxDecoration(
                                color: controller.selectedFilter.value == option
                                    ? Theme.of(context).primaryColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Text(
                                option,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight:
                                      controller.selectedFilter.value == option
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                  color:
                                      controller.selectedFilter.value == option
                                      ? Colors.white
                                      : Colors.black87,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  double _getTextWidth(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    return textPainter.size.width;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Obx(() {
          const textStyle = TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          );

          // Calculate width based on text length + padding + icon
          final displayText = controller.selectedFilter.value.isEmpty
              ? "Sort"
              : controller.selectedFilter.value;
          final textWidth = _getTextWidth(displayText, textStyle);
          final totalWidth =
              textWidth +
              40.0; // 16px padding on each side + 8px for icon space

          return Container(
            key: _buttonKey,
            width: totalWidth.clamp(
              90,
              double.infinity,
            ), // Minimum width of 80px
            height: 40.0,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: isDropdownOpen
                    ? Theme.of(context).primaryColor
                    : Colors.grey.shade300,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    displayText,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8.0),
                AnimatedRotation(
                  turns: isDropdownOpen ? 0.5 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: SvgPicture.asset(IconPath.dropDown),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
