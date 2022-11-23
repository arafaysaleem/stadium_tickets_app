import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../providers/filter_providers.codegen.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';

// Widgets
import '../../../global/widgets/custom_text_field.dart';

class SearchBar extends ConsumerWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: CustomTextField(
        contentPadding: const EdgeInsets.fromLTRB(12, 13, 1, 22),
        onChanged: (searchTerm) => ref
            .read(searchFilterProvider.notifier)
            .update((_) => searchTerm ?? ''),
        hintText: 'Search by name',
        hintStyle: const TextStyle(
          color: AppColors.textLightGreyColor,
        ),
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.search,
        prefix: const Icon(Icons.search_rounded, size: 22),
      ),
    );
  }
}
