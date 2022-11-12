import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../providers/filter_providers.codegen.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';

// Widgets
import '../../../global/widgets/custom_textfield.dart';

class SearchBar extends ConsumerWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Container(
        height: 47,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: Corners.rounded7,
          boxShadow: Shadows.elevated,
        ),
        child: CustomTextField(
          onChanged: (searchTerm) => ref
              .read(searchFilterProvider.notifier)
              .update((_) => searchTerm ?? ''),
          hintText: 'Search by name',
          hintStyle: const TextStyle(
            color: AppColors.textLightGreyColor,
          ),
          fillColor: Colors.white,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.search,
          prefix: const Icon(
            Icons.search_rounded,
            size: 22,
          ),
        ),
      ),
    );
  }
}
