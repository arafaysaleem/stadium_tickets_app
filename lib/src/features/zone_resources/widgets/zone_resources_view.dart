import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../models/zone_resource_model.codegen.dart';

// Enums
import '../enums/resource_type_enum.dart';

// Providers
import '../providers/zone_resources_provider.codegen.dart';

// Widgets
import '../../../global/widgets/async_value_widget.dart';
import '../../../global/widgets/custom_circular_loader.dart';
import '../../../global/widgets/empty_state_widget.dart';
import '../../../global/widgets/error_response_handler.dart';
import 'resource_type_slider.dart';
import 'zone_images_list.dart';
import 'zone_videos_list.dart';

class ZoneResourcesView extends ConsumerWidget {
  const ZoneResourcesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSegmentValue = ref.watch(resourceTypeProvider);
    return AsyncValueWidget<List<ZoneResourceModel>>(
      value: ref.watch(zoneResourcesFutureProvider),
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
        margin: EdgeInsets.only(top: 20),
        title: 'No resources uploaded yet',
        subtitle: 'Check back later',
      ),
      data: (resources) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          switchInCurve: Curves.easeIn,
          child: selectedSegmentValue == 0
              ? ZoneImagesList(
                  imageUrls: [
                    ...resources
                        .where((e) => e.type == ResourceType.IMAGE)
                        .map((e) => e.resourceUrl)
                  ],
                )
              : ZoneVideosList(
                  videoUrls: [
                    ...resources
                        .where((e) => e.type == ResourceType.VIDEO)
                        .map((e) => e.resourceUrl)
                  ],
                ),
        );
      },
    );
  }
}
