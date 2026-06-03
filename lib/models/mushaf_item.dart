import 'qiraat_reader.dart';

class ManuscriptItem {
  final String id;
  final String title;
  final String description;
  final String pdfFileName;
  final String source;
  final String? category;

  const ManuscriptItem({
    required this.id,
    required this.title,
    required this.description,
    required this.pdfFileName,
    required this.source,
    this.category,
  });

  String get pdfUrl => 'https://bhr-q.com/m/$pdfFileName.pdf';
}

class CategoryItem {
  final String id;
  final String name;
  final String? description;
  final List<MushafItem> mushafs;
  final String icon;
  final List<CategoryItem> subcategories;

  const CategoryItem({
    required this.id,
    required this.name,
    this.description,
    this.mushafs = const [],
    this.icon = '📚',
    this.subcategories = const [],
  });

  int get totalMushafCount {
    int count = mushafs.length;
    for (final sub in subcategories) {
      count += sub.totalMushafCount;
    }
    return count;
  }
}
