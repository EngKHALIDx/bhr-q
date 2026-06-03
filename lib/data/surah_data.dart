class SurahInfo {
  final int id;
  final String name;
  final String englishName;
  final int startPage;
  final int ayahCount;
  final String type; // مكية or مدنية

  const SurahInfo({
    required this.id,
    required this.name,
    required this.englishName,
    required this.startPage,
    required this.ayahCount,
    required this.type,
  });
}

class SurahData {
  static const List<SurahInfo> surahs = [
    SurahInfo(id: 1, name: 'الفاتحة', englishName: 'Al-Fatiha', startPage: 1, ayahCount: 7, type: 'مكية'),
    SurahInfo(id: 2, name: 'البقرة', englishName: 'Al-Baqara', startPage: 2, ayahCount: 286, type: 'مدنية'),
    SurahInfo(id: 3, name: 'آل عمران', englishName: 'Aal-Imran', startPage: 50, ayahCount: 200, type: 'مدنية'),
    SurahInfo(id: 4, name: 'النساء', englishName: 'An-Nisa', startPage: 77, ayahCount: 176, type: 'مدنية'),
    SurahInfo(id: 5, name: 'المائدة', englishName: 'Al-Maida', startPage: 106, ayahCount: 120, type: 'مدنية'),
    SurahInfo(id: 6, name: 'الأنعام', englishName: 'Al-Anam', startPage: 128, ayahCount: 165, type: 'مكية'),
    SurahInfo(id: 7, name: 'الأعراف', englishName: 'Al-Araf', startPage: 151, ayahCount: 206, type: 'مكية'),
    SurahInfo(id: 8, name: 'الأنفال', englishName: 'Al-Anfal', startPage: 177, ayahCount: 75, type: 'مدنية'),
    SurahInfo(id: 9, name: 'التوبة', englishName: 'At-Tawba', startPage: 187, ayahCount: 129, type: 'مدنية'),
    SurahInfo(id: 10, name: 'يونس', englishName: 'Yunus', startPage: 208, ayahCount: 109, type: 'مكية'),
    SurahInfo(id: 11, name: 'هود', englishName: 'Hud', startPage: 221, ayahCount: 123, type: 'مكية'),
    SurahInfo(id: 12, name: 'يوسف', englishName: 'Yusuf', startPage: 235, ayahCount: 111, type: 'مكية'),
    SurahInfo(id: 13, name: 'الرعد', englishName: 'Ar-Rad', startPage: 250, ayahCount: 43, type: 'مدنية'),
    SurahInfo(id: 14, name: 'إبراهيم', englishName: 'Ibrahim', startPage: 255, ayahCount: 52, type: 'مكية'),
    SurahInfo(id: 15, name: 'الحجر', englishName: 'Al-Hijr', startPage: 262, ayahCount: 99, type: 'مكية'),
    SurahInfo(id: 16, name: 'النحل', englishName: 'An-Nahl', startPage: 267, ayahCount: 128, type: 'مكية'),
    SurahInfo(id: 17, name: 'الإسراء', englishName: 'Al-Isra', startPage: 282, ayahCount: 111, type: 'مكية'),
    SurahInfo(id: 18, name: 'الكهف', englishName: 'Al-Kahf', startPage: 293, ayahCount: 110, type: 'مكية'),
    SurahInfo(id: 19, name: 'مريم', englishName: 'Maryam', startPage: 305, ayahCount: 98, type: 'مكية'),
    SurahInfo(id: 20, name: 'طه', englishName: 'Ta-Ha', startPage: 312, ayahCount: 135, type: 'مكية'),
    SurahInfo(id: 21, name: 'الأنبياء', englishName: 'Al-Anbiya', startPage: 322, ayahCount: 112, type: 'مكية'),
    SurahInfo(id: 22, name: 'الحج', englishName: 'Al-Hajj', startPage: 332, ayahCount: 78, type: 'مدنية'),
    SurahInfo(id: 23, name: 'المؤمنون', englishName: 'Al-Muminun', startPage: 342, ayahCount: 118, type: 'مكية'),
    SurahInfo(id: 24, name: 'النور', englishName: 'An-Nur', startPage: 350, ayahCount: 64, type: 'مدنية'),
    SurahInfo(id: 25, name: 'الفرقان', englishName: 'Al-Furqan', startPage: 359, ayahCount: 77, type: 'مكية'),
    SurahInfo(id: 26, name: 'الشعراء', englishName: 'Ash-Shuara', startPage: 367, ayahCount: 227, type: 'مكية'),
    SurahInfo(id: 27, name: 'النمل', englishName: 'An-Naml', startPage: 377, ayahCount: 93, type: 'مكية'),
    SurahInfo(id: 28, name: 'القصص', englishName: 'Al-Qasas', startPage: 385, ayahCount: 88, type: 'مكية'),
    SurahInfo(id: 29, name: 'العنكبوت', englishName: 'Al-Ankabut', startPage: 396, ayahCount: 69, type: 'مكية'),
    SurahInfo(id: 30, name: 'الروم', englishName: 'Ar-Rum', startPage: 404, ayahCount: 60, type: 'مكية'),
    SurahInfo(id: 31, name: 'لقمان', englishName: 'Luqman', startPage: 411, ayahCount: 34, type: 'مكية'),
    SurahInfo(id: 32, name: 'السجدة', englishName: 'As-Sajda', startPage: 415, ayahCount: 30, type: 'مكية'),
    SurahInfo(id: 33, name: 'الأحزاب', englishName: 'Al-Ahzab', startPage: 418, ayahCount: 73, type: 'مدنية'),
    SurahInfo(id: 34, name: 'سبأ', englishName: 'Saba', startPage: 428, ayahCount: 54, type: 'مكية'),
    SurahInfo(id: 35, name: 'فاطر', englishName: 'Fatir', startPage: 434, ayahCount: 45, type: 'مكية'),
    SurahInfo(id: 36, name: 'يس', englishName: 'Ya-Sin', startPage: 440, ayahCount: 83, type: 'مكية'),
    SurahInfo(id: 37, name: 'الصافات', englishName: 'As-Saffat', startPage: 446, ayahCount: 182, type: 'مكية'),
    SurahInfo(id: 38, name: 'ص', englishName: 'Sad', startPage: 453, ayahCount: 88, type: 'مكية'),
    SurahInfo(id: 39, name: 'الزمر', englishName: 'Az-Zumar', startPage: 458, ayahCount: 75, type: 'مكية'),
    SurahInfo(id: 40, name: 'غافر', englishName: 'Ghafir', startPage: 467, ayahCount: 85, type: 'مكية'),
    SurahInfo(id: 41, name: 'فصلت', englishName: 'Fussilat', startPage: 477, ayahCount: 54, type: 'مكية'),
    SurahInfo(id: 42, name: 'الشورى', englishName: 'Ash-Shura', startPage: 483, ayahCount: 53, type: 'مكية'),
    SurahInfo(id: 43, name: 'الزخرف', englishName: 'Az-Zukhruf', startPage: 489, ayahCount: 89, type: 'مكية'),
    SurahInfo(id: 44, name: 'الدخان', englishName: 'Ad-Dukhan', startPage: 496, ayahCount: 59, type: 'مكية'),
    SurahInfo(id: 45, name: 'الجاثية', englishName: 'Al-Jathiya', startPage: 499, ayahCount: 37, type: 'مكية'),
    SurahInfo(id: 46, name: 'الأحقاف', englishName: 'Al-Ahqaf', startPage: 502, ayahCount: 35, type: 'مكية'),
    SurahInfo(id: 47, name: 'محمد', englishName: 'Muhammad', startPage: 507, ayahCount: 38, type: 'مدنية'),
    SurahInfo(id: 48, name: 'الفتح', englishName: 'Al-Fath', startPage: 511, ayahCount: 29, type: 'مدنية'),
    SurahInfo(id: 49, name: 'الحجرات', englishName: 'Al-Hujurat', startPage: 515, ayahCount: 18, type: 'مدنية'),
    SurahInfo(id: 50, name: 'ق', englishName: 'Qaf', startPage: 518, ayahCount: 45, type: 'مكية'),
    SurahInfo(id: 51, name: 'الذاريات', englishName: 'Adh-Dhariyat', startPage: 520, ayahCount: 60, type: 'مكية'),
    SurahInfo(id: 52, name: 'الطور', englishName: 'At-Tur', startPage: 523, ayahCount: 49, type: 'مكية'),
    SurahInfo(id: 53, name: 'النجم', englishName: 'An-Najm', startPage: 526, ayahCount: 62, type: 'مكية'),
    SurahInfo(id: 54, name: 'القمر', englishName: 'Al-Qamar', startPage: 528, ayahCount: 55, type: 'مكية'),
    SurahInfo(id: 55, name: 'الرحمن', englishName: 'Ar-Rahman', startPage: 531, ayahCount: 78, type: 'مدنية'),
    SurahInfo(id: 56, name: 'الواقعة', englishName: 'Al-Waqia', startPage: 534, ayahCount: 96, type: 'مكية'),
    SurahInfo(id: 57, name: 'الحديد', englishName: 'Al-Hadid', startPage: 537, ayahCount: 29, type: 'مدنية'),
    SurahInfo(id: 58, name: 'المجادلة', englishName: 'Al-Mujadila', startPage: 542, ayahCount: 22, type: 'مدنية'),
    SurahInfo(id: 59, name: 'الحشر', englishName: 'Al-Hashr', startPage: 545, ayahCount: 24, type: 'مدنية'),
    SurahInfo(id: 60, name: 'الممتحنة', englishName: 'Al-Mumtahina', startPage: 549, ayahCount: 13, type: 'مدنية'),
    SurahInfo(id: 61, name: 'الصف', englishName: 'As-Saff', startPage: 551, ayahCount: 14, type: 'مدنية'),
    SurahInfo(id: 62, name: 'الجمعة', englishName: 'Al-Jumua', startPage: 553, ayahCount: 11, type: 'مدنية'),
    SurahInfo(id: 63, name: 'المنافقون', englishName: 'Al-Munafiqun', startPage: 554, ayahCount: 11, type: 'مدنية'),
    SurahInfo(id: 64, name: 'التغابن', englishName: 'At-Taghabun', startPage: 556, ayahCount: 18, type: 'مدنية'),
    SurahInfo(id: 65, name: 'الطلاق', englishName: 'At-Talaq', startPage: 558, ayahCount: 12, type: 'مدنية'),
    SurahInfo(id: 66, name: 'التحريم', englishName: 'At-Tahrim', startPage: 560, ayahCount: 12, type: 'مدنية'),
    SurahInfo(id: 67, name: 'الملك', englishName: 'Al-Mulk', startPage: 562, ayahCount: 30, type: 'مكية'),
    SurahInfo(id: 68, name: 'القلم', englishName: 'Al-Qalam', startPage: 564, ayahCount: 52, type: 'مكية'),
    SurahInfo(id: 69, name: 'الحاقة', englishName: 'Al-Haqqah', startPage: 567, ayahCount: 52, type: 'مكية'),
    SurahInfo(id: 70, name: 'المعارج', englishName: 'Al-Maarij', startPage: 570, ayahCount: 44, type: 'مكية'),
    SurahInfo(id: 71, name: 'نوح', englishName: 'Nuh', startPage: 572, ayahCount: 28, type: 'مكية'),
    SurahInfo(id: 72, name: 'الجن', englishName: 'Al-Jinn', startPage: 574, ayahCount: 28, type: 'مكية'),
    SurahInfo(id: 73, name: 'المزمل', englishName: 'Al-Muzzammil', startPage: 575, ayahCount: 20, type: 'مكية'),
    SurahInfo(id: 74, name: 'المدثر', englishName: 'Al-Muddathir', startPage: 577, ayahCount: 56, type: 'مكية'),
    SurahInfo(id: 75, name: 'القيامة', englishName: 'Al-Qiyamah', startPage: 580, ayahCount: 40, type: 'مكية'),
    SurahInfo(id: 76, name: 'الإنسان', englishName: 'Al-Insan', startPage: 582, ayahCount: 31, type: 'مدنية'),
    SurahInfo(id: 77, name: 'المرسلات', englishName: 'Al-Mursalat', startPage: 585, ayahCount: 50, type: 'مكية'),
    SurahInfo(id: 78, name: 'النبأ', englishName: 'An-Naba', startPage: 587, ayahCount: 40, type: 'مكية'),
    SurahInfo(id: 79, name: 'النازعات', englishName: 'An-Naziat', startPage: 589, ayahCount: 46, type: 'مكية'),
    SurahInfo(id: 80, name: 'عبس', englishName: 'Abasa', startPage: 591, ayahCount: 42, type: 'مكية'),
    SurahInfo(id: 81, name: 'التكوير', englishName: 'At-Takwir', startPage: 593, ayahCount: 29, type: 'مكية'),
    SurahInfo(id: 82, name: 'الانفطار', englishName: 'Al-Infitar', startPage: 594, ayahCount: 19, type: 'مكية'),
    SurahInfo(id: 83, name: 'المطففين', englishName: 'Al-Mutaffifin', startPage: 595, ayahCount: 36, type: 'مكية'),
    SurahInfo(id: 84, name: 'الانشقاق', englishName: 'Al-Inshiqaq', startPage: 597, ayahCount: 25, type: 'مكية'),
    SurahInfo(id: 85, name: 'البروج', englishName: 'Al-Buruj', startPage: 598, ayahCount: 22, type: 'مكية'),
    SurahInfo(id: 86, name: 'الطارق', englishName: 'At-Tariq', startPage: 599, ayahCount: 17, type: 'مكية'),
    SurahInfo(id: 87, name: 'الأعلى', englishName: 'Al-Ala', startPage: 600, ayahCount: 19, type: 'مكية'),
    SurahInfo(id: 88, name: 'الغاشية', englishName: 'Al-Ghashiyah', startPage: 601, ayahCount: 26, type: 'مكية'),
    SurahInfo(id: 89, name: 'الفجر', englishName: 'Al-Fajr', startPage: 602, ayahCount: 30, type: 'مكية'),
    SurahInfo(id: 90, name: 'البلد', englishName: 'Al-Balad', startPage: 603, ayahCount: 20, type: 'مكية'),
    SurahInfo(id: 91, name: 'الشمس', englishName: 'Ash-Shams', startPage: 604, ayahCount: 15, type: 'مكية'),
    SurahInfo(id: 92, name: 'الليل', englishName: 'Al-Layl', startPage: 605, ayahCount: 21, type: 'مكية'),
    SurahInfo(id: 93, name: 'الضحى', englishName: 'Ad-Duha', startPage: 606, ayahCount: 11, type: 'مكية'),
    SurahInfo(id: 94, name: 'الشرح', englishName: 'Ash-Sharh', startPage: 606, ayahCount: 8, type: 'مكية'),
    SurahInfo(id: 95, name: 'التين', englishName: 'At-Tin', startPage: 607, ayahCount: 8, type: 'مكية'),
    SurahInfo(id: 96, name: 'العلق', englishName: 'Al-Alaq', startPage: 607, ayahCount: 19, type: 'مكية'),
    SurahInfo(id: 97, name: 'القدر', englishName: 'Al-Qadr', startPage: 608, ayahCount: 5, type: 'مكية'),
    SurahInfo(id: 98, name: 'البينة', englishName: 'Al-Bayyinah', startPage: 608, ayahCount: 8, type: 'مدنية'),
    SurahInfo(id: 99, name: 'الزلزلة', englishName: 'Az-Zalzalah', startPage: 609, ayahCount: 8, type: 'مدنية'),
    SurahInfo(id: 100, name: 'العاديات', englishName: 'Al-Adiyat', startPage: 609, ayahCount: 11, type: 'مكية'),
    SurahInfo(id: 101, name: 'القارعة', englishName: 'Al-Qariah', startPage: 610, ayahCount: 11, type: 'مكية'),
    SurahInfo(id: 102, name: 'التكاثر', englishName: 'At-Takathur', startPage: 610, ayahCount: 8, type: 'مكية'),
    SurahInfo(id: 103, name: 'العصر', englishName: 'Al-Asr', startPage: 610, ayahCount: 3, type: 'مكية'),
    SurahInfo(id: 104, name: 'الهمزة', englishName: 'Al-Humazah', startPage: 611, ayahCount: 9, type: 'مكية'),
    SurahInfo(id: 105, name: 'الفيل', englishName: 'Al-Fil', startPage: 611, ayahCount: 5, type: 'مكية'),
    SurahInfo(id: 106, name: 'قريش', englishName: 'Quraysh', startPage: 611, ayahCount: 4, type: 'مكية'),
    SurahInfo(id: 107, name: 'الماعون', englishName: 'Al-Maun', startPage: 612, ayahCount: 7, type: 'مكية'),
    SurahInfo(id: 108, name: 'الكوثر', englishName: 'Al-Kawthar', startPage: 612, ayahCount: 3, type: 'مكية'),
    SurahInfo(id: 109, name: 'الكافرون', englishName: 'Al-Kafirun', startPage: 612, ayahCount: 6, type: 'مكية'),
    SurahInfo(id: 110, name: 'النصر', englishName: 'An-Nasr', startPage: 613, ayahCount: 3, type: 'مدنية'),
    SurahInfo(id: 111, name: 'المسد', englishName: 'Al-Masad', startPage: 613, ayahCount: 5, type: 'مكية'),
    SurahInfo(id: 112, name: 'الإخلاص', englishName: 'Al-Ikhlas', startPage: 613, ayahCount: 4, type: 'مكية'),
    SurahInfo(id: 113, name: 'الفلق', englishName: 'Al-Falaq', startPage: 614, ayahCount: 5, type: 'مكية'),
    SurahInfo(id: 114, name: 'الناس', englishName: 'An-Nas', startPage: 614, ayahCount: 6, type: 'مدنية'),
  ];

