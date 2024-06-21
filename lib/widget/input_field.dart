// ignore_for_file: must_be_immutable

import 'package:adhkaar/themes/app_color.dart';
import 'package:adhkaar/widget/iconss.dart';
import 'package:adhkaar/widget/spacing.dart';
import 'package:adhkaar/widget/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class InputField extends StatefulWidget {
  InputField({
    this.hintText,
    this.onChanged,
    this.isPassword = false,
    this.showVisibility = true,
    this.showCursor = true,
    this.fillColor,
    this.fieldController,
    this.hintColor,
    this.fieldTitle,
    this.onTap,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines,
    this.maxLength,
    this.radius,
    this.extra,
    this.isOptional = false,
    this.fieldGroupColors,
    this.enabledBorderColor,
    this.showWordCount = false,
    this.readOnly = false,
    this.contentPadding,
    this.titleIcon,
    this.labelText,
    this.autofocus = false,
    this.validator,
    this.focusedBorderColor,
    this.inputType = TextInputType.text,
    super.key,
  });
  Color? fillColor,
      hintColor,
      enabledBorderColor,
      focusedBorderColor,
      fieldGroupColors;
  String? hintText, fieldTitle, labelText;
  double? radius, extra;
  TextInputType inputType;
  EdgeInsets? contentPadding;
  int? maxLines, maxLength;
  TextEditingController? fieldController;
  VoidCallback? onTap;
  Widget? suffixIcon;
  String? Function(String?)? validator;
  Widget? prefixIcon, titleIcon;
  bool isPassword,
      showVisibility,
      showCursor,
      showWordCount,
      autofocus,
      isOptional,
      readOnly;

  void Function(String?)? onChanged;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
    return Column(
      children: [
        widget.fieldTitle == null
            ? const SizedBox.shrink()
            : Column(
                children: [
                  Row(
                    children: [
                      TextOf(
                        widget.fieldTitle!,
                        16.sp,
                        5,
                        align: TextAlign.left,
                        color: widget.fieldGroupColors,
                      ),
                      widget.isOptional == true
                          ? TextOf(
                              "  (Optional)",
                              16,
                              4,
                              align: TextAlign.left,
                            )
                          : const SizedBox.shrink(),
                      widget.titleIcon != null
                          ? Padding(
                              padding: EdgeInsets.only(left: 5.sp),
                              child: widget.titleIcon!)
                          : const SizedBox.shrink()
                    ],
                  ),
                  YMargin(8.sp),
                ],
              ),
        SizedBox(
          child: Center(
            child: TextFormField(
              onChanged: widget.onChanged,
              controller: widget.fieldController,
              autofocus: widget.autofocus,
              readOnly: widget.readOnly,
              cursorColor: AppColors.primaryColor,
              onTap: () {
                if (widget.onTap != null) {
                  widget.onTap!();
                }
              },
              validator: widget.validator,
              showCursor: widget.showCursor,
              maxLength: widget.maxLength,
              maxLines: widget.maxLines ?? 1,
              keyboardType: widget.inputType,
              obscureText: widget.isPassword == true ? obscureText : false,
              style: TextStyle(
                  // fontFamily: Fonts.nunito,
                  color: widget.fieldGroupColors ?? AppColors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  decoration: TextDecoration.none,
                  decorationColor: Colors.transparent),
              decoration: InputDecoration(
                  fillColor: AppColors.secondaryColor.withOpacity(0.1),
                  filled: true,
                  contentPadding: widget.contentPadding ??
                      EdgeInsets.symmetric(vertical: 16.sp, horizontal: 10.sp),
                  labelText: widget.labelText,
                  labelStyle: TextStyle(
                      //fontFamily: Fonts.nunito,
                      color: widget.fieldGroupColors ??
                          widget.hintColor ??
                          AppColors.grey3,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.sp),
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                      // fontFamily: Fonts.nunito,
                      color: widget.fieldGroupColors ??
                          widget.hintColor ??
                          AppColors.grey3,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.sp),
                  //  suffix: widget.suffixIcon ?? SizedBox.shrink(),
                  prefixIcon: widget.prefixIcon,
                  prefixIconConstraints: BoxConstraints(
                      maxHeight: 30.sp,
                      maxWidth: 60.sp,
                      minHeight: 25.sp,
                      minWidth: 55.sp),
                  suffixIconConstraints: BoxConstraints(
                      maxHeight: 37.5.sp + (widget.extra ?? 0),
                      maxWidth: 45.sp + (widget.extra ?? 0),
                      minHeight: 24.5.sp + (widget.extra ?? 0),
                      minWidth: 35.sp + (widget.extra ?? 0)),
                  suffixIcon: widget.suffixIcon != null
                      ? Padding(
                          padding: EdgeInsets.only(right: 15.sp),
                          child: widget.suffixIcon,
                        )
                      : (widget.isPassword
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                              child: IconOf(obscureText == true
                                  ? Icons.visibility
                                  : Icons.visibility_off))
                          : const SizedBox.shrink()),
                  enabledBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(widget.radius ?? 12.r),
                      borderSide: BorderSide(
                        color: widget.fieldGroupColors ??
                            widget.enabledBorderColor ??
                            AppColors.primaryColor,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(widget.radius ?? 12.r),
                      borderSide: BorderSide(
                        color: widget.fieldGroupColors ??
                            widget.focusedBorderColor ??
                            AppColors.grey3,
                      )),
                  counterText: widget.showWordCount == true
                      ? "${widget.fieldController!.text.length}/${widget.maxLength} characters"
                      : null),
            ),
          ),
        ),
      ],
    );
  }
}
