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
        : SizedBox(
            height: 100,
            child: ShaderMask(
              shaderCallback: getShader,
              blendMode: BlendMode.dstOut,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 15),
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