  static SurahInfo? getSurahByPage(int page) {
    for (int i = surahs.length - 1; i >= 0; i--) {
      if (page >= surahs[i].startPage) return surahs[i];
    }
    return null;
  }

  static int getJuzByPage(int page) {
    if (page <= 21) return 1;
    if (page <= 41) return 2;
    if (page <= 61) return 3;
    if (page <= 81) return 4;
    if (page <= 101) return 5;
    if (page <= 121) return 6;
    if (page <= 141) return 7;
    if (page <= 161) return 8;
    if (page <= 181) return 9;
    if (page <= 201) return 10;
    if (page <= 221) return 11;
    if (page <= 241) return 12;
    if (page <= 261) return 13;
    if (page <= 281) return 14;
    if (page <= 301) return 15;
    if (page <= 321) return 16;
    if (page <= 341) return 17;
    if (page <= 361) return 18;
    if (page <= 381) return 19;
    if (page <= 401) return 20;
    if (page <= 421) return 21;
    if (page <= 441) return 22;
    if (page <= 461) return 23;
    if (page <= 481) return 24;
    if (page <= 501) return 25;
    if (page <= 521) return 26;
    if (page <= 541) return 27;
    if (page <= 561) return 28;
    if (page <= 581) return 29;
    return 30;
  }
}
