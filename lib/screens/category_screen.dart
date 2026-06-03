import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../data/manuscripts_data.dart';
import '../models/qiraat_reader.dart';
import '../providers/download_provider.dart';
import '../widgets/mushaf_tile.dart';
import 'mushaf_viewer_screen.dart';

class CategoryScreen extends StatelessWidget {
  final String categoryName;
  final String? readerId;

  const CategoryScreen({
    super.key,
    required this.categoryName,
    this.readerId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(categoryName)),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    // If specific reader, show their mushafs
    if (readerId != null) {
      final reader =
          AppData.readers.firstWhere((r) => r.id == readerId);
      return _buildMushafList(context, reader.mushafs);
    }

    // Category-based content
    switch (categoryName) {
      case 'القراءات العشر':
        return _buildAllMushafs(context);
      case 'المخطوطات':
        return _buildManuscripts(context);
      default:
        // Check if it matches a reader name
        final matchingReader = AppData.readers.where(
            (r) => categoryName.contains(r.shortName) || categoryName.contains(r.name));
        if (matchingReader.isNotEmpty) {
          return _buildMushafList(context, matchingReader.first.mushafs);
        }
        return _buildAllMushafs(context);
    }
  }

  Widget _buildAllMushafs(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: AppData.allMushafs.length,
      itemBuilder: (context, index) {
        final mushaf = AppData.allMushafs[index];
        return MushafTile(
          mushaf: mushaf,
          onTap: () => _navigateToViewer(context, mushaf),
        );
      },
    );
  }

  Widget _buildMushafList(BuildContext context, List<MushafItem> mushafs) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: mushafs.length,
      itemBuilder: (context, index) {
        final mushaf = mushafs[index];
        return MushafTile(
          mushaf: mushaf,
          onTap: () => _navigateToViewer(context, mushaf),
        );
      },
    );
  }

  Widget _buildManuscripts(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: ManuscriptsData.manuscripts.length,
      itemBuilder: (context, index) {
        final ms = ManuscriptsData.manuscripts[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.withValues(alpha: 0.15),
            ),
          ),
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF8B4513).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.history_edu,
                color: Color(0xFF8B4513),
                size: 24,
              ),
            ),
            title: Text(
              ms.title,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            subtitle: Text(
              ms.source,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            trailing: const Icon(Icons.chevron_left),
            onTap: () {
              final dp = context.read<DownloadProvider>();
              dp.startDownload(
                mushafId: ms.id,
                title: ms.title,
                url: ms.pdfUrl,
                fileName: '${ms.pdfFileName}.pdf',
              );
            },
          ),
        );
      },
    );
  }

  void _navigateToViewer(BuildContext context, MushafItem mushaf) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MushafViewerScreen(mushaf: mushaf),
      ),
    );
  }
}
