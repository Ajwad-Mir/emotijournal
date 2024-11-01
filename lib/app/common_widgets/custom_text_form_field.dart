import 'package:emotijournal/global/constants/app_colors.dart';
import 'package:emotijournal/global/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomizedTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String hintText;
  final FocusNode? focusNode;
  final VoidCallback? onSuffixIconClicked;
  final ValueChanged<String>? onChanged;
  final TextStyle style;
  final TextStyle hintStyle;
  final TextInputType fieldType;
  final bool isReadOnly;
  final bool isExpandable;
  final String? prefixIcon;
  final Color? prefixIconColor;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final String? suffixIcon;
  final Color? suffixIconColor;
  final Color fillColor;
  final VoidCallback? onPressed;
  final FormFieldValidator<String>? validator;

  const CustomizedTextFormField({
    super.key,
    required this.controller,
    required this.style,
    required this.hintStyle,
    this.focusNode,
    this.obscureText = false,
    this.hintText = "",
    this.onSuffixIconClicked,
    this.onChanged,
    this.onPressed,
    this.fieldType = TextInputType.name,
    required this.fillColor,
    this.isReadOnly = false,
    this.prefixIcon,
    this.prefixIconColor,
    this.suffixIcon,
    this.suffixIconColor,
    this.border,
    this.focusedBorder,
    this.validator,
    this.isExpandable = false,
  });

  @override
  State<CustomizedTextFormField> createState() => _CustomizedTextFormFieldState();
}

class _CustomizedTextFormFieldState extends State<CustomizedTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      readOnly: widget.isReadOnly,
      style: widget.style,
      focusNode: widget.focusNode,
      expands: widget.isExpandable,
      minLines: widget.isExpandable ? null : 1,
      maxLines: widget.isExpandable ? null : 1,
      textAlignVertical: TextAlignVertical.top,
      onChanged: widget.onChanged,
      onTap: widget.onPressed,
      keyboardType: widget.fieldType,
      onTapOutside: (_) => widget.focusNode == null ? FocusScope.of(context).unfocus() : widget.focusNode!.unfocus(),
      obscureText: widget.obscureText,
      validator: widget.validator,
      cursorColor: Theme.of(context).brightness == Brightness.dark ? AppColors.white : AppColors.black,
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.fillColor,
        hintFadeDuration: 500.milliseconds,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
        errorStyle: AppTextStyles.medium.copyWith(
          color: Colors.redAccent,
          fontSize: 14.sp,
        ),
        constraints: BoxConstraints(
          maxHeight: 235.h,
        ),
        border: widget.border ??
            OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: const BorderSide(color: Color(0xFFC8D1D7), width: 1.0)),
        focusedBorder: widget.focusedBorder ??
            OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: const BorderSide(color: Color(0xFFC8D1D7), width: 1.0)),
        errorBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: const BorderSide(color: Colors.redAccent, width: 2.0)),
      ),
    );
  }
}
