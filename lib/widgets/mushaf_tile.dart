import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/qiraat_reader.dart';
import '../providers/download_provider.dart';
import '../providers/favorites_provider.dart';
import 'download_progress_bar.dart';

class MushafTile extends StatelessWidget {
  final MushafItem mushaf;
  final VoidCallback? onTap;

  const MushafTile({
    super.key,
    required this.mushaf,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer2<DownloadProvider, FavoritesProvider>(
      builder: (context, downloadProvider, favProvider, _) {
        final isDownloading = downloadProvider.isDownloading(mushaf.id);
        final isDownloaded = downloadProvider.isDownloaded(mushaf.id);
        final progress = downloadProvider.getProgress(mushaf.id);
        final task = downloadProvider.getTask(mushaf.id);
        final isFailed = task != null && task.isFailed;
        final isFav = favProvider.isFavorite(mushaf.id);

        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.withValues(alpha: 0.15),
            ),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Cover image or icon
                      Container(
                        width: 48,
                        height: 64,
                        decoration: BoxDecoration(
                          color: const Color(0xFF016E80).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: (mushaf.coverImageUrl != null &&
                                mushaf.coverImageUrl!.isNotEmpty)
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.network(
                                  mushaf.coverImageUrl!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => const Center(
                                    child: Icon(
                                      Icons.menu_book,
                                      color: Color(0xFF016E80),
                                      size: 24,
                                    ),
                                  ),
                                ),
                              )
                            : const Center(
                                child: Icon(
                                  Icons.menu_book,
                                  color: Color(0xFF016E80),
                                  size: 24,
                                ),
                              ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mushaf.name,
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'رواية: ${mushaf.rawiName}',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 11,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              '${mushaf.totalPages} صفحة',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 11,
                                color: Colors.grey[500],
                              ),
                            ),
                            if (mushaf.description != null &&
                                mushaf.description!.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text(
                                mushaf.description!,
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 10,
                                  color: Colors.grey[500],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ],
                        ),
                      ),
                      // Favorite button
                      IconButton(
                        icon: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav
                              ? const Color(0xFFD32F2F)
                              : Colors.grey[400],
                          size: 20,
                        ),
                        onPressed: () =>
                            favProvider.toggleFavorite(mushaf.id),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),

                  // Download progress or buttons
                  if (isDownloading) ...[
                    const SizedBox(height: 8),
                    DownloadProgressBar(progress: progress),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${(progress * 100).toStringAsFixed(0)}%',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () =>
                              downloadProvider.cancelDownload(mushaf.id),
                          icon: const Icon(Icons.stop, size: 14),
                          label: const Text(
                            'إيقاف',
                            style: TextStyle(
                                fontFamily: 'Cairo', fontSize: 11),
                          ),
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xFFD32F2F),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8),
                          ),
                        ),
                      ],
                    ),
                  ] else if (isFailed) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.error_outline,
                            size: 14, color: Color(0xFFD32F2F)),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            task?.errorMessage ?? 'فشل التحميل',
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 11,
                              color: Color(0xFFD32F2F),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () =>
                              downloadProvider.retryDownload(mushaf.id),
                          icon: const Icon(Icons.refresh, size: 14),
                          label: const Text(
                            'إعادة',
                            style: TextStyle(
                                fontFamily: 'Cairo', fontSize: 11),
                          ),
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xFF016E80),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8),
                          ),
                        ),
                      ],
                    ),
                  ] else if (isDownloaded) ...[
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(Icons.check_circle,
                            size: 14, color: Color(0xFF388E3C)),
                        const SizedBox(width: 4),
                        const Text(
                          'تم التحميل',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 11,
                            color: Color(0xFF388E3C),
                          ),
                        ),
                        const Spacer(),
                        TextButton.icon(
                          onPressed: () =>
                              downloadProvider.deleteDownload(mushaf.id),
                          icon: const Icon(Icons.delete_outline, size: 14),
                          label: const Text(
                            'حذف',
                            style: TextStyle(
                                fontFamily: 'Cairo', fontSize: 11),
                          ),
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xFFD32F2F),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8),
                          ),
                        ),
                      ],
                    ),
                  ] else ...[
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            downloadProvider.startDownload(
                              mushafId: mushaf.id,
                              title: mushaf.name,
                              url: mushaf.pdfUrl,
                              fileName: mushaf.pdfFileNameWithExt,
                            );
                          },
                          icon: const Icon(Icons.download, size: 16),
                          label: const Text(
                            'تحميل PDF',
                            style: TextStyle(
                                fontFamily: 'Cairo', fontSize: 12),
                          ),
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xFF016E80),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
