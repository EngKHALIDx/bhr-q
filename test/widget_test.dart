import 'package:flutter_test/flutter_test.dart';
import 'package:bhr_qiraat/data/app_data.dart';
import 'package:bhr_qiraat/data/surah_data.dart';

void main() {
  test('Qiraat readers data completeness', () {
    expect(AppData.readers.length, 10);
    for (final reader in AppData.readers) {
      expect(reader.id, isNotEmpty);
      expect(reader.name, isNotEmpty);
      expect(reader.rawis.length, greaterThanOrEqualTo(2));
      expect(reader.mushafs, isNotEmpty);
    }
  });

  test('Surah data completeness', () {
    expect(SurahData.surahs.length, 114);
    expect(SurahData.surahs.first.name, 'الفاتحة');
    expect(SurahData.surahs.last.name, 'الناس');
  });

  test('Mushaf pagesFolder data', () {
    int withPages = 0;
    for (final reader in AppData.readers) {
      for (final mushaf in reader.mushafs) {
        if (mushaf.pagesFolder.isNotEmpty) {
          withPages++;
          expect(mushaf.totalPages, greaterThan(600));
        }
      }
    }
    expect(withPages, greaterThanOrEqualTo(30));
  });

  test('Total mushaf count is 41+', () {
    expect(AppData.allMushafs.length, greaterThanOrEqualTo(41));
  });
}
