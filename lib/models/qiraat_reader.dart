class QiraatReader {
  final String id;
  final String name;
  final String shortName;
  final String rank;
  final String deathYear;
  final String birthPlace;
  final String biography;
  final List<RawiInfo> rawis;
  final List<MushafItem> mushafs;
  final String gradientStart;
  final String gradientEnd;
  final String icon;
  final String iconAsset;
  final String introduction;

  const QiraatReader({
    required this.id,
    required this.name,
    required this.shortName,
    required this.rank,
    required this.deathYear,
    required this.birthPlace,
    required this.biography,
    required this.rawis,
    required this.mushafs,
    this.gradientStart = '#016E80',
    this.gradientEnd = '#014D5C',
    this.icon = '📖',
    this.iconAsset = '',
    this.introduction = '',
  });

  int get mushafCount => mushafs.length;
}

class RawiInfo {
  final String id;
  final String name;
  final String description;
  final String deathYear;
  final List<String> mushafNames;

  const RawiInfo({
    required this.id,
    required this.name,
    required this.description,
    required this.deathYear,
    this.mushafNames = const [],
  });
}

class MushafItem {
  final String id;
  final String readerId;
  final String readerName;
  final String name;
  final String rawiName;
  final String pagesFolder;
  final int totalPages;
  final String pdfFileName;
  final String pdfCategory;
  final String? description;
  final String? coverImageUrl;

  const MushafItem({
    required this.id,
    required this.readerId,
    required this.readerName,
    required this.name,
    required this.rawiName,
    required this.pagesFolder,
    required this.totalPages,
    required this.pdfFileName,
    required this.pdfCategory,
    this.description,
    this.coverImageUrl,
  });

  /// Page 1 = file 0001.jpg (cover page), Page 5 = file 0005.jpg (Al-Fatiha)
  /// The dataset files start from 0001.jpg (cover) through the last page
  String getPageImageUrl(int pageNumber) {
    final fileNumber = pageNumber.toString().padLeft(4, '0');
    return 'https://raw.githubusercontent.com/the-ten-readings/dataset/data/qurans/$pagesFolder/$fileNumber.jpg';
  }

  /// Get the Quran content page number (skipping cover/intro pages)
  /// Cover pages are 1-4, Quran content starts at page 5
  int get quranStartPage => 5;

  /// Check if a page is a cover/intro page
  bool isCoverPage(int pageNumber) => pageNumber < quranStartPage;

  String get pdfUrl =>
      'https://bhr-q.com/media/attachments/qran/$pdfCategory/$pdfFileName';

  String get pdfFileNameWithExt => '$pdfFileName';
}
