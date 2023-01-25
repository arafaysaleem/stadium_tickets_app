import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Widgets
import '../providers/food_provider.codegen.dart';
import 'brands_list_item.dart';

class BrandsList extends ConsumerWidget {
  const BrandsList({super.key});

  Shader getShader(Rect bounds) {
    return const LinearGradient(
      stops: [0.95, 1],
      colors: [Colors.transparent, Colors.black87],
    ).createShader(bounds);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brands = ref.watch(currentCategoryProvider)?.brands;
    return brands == null
        ? Insets.shrink
        : Container(
            decoration: const BoxDecoration(
              color: AppColors.surfaceColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            height: 60,
            margin: const EdgeInsets.only(left: 15),
            padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
            child: ShaderMask(
              shaderCallback: getShader,
              blendMode: BlendMode.dstOut,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                padding: const EdgeInsets.only(left: 15),
                scrollDirection: Axis.horizontal,
                itemCount: brands.length,
                separatorBuilder: (_, __) => Insets.gapW15,
                itemBuilder: (ctx, i) => BrandsListItem(
                  brand: brands[i],
                ),
              ),
            ),
          );
  }
}
