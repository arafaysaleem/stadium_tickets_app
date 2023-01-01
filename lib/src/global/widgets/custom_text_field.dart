import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Helpers
import '../../helpers/constants/app_colors.dart';
import '../../helpers/constants/app_styles.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final double? width;
  final double? height;
  final int? maxLength;
  final String? floatingText;
  final String? hintText;
  final TextStyle hintStyle;
  final TextStyle errorStyle;
  final TextStyle inputStyle;
  final TextStyle? floatingStyle;
  final EdgeInsets? contentPadding;
  final void Function(String? value)? onSaved;
  final void Function(String? value)? onChanged;
  final Widget? prefix;
  final Widget? suffix;
  final bool showCursor;
  final bool? enabled;
  final bool multiline;
  final bool expands;
  final bool readOnly;
  final bool autofocus;
  final bool showErrorBorder;
  final bool showErrorMessage;
  final bool showFocusedBorder;
  final BorderSide border;
  final BorderSide focusedBorder;
  final TextAlign textAlign;
  final TextAlignVertical textAlignVertical;
  final Alignment errorAlign;
  final Alignment floatingAlign;
  final Color fillColor;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String? value)? validator;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    super.key,
    this.controller,
    this.width,
    this.maxLength,
    this.floatingText,
    this.floatingStyle,
    this.onSaved,
    this.onChanged,
    this.prefix,
    this.suffix,
    this.enabled,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.hintText,
    this.validator,
    this.height = 47,
    this.readOnly = false,
    this.showFocusedBorder = true,
    this.multiline = false,
    this.expands = false,
    this.showCursor = true,
    this.showErrorBorder = false,
    this.showErrorMessage = true,
    this.autofocus = false,
    this.textAlign = TextAlign.start,
    this.border = BorderSide.none,
    this.focusedBorder = const BorderSide(
      color: AppColors.primaryColor,
      width: 2,
    ),
    this.textAlignVertical = TextAlignVertical.center,
    this.errorAlign = Alignment.centerRight,
    this.floatingAlign = Alignment.centerLeft,
    this.fillColor = AppColors.fieldFillColor,
    this.hintStyle = const TextStyle(
      fontSize: 16,
      color: AppColors.textWhite80Color,
    ),
    this.errorStyle = const TextStyle(
      height: 0.01,
      color: Colors.transparent,
    ),
    this.inputStyle = const TextStyle(
      fontSize: 16,
      color: AppColors.textWhite80Color,
    ),
    this.contentPadding = const EdgeInsets.fromLTRB(12, 13, 1, 16),
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? errorText;
  bool hidePassword = true;

  bool get hasError => errorText != null;

  bool get showErrorBorder => widget.showErrorBorder && hasError;

  bool get hasFloatingText => widget.floatingText != null;

  bool get isPasswordField =>
      widget.keyboardType == TextInputType.visiblePassword;

  void _onSaved(String? value) {
    final trimmedValue = value!.trim();
    widget.controller?.text = trimmedValue;
    widget.onSaved?.call(trimmedValue);
  }

  void _onChanged(String value) {
    if (widget.onChanged != null) {
      _runValidator(value);
      widget.onChanged!(value);
    }
  }

  String? _runValidator(String? value) {
    final error = widget.validator?.call(value!.trim());
    setState(() {
      errorText = error;
    });
    return error;
  }

  void _togglePasswordVisibility() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  OutlineInputBorder _focusedBorder() {
    return OutlineInputBorder(
      borderRadius: Corners.rounded7,
      borderSide: widget.focusedBorder,
    );
  }

  OutlineInputBorder _normalBorder() {
    return OutlineInputBorder(
      borderRadius: Corners.rounded7,
      borderSide: widget.border,
    );
  }

  OutlineInputBorder _errorBorder() {
    return const OutlineInputBorder(
      borderRadius: Corners.rounded7,
      borderSide: BorderSide(
        width: 2,
        color: AppColors.redColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Floating text
        if (hasFloatingText) ...[
          SizedBox(
            width: widget.width,
            child: Align(
              alignment: widget.floatingAlign,
              child: Text(
                widget.floatingText!,
                style: widget.floatingStyle ?? const TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 4),
        ],

        // TextField
        SizedBox(
          height: widget.height,
          width: widget.width,
          child: TextFormField(
            controller: widget.controller,
            textAlign: widget.textAlign,
            textAlignVertical: widget.textAlignVertical,
            autofocus: widget.autofocus,
            maxLength: widget.maxLength,
            enabled: widget.enabled,
            expands: widget.expands,
            readOnly: widget.readOnly,
            maxLines: widget.multiline ? null : 1,
            keyboardType: widget.keyboardType ??
                (widget.multiline ? TextInputType.multiline : null),
            textInputAction: widget.textInputAction ??
                (widget.multiline ? TextInputAction.newline : null),
            inputFormatters: widget.inputFormatters,
            style: widget.inputStyle,
            showCursor: widget.showCursor,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            autovalidateMode: AutovalidateMode.disabled,
            cursorColor: widget.inputStyle.color,
            obscureText: isPasswordField && hidePassword,
            validator: _runValidator,
            onFieldSubmitted: _runValidator,
            onSaved: _onSaved,
            onChanged: _onChanged,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: widget.hintStyle,
              errorStyle: widget.errorStyle,
              fillColor: widget.fillColor,
              prefixIcon: widget.prefix,
              contentPadding: widget.contentPadding,
              isDense: true,
              filled: true,
              counterText: '',
              border: _normalBorder(),
              enabledBorder: (widget.showErrorBorder && hasError)
                  ? _errorBorder()
                  : _normalBorder(),
              focusedBorder: widget.showFocusedBorder ? _focusedBorder() : null,
              suffixIcon: widget.suffix ??
                  (isPasswordField
                      ? InkWell(
                          onTap: _togglePasswordVisibility,
                          child: const Icon(
                            Icons.remove_red_eye_sharp,
                            color: AppColors.textGreyColor,
                            size: 22,
                          ),
                        )
                      : null),
            ),
          ),
        ),

        // Error text
        if (hasError && widget.showErrorMessage) ...[
          Insets.gapH3,
          SizedBox(
            width: widget.width,
            child: Align(
              alignment: widget.errorAlign,
              child: Text(
                errorText!,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.redColor,
                ),
              ),
            ),
          ),
        ]
      ],
    );
  }
}
