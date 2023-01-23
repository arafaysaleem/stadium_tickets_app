import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Models
import '../models/category_model.codegen.dart';

// Providers
import '../providers/food_provider.codegen.dart';

// Widgets
import '../../../global/widgets/widgets.dart';
import 'categories_list_item.dart';

class CategoriesList extends ConsumerWidget {
  const CategoriesList({super.key});

  Shader getShader(Rect bounds) {
    return const LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
      stops: [0.95, 1],
      colors: [Colors.transparent, Colors.black87],
    ).createShader(bounds);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget<List<CategoryModel>>(
      value: ref.watch(categoriesFutureProvider),
      loading: () => const Padding(
        padding: EdgeInsets.only(top: 70),
        child: CustomCircularLoader(),
      ),
      error: (error, st) => ErrorResponseHandler(
        error: error,
        retryCallback: () {},
        stackTrace: st,
      ),
      emptyOrNull: () => const EmptyStateWidget(
        height: 395,
        width: double.infinity,
        margin: EdgeInsets.only(top: 15),
        title: 'No Parkings found',
        subtitle: 'Try checking back later',
      ),
      data: (floors) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.surfaceColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          height: 60,
          margin: const EdgeInsets.only(right: 15),
          padding: const EdgeInsets.fromLTRB(0, 15, 15, 15),
          child: ShaderMask(
            shaderCallback: getShader,
            blendMode: BlendMode.dstOut,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              reverse: true,
              padding: const EdgeInsets.only(left: 15),
              scrollDirection: Axis.horizontal,
              itemCount: floors.length,
              separatorBuilder: (_, __) => Insets.gapW15,
              itemBuilder: (ctx, i) => CategoriesListItem(
                category: floors[i],
              ),
            ),
          ),
        );
      },
    );
  }
}
