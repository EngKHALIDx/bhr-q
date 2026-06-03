import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import '../data/app_data.dart';
import '../models/qiraat_reader.dart';
import 'reader_detail_screen.dart';
import 'mushaf_viewer_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<QiraatReader> _readerResults = [];
  List<MushafItem> _mushafResults = [];
  List<String> _recentSearches = [];
  bool _hasSearched = false;

  @override
  void initState() {
    super.initState();
    _loadRecentSearches();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadRecentSearches() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/recent_searches.json');
      if (await file.exists()) {
        final list = jsonDecode(await file.readAsString()) as List;
        setState(() {
          _recentSearches = list.cast<String>();
        });
      }
    } catch (_) {}
  }

  Future<void> _saveRecentSearch(String query) async {
    _recentSearches = [
      query,
      ..._recentSearches.where((s) => s != query),
    ].take(10).toList();
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/recent_searches.json');
      await file.writeAsString(jsonEncode(_recentSearches));
    } catch (_) {}
  }

  void _performSearch(String query) {
    if (query.trim().isEmpty) {
      setState(() {
        _readerResults = [];
        _mushafResults = [];
        _hasSearched = false;
      });
      return;
    }

    final q = query.trim().toLowerCase();
    setState(() {
      _hasSearched = true;
      _readerResults = AppData.readers.where((reader) {
        return reader.name.toLowerCase().contains(q) ||
            reader.shortName.toLowerCase().contains(q);
      }).toList();

      _mushafResults = AppData.allMushafs.where((mushaf) {
        return mushaf.name.toLowerCase().contains(q) ||
            mushaf.readerName.toLowerCase().contains(q) ||
            mushaf.rawiName.toLowerCase().contains(q) ||
            mushaf.id.toLowerCase().contains(q);
      }).toList();
    });

    _saveRecentSearch(query.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          onChanged: _performSearch,
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 16,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: 'ابحث عن مصحف أو قارئ...',
            hintStyle: TextStyle(
              fontFamily: 'Cairo',
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 14,
            ),
            border: InputBorder.none,
          ),
        ),
        actions: [
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                _performSearch('');
              },
            ),
        ],
      ),
      body: _hasSearched ? _buildResults() : _buildRecentSearches(),
    );
  }

  Widget _buildRecentSearches() {
    if (_recentSearches.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 64, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text(
              'ابحث عن مصحف أو قارئ',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 16,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'عمليات البحث الأخيرة',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: () async {
                try {
                  final dir = await getApplicationDocumentsDirectory();
                  final file = File('${dir.path}/recent_searches.json');
                  if (await file.exists()) await file.delete();
                } catch (_) {}
                setState(() => _recentSearches = []);
              },
              child: const Text(
                'مسح الكل',
                style: TextStyle(fontFamily: 'Cairo', fontSize: 12),
              ),
            ),
          ],
        ),
        ..._recentSearches.map((search) => ListTile(
              leading: Icon(Icons.history, color: Colors.grey[500]),
              title: Text(
                search,
                style: const TextStyle(fontFamily: 'Cairo', fontSize: 14),
              ),
              trailing: const Icon(Icons.north_west, size: 18),
              onTap: () {
                _searchController.text = search;
                _performSearch(search);
              },
            )),
      ],
    );
  }

  Widget _buildResults() {
    if (_readerResults.isEmpty && _mushafResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text(
              'لا توجد نتائج',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 16,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        if (_readerResults.isNotEmpty) ...[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: Text(
              'القراء',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          ..._readerResults.map((reader) => ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      const Color(0xFF016E80).withValues(alpha: 0.1),
                  child: Text(
                    reader.icon,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                title: Text(
                  reader.name,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  '${reader.mushafCount} مصحف',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                trailing: const Icon(Icons.chevron_left),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ReaderDetailScreen(reader: reader),
                  ),
                ),
              )),
        ],
        if (_mushafResults.isNotEmpty) ...[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: Text(
              'المصاحف',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          ..._mushafResults.map((mushaf) => ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4A843).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.menu_book,
                    color: Color(0xFFD4A843),
                    size: 20,
                  ),
                ),
                title: Text(
                  mushaf.name,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                subtitle: Text(
                  mushaf.readerName,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 11,
                    color: Colors.grey[600],
                  ),
                ),
                trailing: const Icon(Icons.chevron_left),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MushafViewerScreen(mushaf: mushaf),
                  ),
                ),
              )),
        ],
      ],
    );
  }
}
