import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../widgets/app_header.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Future<void> _reset(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text("Reset data?"),
        content: const Text("Semua karya akan dikembalikan ke data awal. Karya yang kamu tambahkan akan hilang."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c, false), child: const Text("Batal")),
          TextButton(onPressed: () => Navigator.pop(c, true), child: const Text("Reset")),
        ],
      ),
    );
    if (ok != true) return;
    await DbHelper.instance.resetToSeed();
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Data dikembalikan ke awal")));
  }

  Widget _tile(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF6C63FF)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppHeader(
              title: "Pengaturan",
              subtitle: "Atur aplikasi",
              icon: Icons.settings,
              showBack: true,
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  _tile(Icons.restore, "Reset data", "Kembalikan karya ke data awal", () => _reset(context)),
                  _tile(
                    Icons.info_outline,
                    "Tentang aplikasi",
                    "Versi 1.0.0",
                    () => showAboutDialog(
                      context: context,
                      applicationName: "My Portfolio",
                      applicationVersion: "1.0.0",
                      children: const [Text("Aplikasi portofolio mahasiswa POLIJE dengan Flutter, PHP, dan MySQL.")],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}