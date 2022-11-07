// ignore_for_file: unused_field

import 'package:flutter/material.dart';

// Helpers
import '../../helpers/constants/app_colors.dart';
import '../../helpers/constants/app_styles.dart';
import '../../helpers/constants/app_typography.dart';

//Routing
import '../../config/routes/app_router.dart';

//Widgets
import 'custom_text_button.dart';

// ignore: constant_identifier_names
enum _CustomDialogType { ALERT, CONFIRM, ABOUT, SIMPLE }

class CustomDialog extends StatelessWidget {
  final String title;
  final String body;
  final Widget? child;
  final bool isDanger;
  final bool flipButtons;
  final String? buttonText;
  final String? falseButtonText;
  final String? trueButtonText;
  final _CustomDialogType _type;
  final VoidCallback? falseButtonPressed;
  final VoidCallback? trueButtonPressed;

  static Future<void> showAlertDialog({
    required BuildContext context,
    String reason = '',
    String? dialogTitle,
    String? buttonText,
    Widget? child,
    VoidCallback? onButtonPressed,
  }) async {
    await showDialog<bool>(
      context: context,
      barrierColor: AppColors.barrierColor.withOpacity(0.75),
      builder: (ctx) => CustomDialog.alert(
        title: dialogTitle ?? 'Request Failed',
        body: reason,
        buttonText: buttonText ?? 'Retry',
        onButtonPressed: onButtonPressed,
        child: child,
      ),
    );
  }

  static Future<void> showConfirmDialog({
    required BuildContext context,
    String reason = '',
    VoidCallback? onTrueButtonPressed,
    VoidCallback? onFalseButtonPressed,
    String? dialogTitle,
    bool? flipButtons,
    String? trueButtonText,
    bool? isDanger,
    Widget? child,
    String? falseButtonText,
  }) async {
    await showDialog<bool>(
      context: context,
      barrierColor: AppColors.barrierColor.withOpacity(0.75),
      builder: (ctx) => CustomDialog.confirm(
        title: dialogTitle ?? 'Confirm Operation',
        body: reason,
        flipButtons: flipButtons,
        trueButtonText: trueButtonText ?? 'Okay',
        isDanger: isDanger,
        falseButtonText: falseButtonText ?? 'Cancel',
        trueButtonPressed: onTrueButtonPressed,
        falseButtonPressed: onFalseButtonPressed,
        child: child,
      ),
    );
  }

  const CustomDialog._({
    this.buttonText,
    this.falseButtonText,
    this.trueButtonText,
    this.falseButtonPressed,
    this.trueButtonPressed,
    this.child,
    bool? isDanger,
    bool? flipButtons,
    required this.title,
    required this.body,
    required _CustomDialogType type,
  })  : _type = type,
        flipButtons = flipButtons ?? false,
        isDanger = isDanger ?? false;

  const factory CustomDialog.alert({
    required String title,
    required String body,
    required String buttonText,
    Widget? child,
    VoidCallback? onButtonPressed,
  }) = _CustomDialogWithAlert;

  const factory CustomDialog.confirm({
    required String title,
    required String body,
    required String falseButtonText,
    required String trueButtonText,
    bool? flipButtons,
    bool? isDanger,
    Widget? child,
    VoidCallback? falseButtonPressed,
    VoidCallback? trueButtonPressed,
  }) = _CustomDialogWithConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: Corners.rounded15,
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 19),
      titlePadding: const EdgeInsets.fromLTRB(19, 14, 19, 0),
      contentPadding: const EdgeInsets.fromLTRB(19, 9, 19, 9),
      actionsPadding: const EdgeInsets.fromLTRB(0, 0, 19, 19),
      backgroundColor: AppColors.surfaceColor,
      title: Text(title),
      content: child ?? Text(body),
      contentTextStyle: AppTypography.primary.body14.copyWith(
        color: AppColors.textLightGreyColor,
      ),
      titleTextStyle: AppTypography.primary.title18,
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [..._getButtons],
        ),
      ],
    );
  }

  List<Widget> get _getButtons {
    var children = <Widget>[];
    if (_type == _CustomDialogType.ALERT) {
      children = [
        CustomTextButton.gradient(
          gradient: isDanger
              ? AppColors.buttonGradientDanger
              : AppColors.buttonGradientPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          height: 35,
          onPressed: () {
            trueButtonPressed?.call();
            AppRouter.pop();
          },
          child: Center(
            child: Text(
              buttonText!,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ];
    } else if (_type == _CustomDialogType.CONFIRM) {
      children = [
        // Yes
        CustomTextButton.outlined(
          border: Border.all(
            color: isDanger
                ? AppColors.textLightGreyColor
                : AppColors.primaryColor,
          ),
          height: 35,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          onPressed: () {
            falseButtonPressed?.call();
            AppRouter.pop(true);
          },
          child: Center(
            child: Text(
              falseButtonText!,
              style: TextStyle(
                color: isDanger
                    ? AppColors.textLightGreyColor
                    : AppColors.primaryColor,
              ),
            ),
          ),
        ),

        Insets.gapW10,

        // No
        CustomTextButton.gradient(
          gradient: isDanger
              ? AppColors.buttonGradientDanger
              : AppColors.buttonGradientPrimary,
          height: 35,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          onPressed: () {
            trueButtonPressed?.call();
            AppRouter.pop(false);
          },
          child: Center(
            child: Text(
              trueButtonText!,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ];
    }

    return flipButtons ? children.reversed.toList() : children;
  }
}

class _CustomDialogWithAlert extends CustomDialog {
  const _CustomDialogWithAlert({
    required super.title,
    required super.body,
    required String super.buttonText,
    VoidCallback? onButtonPressed,
    super.child,
  }) : super._(
          trueButtonPressed: onButtonPressed,
          type: _CustomDialogType.ALERT,
        );
}

class _CustomDialogWithConfirm extends CustomDialog {
  const _CustomDialogWithConfirm({
    required super.title,
    required super.body,
    required String super.falseButtonText,
    required String super.trueButtonText,
    super.falseButtonPressed,
    super.trueButtonPressed,
    super.isDanger,
    super.child,
    super.flipButtons,
  }) : super._(
          type: _CustomDialogType.CONFIRM,
        );
}
