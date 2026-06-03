import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/qiraat_reader.dart';
import '../providers/download_provider.dart';
import '../data/surah_data.dart';

class MushafViewerScreen extends StatefulWidget {
  final MushafItem mushaf;

  const MushafViewerScreen({super.key, required this.mushaf});

  @override
  State<MushafViewerScreen> createState() => _MushafViewerScreenState();
}

class _MushafViewerScreenState extends State<MushafViewerScreen> {
  late PageController _pageController;
  int _currentPage = 1;
  bool _showControls = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final surah = SurahData.getSurahByPage(_currentPage);
    final juz = SurahData.getJuzByPage(_currentPage);
    final isCover = widget.mushaf.isCoverPage(_currentPage);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E8),
      appBar: _showControls
          ? AppBar(
              title: Text(
                widget.mushaf.name,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _showJumpDialog,
                ),
                IconButton(
                  icon: const Icon(Icons.download),
                  onPressed: _downloadPdf,
                ),
              ],
            )
          : null,
      body: GestureDetector(
        onTap: () => setState(() => _showControls = !_showControls),
        child: Stack(
          children: [
            // Main page view with decorative frame
            PageView.builder(
              controller: _pageController,
              itemCount: widget.mushaf.totalPages,
              onPageChanged: (index) {
                setState(() => _currentPage = index + 1);
              },
              itemBuilder: (context, index) {
                final imageUrl = widget.mushaf.getPageImageUrl(index + 1);
                final isCurrentCover = widget.mushaf.isCoverPage(index + 1);
                return _buildDecoratedPage(imageUrl, isCurrentCover);
              },
            ),

            // Bottom controls
            if (_showControls)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.0),
                        Colors.black.withValues(alpha: 0.85),
                      ],
                    ),
                  ),
                  child: SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Surah and Juz info
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (isCover)
                              Text(
                                'صفحة غلاف / مقدمة',
                                style: const TextStyle(
                                  fontFamily: 'Cairo',
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            else if (surah != null)
                              Text(
                                surah.name,
                                style: const TextStyle(
                                  fontFamily: 'Cairo',
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            else
                              const SizedBox(),
                            if (!isCover)
                              Text(
                                'الجزء $juz',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  color: Colors.white.withValues(alpha: 0.7),
                                  fontSize: 12,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Navigation slider
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.skip_previous,
                                  color: Colors.white),
                              onPressed: _currentPage > 1
                                  ? () => _goToPage((_currentPage - 10).clamp(1, widget.mushaf.totalPages))
                                  : null,
                            ),
                            Expanded(
                              child: Slider(
                                value: _currentPage.toDouble(),
                                min: 1,
                                max: widget.mushaf.totalPages.toDouble(),
                                activeColor: const Color(0xFFD4A843),
                                inactiveColor: Colors.white.withValues(alpha: 0.3),
                                onChanged: (val) =>
                                    _goToPage(val.round()),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.skip_next,
                                  color: Colors.white),
                              onPressed: _currentPage <
                                      widget.mushaf.totalPages
                                  ? () => _goToPage((_currentPage + 10).clamp(1, widget.mushaf.totalPages))
                                  : null,
                            ),
                          ],
                        ),
                        // Page number with decorative style
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD4A843).withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'صفحة $_currentPage من ${widget.mushaf.totalPages}',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              color: const Color(0xFFD4A843),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDecoratedPage(String imageUrl, bool isCoverPage) {
    return Container(
      color: const Color(0xFFF5F0E8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: const Color(0xFFD4A843),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: Stack(
              children: [
                // Page image
                InteractiveViewer(
                  minScale: 0.5,
                  maxScale: 4.0,
                  child: Center(
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.contain,
                      loadingBuilder: (_, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                                color: const Color(0xFFD4A843),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'جاري تحميل الصفحة...',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      errorBuilder: (_, __, ___) => Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error_outline,
                                size: 48, color: Colors.grey[400]),
                            const SizedBox(height: 8),
                            Text(
                              'خطأ في تحميل الصفحة',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'تأكد من اتصال الإنترنت',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 12,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Decorative gold corner accents
                if (!isCoverPage) ...[
                  // Top-right corner decoration
                  Positioned(
                    top: 0,
                    right: 0,
                    child: CustomPaint(
                      size: const Size(30, 30),
                      painter: _CornerDecorationPainter(),
                    ),
                  ),
                  // Top-left corner decoration
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Transform.flip(
                      flipX: true,
                      child: CustomPaint(
                        size: const Size(30, 30),
                        painter: _CornerDecorationPainter(),
                      ),
                    ),
                  ),
                  // Bottom-right corner decoration
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Transform.flip(
                      flipY: true,
                      child: CustomPaint(
                        size: const Size(30, 30),
                        painter: _CornerDecorationPainter(),
                      ),
                    ),
                  ),
                  // Bottom-left corner decoration
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Transform.flip(
                      flipX: true,
                      flipY: true,
                      child: CustomPaint(
                        size: const Size(30, 30),
                        painter: _CornerDecorationPainter(),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _goToPage(int page) {
    final target = page.clamp(1, widget.mushaf.totalPages);
    _pageController.animateToPage(
      target - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _showJumpDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'الانتقال إلى صفحة',
          style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w700),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'رقم الصفحة',
                labelStyle: const TextStyle(fontFamily: 'Cairo'),
                border: const OutlineInputBorder(),
                hintText: '1 - ${widget.mushaf.totalPages}',
                hintStyle: const TextStyle(fontFamily: 'Cairo'),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFD4A843), width: 2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'أو اختر سورة',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              width: double.maxFinite,
              child: ListView.builder(
                itemCount: SurahData.surahs.length,
                itemBuilder: (_, i) {
                  final surah = SurahData.surahs[i];
                  return ListTile(
                    dense: true,
                    title: Text(
                      surah.name,
                      style: const TextStyle(
                          fontFamily: 'Cairo', fontSize: 13),
                    ),
                    trailing: Text(
                      '${surah.startPage}',
                      style: const TextStyle(
                          fontFamily: 'Cairo', fontSize: 12),
                    ),
                    onTap: () {
                      Navigator.pop(ctx);
                      // Add offset for cover pages (4 cover pages before Quran)
                      _goToPage(surah.startPage + widget.mushaf.quranStartPage - 1);
                    },
                  );
                },
              ),
            ),
          ],
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
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD4A843),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              final page = int.tryParse(controller.text);
              if (page != null &&
                  page >= 1 &&
                  page <= widget.mushaf.totalPages) {
                Navigator.pop(ctx);
                _goToPage(page);
              }
            },
            child: const Text(
              'انتقال',
              style: TextStyle(fontFamily: 'Cairo'),
            ),
          ),
        ],
      ),
    );
  }

  void _downloadPdf() {
    final downloadProvider = context.read<DownloadProvider>();
    downloadProvider.startDownload(
      mushafId: widget.mushaf.id,
      title: widget.mushaf.name,
      url: widget.mushaf.pdfUrl,
      fileName: widget.mushaf.pdfFileNameWithExt,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'بدأ تحميل: ${widget.mushaf.name}',
          style: const TextStyle(fontFamily: 'Cairo'),
        ),
        backgroundColor: const Color(0xFF388E3C),
      ),
    );
  }
}

/// Paints a decorative gold corner accent for the mushaf page frame
class _CornerDecorationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFD4A843)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.3);
    path.lineTo(size.width * 0.3, size.height * 0.3);
    path.lineTo(size.width * 0.3, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);

    // Inner accent line
    final linePaint = Paint()
      ..color = const Color(0xFFB8860B)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final linePath = Path();
    linePath.moveTo(size.width * 0.05, size.height * 0.05);
    linePath.lineTo(size.width * 0.95, size.height * 0.05);
    linePath.lineTo(size.width * 0.95, size.height * 0.35);
    linePath.lineTo(size.width * 0.35, size.height * 0.35);
    linePath.lineTo(size.width * 0.35, size.height * 0.95);
    linePath.lineTo(size.width * 0.05, size.height * 0.95);
    linePath.close();

    canvas.drawPath(linePath, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
