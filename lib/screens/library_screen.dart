import 'package:flutter/material.dart';
import '../data/app_data.dart';
import 'category_screen.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المكتبة')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          _CategoryExpansionTile(
            title: 'القراءات العشر',
            icon: Icons.auto_stories,
            color: const Color(0xFF016E80),
            subcategories: [
              'مصاحف السلسلة الفراتية',
              'مصاحف جمع القراءات',
              'مصاحف الشبكة الإسلامية',
              'مصاحف الشمرلي.شلبي',
              'مصاحف نور.نورا',
              'مصاحف روايات متفرقة',
              'مصاحف الصالح.علي - العشر الصغرى',
              'مصاحف الصالح.علي - العشر الكبرى',
              'مصاحف التوفيق.ضمرة - المصاحف الأصول',
              'مصاحف التوفيق.ضمرة - المصاحف حفص',
            ],
          ),
          _CategoryExpansionTile(
            title: 'مجمع المدينة',
            icon: Icons.mosque,
            color: const Color(0xFF2E7D32),
            subcategories: [
              'مصاحف رواية حفص',
              'مصاحف الروايات',
              'المصاحف المترجمة ط1',
              'المصاحف المترجمة ط2',
            ],
          ),
          _CategoryExpansionTile(
            title: 'رواية حفص',
            icon: Icons.menu_book,
            color: const Color(0xFF6A1B9A),
            subcategories: [
              'المصاحف الأصول',
              'المصاحف المتداولة',
              'مصاحف التجويد',
              'المصاحف المتخصصة',
              'المصاحف الباكستانية',
              'مصاحف التفاسير',
              'مصاحف العشر الأخير',
              'مصاحف مترجمة',
              'أجزاء من المصاحف',
            ],
          ),
          _CategoryExpansionTile(
            title: 'قراءة نافع',
            icon: Icons.import_contacts,
            color: const Color(0xFF1565C0),
            subcategories: [
              'مصاحف العشر النافعية.إيهاب',
              'مصاحف رواية قالون عن نافع',
              'مصاحف رواية ورش - طريق الأزرق',
              'مصاحف رواية ورش - الأصبهاني',
            ],
          ),
          _CategoryExpansionTile(
            title: 'المخطوطات',
            icon: Icons.history_edu,
            color: const Color(0xFF8B4513),
            subcategories: [
              'مخطوطات متعددة المصادر',
              'مخطوطات مكتبة برلين',
              'مخطوطات مكتبة باريس',
              'مخطوطات متحف والترز',
            ],
          ),
          const SizedBox(height: 16),
          // Quick access to readers
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: Text(
              'القراء العشرة',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          ...AppData.readers.map((reader) => ListTile(
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
                    builder: (_) => CategoryScreen(
                      categoryName: reader.name,
                      readerId: reader.id,
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

class _CategoryExpansionTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> subcategories;

  const _CategoryExpansionTile({
    required this.title,
    required this.icon,
    required this.color,
    required this.subcategories,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.15)),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        subtitle: Text(
          '${subcategories.length} تصنيف',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 11,
            color: Colors.grey[600],
          ),
        ),
        children: subcategories.map((sub) {
          return ListTile(
            dense: true,
            contentPadding: const EdgeInsets.only(right: 56),
            title: Text(
              sub,
              style: const TextStyle(fontFamily: 'Cairo', fontSize: 13),
            ),
            trailing: const Icon(Icons.chevron_left, size: 18),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CategoryScreen(categoryName: sub),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
