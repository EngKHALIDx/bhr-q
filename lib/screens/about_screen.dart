import 'package:flutter/material.dart';
import '../config/constants.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('عن التطبيق')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: const Color(AppConstants.primaryColorValue)
                    .withValues(alpha: 0.1),
                boxShadow: [
                  BoxShadow(
                    color: const Color(AppConstants.primaryColorValue)
                        .withValues(alpha: 0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Image.asset(
                    'assets/images/app_icon.png',
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.menu_book,
                      size: 60,
                      color: Color(AppConstants.primaryColorValue),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              AppConstants.appName,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'الإصدار ${AppConstants.appVersion}',
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(AppConstants.primaryColorValue)
                    .withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(AppConstants.primaryColorValue)
                      .withValues(alpha: 0.1),
                ),
              ),
              child: const Column(
                children: [
                  Text(
                    'تطبيق بحر القراءات',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'مرجع شامل للمصاحف القرائية العشر، يتيح لك تصفح أكثر من 41 مصحفاً برواياتها المختلفة مع إمكانية التحميل والعرض.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 14,
                      height: 2.0,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'يشمل التطبيق:',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  _FeatureItem(text: 'القراءات العشر الكبرى والصغرى'),
                  _FeatureItem(text: 'أكثر من 41 مصحفاً برواياتها'),
                  _FeatureItem(text: 'عرض صفحات المصحف بالصورة'),
                  _FeatureItem(text: 'تحميل المصاحف بصيغة PDF'),
                  _FeatureItem(text: 'مخطوطات قرائية نادرة'),
                  _FeatureItem(text: 'نظام البحث والتصفح'),
                  _FeatureItem(text: 'المفضلة والتحميلات'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'bhr-q.com',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(AppConstants.primaryColorValue),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'البيانات من مستودع the-ten-readings على GitHub',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String text;

  const _FeatureItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle,
              size: 16, color: Color(AppConstants.successColorValue)),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
