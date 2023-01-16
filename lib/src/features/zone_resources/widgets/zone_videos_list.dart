import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// Helpers
import '../../../helpers/constants/constants.dart';

// Features
import '../../events/events.dart';

class ZoneVideosList extends StatelessWidget {
  final List<String> videoUrls;

  const ZoneVideosList({
    super.key,
    required this.videoUrls,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 15),
      itemCount: videoUrls.length,
      separatorBuilder: (_, __) => Insets.gapH15,
      itemBuilder: (context, index) => ZoneVideoListItem(
        videoUrl: videoUrls[index],
      ),
    );
  }
}

class ZoneVideoListItem extends StatefulWidget {
  const ZoneVideoListItem({
    super.key,
    required this.videoUrl,
  });

  final String videoUrl;

  @override
  State<ZoneVideoListItem> createState() => _ZoneVideoListItemState();
}

class _ZoneVideoListItemState extends State<ZoneVideoListItem> {
  late VideoPlayerController _videoPlayerController;
  bool _showControls = true;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        _videoPlayerController.addListener(() {
          final hasEnded = _videoPlayerController.value.position.inSeconds >=
              _videoPlayerController.value.duration.inSeconds;
          if (hasEnded &&
              !_videoPlayerController.value.isPlaying &&
              !_showControls) {
            _showControls = true;
          } else if (hasEnded &&
              _videoPlayerController.value.isPlaying &&
              _showControls) {
            _showControls = false;
          }
          setState(() {});
        });
        setState(() {});
      });
  }

  void _onPlay() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _showControls = true;
    } else {
      _videoPlayerController.play();
      _showControls = false;
    }
    setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController
      ..removeListener(() {})
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: Corners.rounded15,
        color: AppColors.surfaceColor,
      ),
      child: Center(
        child: Stack(
          children: [
            // Video Player
            if (_videoPlayerController.value.isInitialized)
              GestureDetector(
                onTap: () {
                  _showControls = !_showControls;
                  setState(() {});
                },
                child: ClipRRect(
                  borderRadius: Corners.rounded15,
                  child: VideoPlayer(_videoPlayerController),
                ),
              )
            else
              const EventPosterPlaceholder(),

            // Play/Pause Button
            if (_videoPlayerController.value.isInitialized)
              AnimatedSwitcher(
                duration: Durations.slow,
                child: !_showControls
                    ? Insets.shrink
                    : Align(
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white54,
                          ),
                          child: IconButton(
                            color: Colors.black,
                            padding: const EdgeInsets.all(15),
                            onPressed: _onPlay,
                            icon: Icon(
                              _videoPlayerController.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                            ),
                          ),
                        ),
                      ),
              ),

            // Video Playback Bar
            AnimatedSwitcher(
              duration: Durations.slow,
              child: !_showControls
                  ? Insets.shrink
                  : Align(
                      alignment: Alignment.bottomCenter,
                      child: VideoProgressIndicator(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
                        _videoPlayerController,
                        allowScrubbing: true,
                        colors: VideoProgressColors(
                          backgroundColor: Colors.white54,
                          bufferedColor:
                              AppColors.primaryColor.withOpacity(0.3),
                          playedColor: AppColors.primaryColor,
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
