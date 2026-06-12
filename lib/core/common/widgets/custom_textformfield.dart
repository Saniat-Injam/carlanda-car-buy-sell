import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_sizes.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextStyle? hintTextStyle;
  final ValueChanged<String>? onChanged;
  final Color? containerColor;
  final Color? containerBorderColor;
  final double? containerBorderWidth;
  final int? maxLines;
  final bool readonly;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final Widget? prefixIcon;
  final String? prefixIconPath;
  final String? prefixText;
  final TextStyle? prefixTextStyle;
  final Widget? suffixIcon;
  final String? suffixIconPath;
  final String? suffixText;
  final TextStyle? suffixTextStyle;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? focusedErrorBorder;
  final bool hasError;
  final double borderRadious;
  final VoidCallback? onTap;
  final VoidCallback? onSuffixIconTap;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.hintTextStyle,
    this.onChanged,
    this.containerColor,
    this.containerBorderColor,
    this.containerBorderWidth,
    this.maxLines,
    this.readonly = false,
    this.obscureText = false,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.prefixIcon,
    this.prefixIconPath,
    this.prefixText,
    this.prefixTextStyle,
    this.suffixIcon,
    this.suffixIconPath,
    this.suffixText,
    this.suffixTextStyle,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.focusedErrorBorder,
    this.hasError = false,
    this.borderRadious = 25,
    this.onTap,
    this.onSuffixIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.h, bottom: 12.h),
      decoration: BoxDecoration(
        color: containerColor ?? const Color(0xFFFFFFFF),
        border: hasError ? Border.all(color: const Color(0xFFF83737)) : null,
        borderRadius: BorderRadius.circular(borderRadious),
      ),
      child: TextFormField(
        onTap: onTap,
        controller: controller,
        cursorColor: AppColors.primary,
        readOnly: readonly,
        onChanged: onChanged,
        obscureText: obscureText,
        maxLines: maxLines ?? 1,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: GoogleFonts.inter(
          fontSize: getWidth(16),
          fontWeight: FontWeight.w400,
          color: AppColors.textPrimary,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle:
              hintTextStyle ??
              GoogleFonts.roboto(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xFF93969C),
              ),
          prefixText: prefixText != null ? '$prefixText  ' : null,
          prefixStyle:
              prefixTextStyle ??
              GoogleFonts.inter(
                fontSize: getWidth(15),
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
              ),
          prefixIcon:
              prefixIcon ??
              (prefixIconPath != null
                  ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: getWidth(11)),
                    child: Image.asset(prefixIconPath!, width: getWidth(26)),
                  )
                  : null),
          suffixIcon:
              suffixIcon ??
              (suffixIconPath != null
                  ? GestureDetector(
                    onTap: onSuffixIconTap,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: getWidth(11)),
                      child: Image.asset(suffixIconPath!, width: getWidth(26)),
                    ),
                  )
                  : null),
          suffixText: suffixText != null ? '  $suffixText' : null,
          suffixStyle:
              suffixTextStyle ??
              GoogleFonts.inter(
                fontSize: getWidth(15),
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
              ),
          border: border ?? InputBorder.none,
          focusedBorder: focusedBorder ?? InputBorder.none,
          focusedErrorBorder: focusedErrorBorder ?? InputBorder.none,
          enabledBorder: enabledBorder ?? InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        ),
      ),
    );
  }
}
