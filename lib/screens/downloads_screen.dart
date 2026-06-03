import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/download_provider.dart';
import '../models/download_task.dart';
import '../widgets/empty_state.dart';

class DownloadsScreen extends StatelessWidget {
  const DownloadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('التحميلات'),
        actions: [
          Consumer<DownloadProvider>(
            builder: (_, provider, __) {
              if (provider.allTasks.isEmpty) return const SizedBox.shrink();
              return PopupMenuButton(
                itemBuilder: (_) => [
                  const PopupMenuItem(
                    value: 'clear',
                    child: Text(
                      'مسح الكل',
                      style: TextStyle(fontFamily: 'Cairo'),
                    ),
                  ),
                ],
                onSelected: (value) {
                  if (value == 'clear') {
                    _showClearDialog(context, provider);
                  }
                },
              );
            },
          ),
        ],
      ),
      body: Consumer<DownloadProvider>(
        builder: (context, provider, _) {
          if (provider.allTasks.isEmpty) {
            return const EmptyState(
              icon: Icons.download_outlined,
              title: 'لا توجد تحميلات',
              subtitle: 'قم بتحميل المصاحف لتظهر هنا',
            );
          }

          return ListView(
            padding: const EdgeInsets.all(12),
            children: [
              // Active downloads
              if (provider.activeTasks.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                  child: Text(
                    'جاري التحميل',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                ...provider.activeTasks
                    .map((task) => _DownloadTaskCard(task: task)),
                const SizedBox(height: 16),
              ],

              // Completed downloads
              if (provider.completedTasks.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                  child: Text(
                    'التحميلات المكتملة',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                ...provider.completedTasks
                    .map((task) => _DownloadTaskCard(task: task)),
              ],

              // Failed downloads
              ...provider.allTasks
                  .where((t) => t.isFailed || t.isCancelled)
                  .map((task) => _DownloadTaskCard(task: task)),
            ],
          );
        },
      ),
    );
  }

  void _showClearDialog(BuildContext context, DownloadProvider provider) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          'مسح جميع التحميلات',
          style: TextStyle(fontFamily: 'Cairo'),
        ),
        content: const Text(
          'هل تريد مسح جميع التحميلات؟ لا يمكن التراجع عن هذا الإجراء.',
          style: TextStyle(fontFamily: 'Cairo'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'إلغاء',
              style: TextStyle(fontFamily: 'Cairo'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              provider.clearAllDownloads();
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD32F2F),
            ),
            child: const Text(
              'مسح الكل',
              style: TextStyle(fontFamily: 'Cairo', color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _DownloadTaskCard extends StatelessWidget {
  final DownloadTask task;

  const _DownloadTaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<DownloadProvider>();

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  task.title,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              _buildStatusIcon(),
            ],
          ),
          if (task.isActive) ...[
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: task.progress,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF016E80),
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  task.progressText,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 11,
                    color: Colors.grey[600],
                  ),
                ),
                if (task.totalBytes != null)
                  Text(
                    '${task.receivedSizeText} / ${task.fileSizeText}',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 11,
                      color: Colors.grey[600],
                    ),
                  ),
              ],
            ),
          ],
          if (task.isCompleted) ...[
            const SizedBox(height: 4),
            Text(
              'تم التحميل${task.fileSizeText.isNotEmpty ? ' - ${task.fileSizeText}' : ''}',
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 11,
                color: Color(0xFF388E3C),
              ),
            ),
          ],
          if (task.isFailed) ...[
            const SizedBox(height: 4),
            Text(
              task.errorMessage ?? 'فشل التحميل',
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 11,
                color: Color(0xFFD32F2F),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (task.isActive)
                TextButton.icon(
                  onPressed: () => provider.cancelDownload(task.mushafId),
                  icon: const Icon(Icons.stop, size: 16),
                  label: const Text(
                    'إيقاف',
                    style: TextStyle(fontFamily: 'Cairo', fontSize: 12),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFFD32F2F),
                  ),
                ),
              if (task.isCompleted) ...[
                TextButton.icon(
                  onPressed: () async {
                    final file = File(task.savePath);
                    if (await file.exists()) {
                      final uri = Uri.file(task.savePath);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                      }
                    }
                  },
                  icon: const Icon(Icons.open_in_new, size: 16),
                  label: const Text(
                    'فتح',
                    style: TextStyle(fontFamily: 'Cairo', fontSize: 12),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF016E80),
                  ),
                ),
                const SizedBox(width: 4),
                TextButton.icon(
                  onPressed: () =>
                      provider.deleteDownload(task.mushafId),
                  icon: const Icon(Icons.delete_outline, size: 16),
                  label: const Text(
                    'حذف',
                    style: TextStyle(fontFamily: 'Cairo', fontSize: 12),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFFD32F2F),
                  ),
                ),
              ],
              if (task.isFailed || task.isCancelled)
                TextButton.icon(
                  onPressed: () => provider.retryDownload(task.mushafId),
                  icon: const Icon(Icons.refresh, size: 16),
                  label: const Text(
                    'إعادة',
                    style: TextStyle(fontFamily: 'Cairo', fontSize: 12),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF016E80),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIcon() {
    if (task.isActive) {
      return const SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }
    if (task.isCompleted) {
      return const Icon(Icons.check_circle, color: Color(0xFF388E3C), size: 20);
    }
    if (task.isFailed) {
      return const Icon(Icons.error, color: Color(0xFFD32F2F), size: 20);
    }
    if (task.isCancelled) {
      return const Icon(Icons.cancel, color: Colors.orange, size: 20);
    }
    return const SizedBox.shrink();
  }
}
