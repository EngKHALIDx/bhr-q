import 'package:flutter/material.dart';

class DownloadProgressBar extends StatelessWidget {
  final double progress;

  const DownloadProgressBar({
    super.key,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            minHeight: 8,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              progress >= 1.0
                  ? const Color(0xFF388E3C)
                  : const Color(0xFF016E80),
            ),
          ),
        ),
      ],
    );
  }
}
