import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/download_provider.dart';
import '../config/constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('الإعدادات')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Appearance section
          _SectionTitle(title: 'المظهر'),
          _SettingsCard(
            children: [
              SwitchListTile(
                title: const Text(
                  'الوضع الداكن',
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 14),
                ),
                subtitle: Text(
                  themeProvider.isDarkMode ? 'مفعّل' : 'معطّل',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                secondary: Icon(
                  themeProvider.isDarkMode
                      ? Icons.dark_mode
                      : Icons.light_mode,
                  color: const Color(AppConstants.primaryColorValue),
                ),
                value: themeProvider.isDarkMode,
                onChanged: (_) => themeProvider.toggleTheme(),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Downloads section
          _SectionTitle(title: 'التحميلات'),
          _SettingsCard(
            children: [
              Consumer<DownloadProvider>(
                builder: (_, provider, __) {
                  return ListTile(
                    leading: const Icon(
                      Icons.download,
                      color: Color(AppConstants.primaryColorValue),
                    ),
                    title: const Text(
                      'مسح ذاكرة التحميلات',
                      style: TextStyle(fontFamily: 'Cairo', fontSize: 14),
                    ),
                    subtitle: Text(
                      '${provider.completedTasks.length} ملف محمّل',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    trailing: const Icon(Icons.chevron_left),
                    onTap: () => _showClearDownloadsDialog(context, provider),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),

          // About section
          _SectionTitle(title: 'عن التطبيق'),
          _SettingsCard(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.info_outline,
                  color: Color(AppConstants.primaryColorValue),
                ),
                title: const Text(
                  'الإصدار',
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 14),
                ),
                trailing: const Text(
                  AppConstants.appVersion,
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 13),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.language,
                  color: Color(AppConstants.primaryColorValue),
                ),
                title: const Text(
                  'الموقع الإلكتروني',
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 14),
                ),
                trailing: const Text(
                  'bhr-q.com',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 13,
                    color: Color(AppConstants.primaryColorValue),
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.code,
                  color: Color(AppConstants.primaryColorValue),
                ),
                title: const Text(
                  'المصدر',
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 14),
                ),
                subtitle: Text(
                  'البيانات من مستودع the-ten-readings',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 11,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Footer
          Center(
            child: Text(
              'بحر القراءات © 2024',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 12,
                color: Colors.grey[500],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showClearDownloadsDialog(
      BuildContext context, DownloadProvider provider) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          'مسح التحميلات',
          style: TextStyle(fontFamily: 'Cairo'),
        ),
        content: const Text(
          'هل تريد مسح جميع الملفات المحمّلة؟',
          style: TextStyle(fontFamily: 'Cairo'),
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
            onPressed: () {
              provider.clearAllDownloads();
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'تم مسح جميع التحميلات',
                    style: TextStyle(fontFamily: 'Cairo'),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD32F2F),
            ),
            child: const Text(
              'مسح',
              style: TextStyle(fontFamily: 'Cairo', color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, right: 4),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Colors.grey[600],
        ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final List<Widget> children;

  const _SettingsCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.15),
        ),
      ),
      child: Column(children: children),
    );
  }
}
