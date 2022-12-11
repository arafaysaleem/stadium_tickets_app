import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Routing
import '../../../config/routing/routing.dart';

// Providers
import '../providers/parking_spaces_provider.codegen.dart';

// Widgets
import '../../../global/widgets/widgets.dart';

class SelectSpacesButton extends ConsumerWidget {
  const SelectSpacesButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seats = ref.watch(
      parkingSpacesProvider.select(
        (value) =>
            value.values.fold(0, (prev, element) => prev + element.length),
      ),
    );
    final confirmedSeats = ref.watch(
      confirmedParkingSpacesProvider.select(
        (value) =>
            value.values.fold(0, (prev, element) => prev + element.length),
      ),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomTextButton.gradient(
        width: double.infinity,
        onPressed: () {
          ref.read(confirmedParkingSpacesProvider.notifier).state = {
            ...ref.read(parkingSpacesProvider)
          };
          AppRouter.pop();
        },
        disabled: seats == 0 && confirmedSeats == 0,
        gradient: AppColors.buttonGradientPrimary,
        child: Center(
          child: Text(
            'Select - $seats SPOTS',
            style: const TextStyle(
              color: Colors.white,
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
