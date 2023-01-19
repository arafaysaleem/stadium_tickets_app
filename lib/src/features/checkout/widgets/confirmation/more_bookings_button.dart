import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../../helpers/constants/constants.dart';

// Routing
import '../../../../config/routing/routing.dart';

// Widgets
import '../../../../global/widgets/widgets.dart';

// Providers
import '../../providers/checkout_provider.codegen.dart';

class MoreBookingsButton extends ConsumerWidget {
  const MoreBookingsButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: CustomTextButton(
        width: double.infinity,
        onPressed: () {
          AppRouter.popUntil(Routes.EventsScreenRoute);
          ref.invalidate(checkoutProvider);
        },
        color: AppColors.textWhite80Color,
        child: const Center(
          child: Text(
            'MAKE MORE BOOKINGS',
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 15,
              letterSpacing: 0.7,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
