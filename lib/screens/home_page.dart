import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../widgets/app_header.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  final void Function(int) onNavigate;
  const HomePage({super.key, required this.onNavigate});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController controller = PageController();
  int page = 0;
  int count = 0;

  final List<Map<String, dynamic>> banners = [
    {
      "icon": Icons.waving_hand,
      "title": "Selamat datang!",
      "text": "Kumpulan karya dan proyek yang saya kerjakan selama kuliah.",
      "colors": [Color(0xFF4A90E2), Color(0xFF9013FE)],
    },
    {
      "icon": Icons.work,
      "title": "Kelola Karya",
      "text": "Tambah, ubah, dan hapus portofolio langsung dari aplikasi.",
      "colors": [Color(0xFF2E7D32), Color(0xFF00ACC1)],
    },
    {
      "icon": Icons.school,
      "title": "Tentang POLIJE",
      "text": "Kenali Politeknik Negeri Jember lebih dekat.",
      "colors": [Color(0xFFEF6C00), Color(0xFFD81B60)],
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadCount();
  }

  Future<void> _loadCount() async {
    final v = await DbHelper.instance.count();
    if (mounted) setState(() => count = v);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppHeader(
              title: "My Portfolio",
              subtitle: "Build • Learn • Create",
              icon: Icons.code,
              trailing: IconButton(
                icon: const Icon(Icons.settings, color: Colors.white),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SettingsPage()),
                  );
                  _loadCount();
                },
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 160,
              child: PageView.builder(
                controller: controller,
                itemCount: banners.length,
                onPageChanged: (i) => setState(() => page = i),
                itemBuilder: (context, i) {
                  final b = banners[i];
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: b["colors"] as List<Color>),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
                        Icon(b["icon"] as IconData, color: Colors.white, size: 48),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(b["title"] as String,
                                  style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 6),
                              Text(b["text"] as String, style: const TextStyle(color: Colors.white70)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                banners.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: page == i ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: page == i ? const Color(0xFF6C63FF) : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: ListTile(
                  leading: const Icon(Icons.folder_special, color: Color(0xFF6C63FF)),
                  title: Text("$count karya tersimpan", style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: const Text("Ketuk untuk melihat portofolio"),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => widget.onNavigate(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6C63FF),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: 0,
                      ),
                      onPressed: () => widget.onNavigate(3),
                      icon: const Icon(Icons.add),
                      label: const Text("Tambah Karya"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      onPressed: () => widget.onNavigate(4),
                      icon: const Icon(Icons.school),
                      label: const Text("POLIJE"),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}