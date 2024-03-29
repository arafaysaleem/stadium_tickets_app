import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Routing
import '../../../config/routing/routing.dart';

// Providers
import '../providers/zone_seats_provider.codegen.dart';

// Widgets
import '../../../global/widgets/widgets.dart';

class SelectSeatsButton extends StatelessWidget {
  const SelectSeatsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Consumer(
        builder: (ctx, ref, _) {
          final seats = ref.watch(selectedSeatsProvider).length;
          return CustomTextButton.gradient(
            width: double.infinity,
            onPressed: () {
              AppRouter.pushNamed(Routes.TicketsSummaryScreenRoute);
            },
            disabled: seats == 0,
            gradient: AppColors.buttonGradientPrimary,
            child: Center(
              child: Text(
                'Select - $seats SEATS',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  letterSpacing: 0.7,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
