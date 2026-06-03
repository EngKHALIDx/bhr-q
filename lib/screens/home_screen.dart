import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/constants.dart';
import '../data/app_data.dart';
import '../data/manuscripts_data.dart';
import '../providers/theme_provider.dart';
import '../widgets/reader_card.dart';
import '../widgets/category_card.dart';
import '../widgets/section_header.dart';
import '../models/mushaf_item.dart';
import 'search_screen.dart';
import 'library_screen.dart';
import 'downloads_screen.dart';
import 'settings_screen.dart';
import 'reader_detail_screen.dart';
import 'category_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      _buildHomeContent(),
      const LibraryScreen(),
      const DownloadsScreen(),
      const SettingsScreen(),
    ];

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books_outlined),
            activeIcon: Icon(Icons.library_books),
            label: 'المكتبة',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.download_outlined),
            activeIcon: Icon(Icons.download),
            label: 'التحميلات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'الإعدادات',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeContent() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 160,
          pinned: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.dark_mode_outlined),
              onPressed: () {
                context.read<ThemeProvider>().toggleTheme();
              },
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            title: const Text(
              'بحر القراءات',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w700,
              ),
            ),
            background: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF016E80), Color(0xFF014D5C)],
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        'المصاحف القرائية العشر',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 14,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        // Search bar
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchScreen()),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey[500]),
                    const SizedBox(width: 12),
                    Text(
                      'ابحث عن مصحف أو قارئ...',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        color: Colors.grey[500],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // القراءات العشر
        SliverToBoxAdapter(
          child: SectionHeader(
            title: 'القراءات العشر',
            icon: Icons.auto_stories,
            onSeeAll: () => _navigateToLibrary(),
          ),
        ),

        // Reader cards horizontal list
        SliverToBoxAdapter(
          child: SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: AppData.readers.length,
              itemBuilder: (context, index) {
                final reader = AppData.readers[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: ReaderCard(
                    reader: reader,
                    onTap: () => _navigateToReader(reader.id),
                  ),
                );
              },
            ),
          ),
        ),

        // تصفح المصاحف
        SliverToBoxAdapter(
          child: SectionHeader(
            title: 'تصفح المصاحف',
            icon: Icons.explore,
            onSeeAll: () => _navigateToLibrary(),
          ),
        ),

        // Category cards grid
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            delegate: SliverChildListDelegate([
              CategoryCard(
                title: 'القراءات العشر',
                icon: Icons.auto_stories,
                color: const Color(0xFF016E80),
                count: '${AppData.allMushafs.length} مصحف',
                onTap: () => _navigateToCategory('القراءات العشر'),
              ),
              CategoryCard(
                title: 'مجمع المدينة',
                icon: Icons.mosque,
                color: const Color(0xFF2E7D32),
                count: 'مصاحف متعددة',
                onTap: () => _navigateToCategory('مجمع المدينة'),
              ),
              CategoryCard(
                title: 'رواية حفص',
                icon: Icons.menu_book,
                color: const Color(0xFF6A1B9A),
                count: 'مصاحف متعددة',
                onTap: () => _navigateToCategory('رواية حفص'),
              ),
              CategoryCard(
                title: 'قراءة نافع',
                icon: Icons.import_contacts,
                color: const Color(0xFF1565C0),
                count: '6 مصاحف',
                onTap: () => _navigateToCategory('قراءة نافع'),
              ),
              CategoryCard(
                title: 'المخطوطات',
                icon: Icons.history_edu,
                color: const Color(0xFF8B4513),
                count: '${ManuscriptsData.manuscripts.length} مخطوطة',
                onTap: () => _navigateToCategory('المخطوطات'),
              ),
              CategoryCard(
                title: 'المكتبة الكاملة',
                icon: Icons.library_books,
                color: const Color(0xFFD4A843),
                count: 'تصفح الكل',
                onTap: () => _navigateToLibrary(),
              ),
            ]),
          ),
        ),

        // المخطوطات
        SliverToBoxAdapter(
          child: SectionHeader(
            title: 'المخطوطات',
            icon: Icons.history_edu,
            onSeeAll: () => _navigateToCategory('المخطوطات'),
          ),
        ),

        SliverToBoxAdapter(
          child: SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: ManuscriptsData.manuscripts.length > 6
                  ? 6
                  : ManuscriptsData.manuscripts.length,
              itemBuilder: (context, index) {
                final ms = ManuscriptsData.manuscripts[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: _ManuscriptCard(manuscript: ms),
                );
              },
            ),
          ),
        ),

        // روابط سريعة
        SliverToBoxAdapter(
          child: SectionHeader(
            title: 'روابط سريعة',
            icon: Icons.link,
          ),
        ),

        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _QuickLinkTile(
                title: 'عن التطبيق',
                icon: Icons.info_outline,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const _AboutPage()),
                ),
              ),
              _QuickLinkTile(
                title: 'زيارة الموقع',
                icon: Icons.language,
                onTap: () {},
              ),
            ]),
          ),
        ),
      ],
    );
  }

  void _navigateToReader(String readerId) {
    final reader =
        AppData.readers.firstWhere((r) => r.id == readerId);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ReaderDetailScreen(reader: reader),
      ),
    );
  }

  void _navigateToLibrary() {
    setState(() => _currentIndex = 1);
  }

  void _navigateToCategory(String categoryName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CategoryScreen(categoryName: categoryName),
      ),
    );
  }
}

class _ManuscriptCard extends StatelessWidget {
  final ManuscriptItem manuscript;

  const _ManuscriptCard({required this.manuscript});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF8B4513).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.history_edu,
                  color: Color(0xFF8B4513),
                  size: 20,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  manuscript.title,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            manuscript.source,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 11,
              color: Colors.grey[600],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _QuickLinkTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _QuickLinkTile({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: const Color(AppConstants.primaryColorValue)),
      title: Text(
        title,
        style: const TextStyle(fontFamily: 'Cairo', fontSize: 14),
      ),
      trailing: const Icon(Icons.chevron_left),
      onTap: onTap,
    );
  }
}

class _AboutPage extends StatelessWidget {
  const _AboutPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('عن التطبيق')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: const Color(AppConstants.primaryColorValue).withValues(alpha: 0.1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    'assets/images/app_icon.png',
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.menu_book,
                      size: 50,
                      color: Color(AppConstants.primaryColorValue),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'بحر القراءات',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'الإصدار 2.0.0',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'تطبيق بحر القراءات هو مرجع شامل للمصاحف القرائية العشر، يتيح لك تصفح أكثر من 41 مصحفاً برواياتها المختلفة مع إمكانية التحميل والعرض.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 14,
                height: 1.8,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'bhr-q.com',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(AppConstants.primaryColorValue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
