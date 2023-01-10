import 'package:flutter/material.dart';

// Helpers
import '../../helpers/constants/app_colors.dart';
import '../../helpers/constants/app_styles.dart';

//Services
import '../../core/networking/custom_exception.dart';

//Widgets
import 'custom_text_button.dart';

class CustomErrorWidget extends StatelessWidget {
  final CustomException error;
  final Color backgroundColor;
  final Color fontColor;
  final double height;
  final VoidCallback retryCallback;

  const CustomErrorWidget._({
    required this.error,
    required this.backgroundColor,
    required this.fontColor,
    required this.retryCallback,
    required this.height,
  });

  const factory CustomErrorWidget.dark({
    required CustomException error,
    required VoidCallback retryCallback,
    double? height,
  }) = _CustomErrorWidgetDark;

  const factory CustomErrorWidget.light({
    required CustomException error,
    required VoidCallback retryCallback,
    double? height,
  }) = _CustomErrorWidgetLight;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: Corners.rounded15,
        ),
        height: height,
        padding: const EdgeInsets.fromLTRB(30, 25, 30, 35),
        child: Center(
          child: Column(
            children: [
              const Text(
                'Oops',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 45,
                ),
              ),
              Insets.gapH30,
              Text(
                error.message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 21,
                  color: fontColor,
                ),
              ),
              Insets.expand,
              CustomTextButton.gradient(
                width: double.infinity,
                onPressed: retryCallback,
                gradient: AppColors.buttonGradientPrimary,
                child: const Center(
                  child: Text(
                    'RETRY',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      letterSpacing: 1.1,
                      fontWeight: FontWeight.w600,
                    ),
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

class _CustomErrorWidgetDark extends CustomErrorWidget {
  const _CustomErrorWidgetDark({
    required super.error,
    required super.retryCallback,
    double? height,
  }) : super._(
          backgroundColor: AppColors.surfaceColor,
          fontColor: AppColors.textWhite80Color,
          height: height ?? double.infinity,
        );
}

class _CustomErrorWidgetLight extends CustomErrorWidget {
  const _CustomErrorWidgetLight({
    required super.error,
    required super.retryCallback,
    double? height,
  }) : super._(
          backgroundColor: AppColors.surfaceColor,
          fontColor: AppColors.textBlackColor,
          height: height ?? double.infinity,
        );
}
