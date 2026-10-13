import 'package:flutter/material.dart';
import '../widgets/app_header.dart';

class PolijePage extends StatefulWidget {
  const PolijePage({super.key});

  @override
  State<PolijePage> createState() => _PolijePageState();
}

class _PolijePageState extends State<PolijePage> {
  static const Color _primary = Color(0xFF6C63FF);

  final PageController _controller = PageController();
  int _page = 0;

  final List<Map<String, dynamic>> _highlights = const [
    {
      "icon": Icons.build_circle,
      "title": "Kampus Vokasi",
      "text": "Pembelajaran 60% praktik dan 40% teori agar lulusan siap kerja.",
      "colors": [Color(0xFF4A90E2), Color(0xFF9013FE)],
    },
    {
      "icon": Icons.factory,
      "title": "Teaching Factory",
      "text": "Dikenal dengan kampus Teaching Factory (Tefa) yang mendorong inovasi dan kewirausahaan.",
      "colors": [Color(0xFF2E7D32), Color(0xFF00ACC1)],
    },
    {
      "icon": Icons.flag,
      "title": "Visi 2035",
      "text": "Menjadi Politeknik Unggul di Asia Tahun 2035.",
      "colors": [Color(0xFFEF6C00), Color(0xFFD81B60)],
    },
  ];

  static const Map<String, List<String>> _jurusan = {
    "Produksi Pertanian": [
      "Produksi Tanaman Hortikultura",
      "Produksi Tanaman Perkebunan",
      "Teknik Produksi Benih",
      "Teknologi Produksi Tanaman Pangan",
      "Budidaya Tanaman Perkebunan",
      "Pengelolaan Perkebunan Kopi",
    ],
    "Teknologi Pertanian": [
      "Keteknikan Pertanian",
      "Teknologi Industri Pangan",
      "Teknologi Rekayasa Pangan",
      "Teknologi Rekayasa Pengemasan",
    ],
    "Peternakan": [
      "Produksi Ternak",
      "Manajemen Bisnis Unggas",
      "Teknologi Pakan Ternak",
    ],
    "Manajemen Agribisnis": [
      "Manajemen Agribisnis",
      "Manajemen Agroindustri",
      "Pascasarjana Agribisnis",
    ],
    "Teknologi Informasi": [
      "Manajemen Informatika",
      "Teknik Komputer",
      "Teknik Informatika",
      "Teknologi Rekayasa Komputer",
    ],
    "Bahasa, Komunikasi dan Pariwisata": [
      "Bahasa Inggris",
      "Destinasi Pariwisata",
      "Produksi Media (Kampus Bondowoso)",
    ],
    "Kesehatan": [
      "Manajemen Informasi Kesehatan",
      "Gizi Klinik",
      "Promosi Kesehatan",
    ],
    "Teknik": [
      "Teknik Energi Terbarukan",
      "Mesin Otomotif",
      "Teknologi Rekayasa Mekatronika",
    ],
    "Bisnis": [
      "Akuntansi Sektor Publik",
      "Bisnis Digital (Kampus Bondowoso)",
      "Manajemen Pemasaran Internasional",
    ],
  };

  String _selected = "Teknologi Informasi";

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _sectionTitle(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
      child: Row(
        children: [
          Icon(icon, color: _primary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _box(Widget child) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: child,
    );
  }

  Widget _info(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: _primary),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: const TextStyle(height: 1.4)),
    );
  }

  Widget _chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text,
          style: const TextStyle(color: _primary, fontSize: 12, fontWeight: FontWeight.w600)),
    );
  }

  Widget _bullets(List<String> items) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Column(
        children: items
            .map((t) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 6, right: 10),
                        child: Icon(Icons.circle, size: 6, color: _primary),
                      ),
                      Expanded(child: Text(t, style: const TextStyle(height: 1.4))),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _expansion(IconData icon, String title, List<String> items) {
    return ExpansionTile(
      leading: Icon(icon, color: _primary),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      childrenPadding: EdgeInsets.zero,
      children: [_bullets(items)],
    );
  }

  @override
  Widget build(BuildContext context) {
    final prodiList = _jurusan[_selected]!;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppHeader(
              title: "Tentang POLIJE",
              subtitle: "Politeknik Negeri Jember",
              icon: Icons.account_balance,
            ),

            const SizedBox(height: 20),
            SizedBox(
              height: 150,
              child: PageView.builder(
                controller: _controller,
                itemCount: _highlights.length,
                onPageChanged: (i) => setState(() => _page = i),
                itemBuilder: (context, i) {
                  final b = _highlights[i];
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: b["colors"] as List<Color>),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
                        Icon(b["icon"] as IconData, color: Colors.white, size: 44),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(b["title"] as String,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 6),
                              Text(b["text"] as String,
                                  style: const TextStyle(color: Colors.white70, height: 1.3)),
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
                _highlights.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _page == i ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _page == i ? _primary : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            _sectionTitle(Icons.info, "Profil POLIJE"),
            _box(Column(
              children: [
                _info(Icons.school, "Nama",
                    "Politeknik Negeri Jember (POLIJE)"),
                _info(Icons.location_on, "Lokasi",
                    "Kampus pusat: Jl. Mastrip PO BOX 164, Jember, Jawa Timur. Kampus lain: Bondowoso, serta PSDKU di Nganjuk, Sidoarjo, Ngawi, dan Sabu Raijua (NTT)."),
                _info(Icons.build, "Pendidikan vokasi",
                    "Pendidikan diarahkan pada keahlian dan keterampilan sesuai kebutuhan pasar kerja. Jenjang Diploma III, Sarjana Terapan, dan Magister Terapan dengan beban praktik dua kali lipat beban teori (60% praktik : 40% teori)."),
                _info(Icons.public, "Informasi umum",
                    "Berawal dari program pemerintah tahun 1980; resmi beroperasi sebagai Politeknik Pertanian UNEJ pada 29 Oktober 1988 dan berubah nama menjadi Politeknik Negeri Jember pada 5 November 2002. Tahun 2022 menjadi PTN Badan Layanan Umum. Kini memiliki 9 jurusan dengan puluhan program studi."),
                _info(Icons.flag, "Visi",
                    "Menjadi Politeknik Unggul di Asia Tahun 2035."),
                _info(Icons.menu_book, "Tri Dharma",
                    "Pendidikan dan pengajaran, penelitian dan pengembangan, serta pengabdian kepada masyarakat."),
              ],
            )),

            _sectionTitle(Icons.menu_book, "Program Studi"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: DropdownButtonFormField<String>(
                value: _selected,
                isExpanded: true,
                decoration: InputDecoration(
                  labelText: "Pilih jurusan",
                  prefixIcon: const Icon(Icons.apartment, color: _primary),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                ),
                items: _jurusan.keys
                    .map((e) => DropdownMenuItem(value: e, child: Text(e, overflow: TextOverflow.ellipsis)))
                    .toList(),
                onChanged: (v) {
                  if (v != null) setState(() => _selected = v);
                },
              ),
            ),
            const SizedBox(height: 12),
            _box(Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("${prodiList.length} program studi",
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                  ),
                ),
                ...prodiList.map((p) => ListTile(
                      dense: true,
                      leading: const Icon(Icons.arrow_right, color: _primary),
                      title: Text(p),
                    )),
                const SizedBox(height: 6),
              ],
            )),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
              child: Text(
                "Polije juga membuka Kelas Internasional (Manajemen Informatika, Teknik Informatika, Manajemen Agroindustri).",
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12, height: 1.4),
              ),
            ),

            _sectionTitle(Icons.badge, "Program Studi Saya"),
            _box(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ListTile(
                  leading: Icon(Icons.computer, color: _primary),
                  title: Text("Teknik Informatika (D4)", style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("Jurusan Teknologi Informasi • Gelar S.Tr.Kom."),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _chip("8 semester"),
                      _chip("144 SKS"),
                      _chip("60% praktik • 40% teori"),
                      _chip("Akreditasi Unggul (LAM INFOKOM)"),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
                  child: Text(
                    "Program studi ini menghasilkan Sarjana Terapan Komputer yang mampu membangun perangkat lunak desktop, web, dan mobile, mengelola sistem informasi, serta berwirausaha di bidang informatika. Kurikulum memadukan rekayasa perangkat lunak, basis data, kecerdasan buatan, data science, dan komputasi awan.",
                    style: TextStyle(height: 1.5),
                  ),
                ),
                const Divider(height: 1),
                _expansion(Icons.workspace_premium, "Profil lulusan", const [
                  "Software Engineer: menganalisis kebutuhan, merancang UI/UX dan basis data, mengembangkan serta menguji perangkat lunak (manual maupun otomatis).",
                  "Artificial Intelligence Engineer: mengembangkan sistem cerdas, machine learning, dan integrasi AI dengan IoT.",
                  "IT Entrepreneur: merancang dan meluncurkan produk startup digital berbasis kebutuhan pasar.",
                ]),
                _expansion(Icons.work, "Prospek kerja", const [
                  "Enterprise Software Engineer (frontend, backend, mobile)",
                  "AI & Data Scientist",
                  "Software QA & DevOps Engineer",
                  "Cloud & Database Architect",
                  "IT Project Manager / Analyst",
                  "Digital Technopreneur",
                ]),
                _expansion(Icons.timeline, "Gambaran kurikulum", const [
                  "Semester 1-2: algoritma, pemrograman dasar, basis data, dan sistem aplikasi berbasis objek.",
                  "Semester 3-4: pengujian perangkat lunak, workshop website dan mobile application, kecerdasan buatan, serta DevOps.",
                  "Semester 5-6: machine learning, computer vision, sistem cerdas, workshop startup, dan tata kelola TI.",
                  "Semester 7: magang industri (20 SKS). Semester 8: tugas akhir (6 SKS).",
                ]),
              ],
            )),

            _sectionTitle(Icons.stars, "Fasilitas & Kegiatan Kampus"),
            _box(Column(
              children: [
                _expansion(Icons.apartment, "Fasilitas", const [
                  "Laboratorium Jurusan Teknologi Informasi: Komputasi & Sistem Informasi, Rekayasa Sistem Informasi, Arsitektur & Jaringan Komputer, Sistem Komputer & Kontrol, Rekayasa Perangkat Lunak, dan Multimedia.",
                  "Perpustakaan Polije dan Klinik Pratama Polije.",
                  "Layanan digital: SIAKAD, SIM-Mahasiswa, E-Learning Polije, dan Pusat Informasi & Layanan Terpadu (PINTU).",
                  "Kampus Teaching Factory (Tefa) yang mendorong inovasi dan kewirausahaan.",
                ]),
                const Divider(height: 1),
                _expansion(Icons.event, "Kegiatan akademik", const [
                  "NaCIA 2026 - The 4th National Conference on Innovative Agriculture (26-27 September 2026).",
                  "ICoFA 2026 - The 9th International Conference on Food and Agriculture (24 Oktober 2026, online).",
                  "ICoSHIP 2026 - The 7th International Conference on Social Science, Humanity and Public Health (24 Oktober 2026, online).",
                  "NaCosVi-9 - The 9th National Conference for Community Service (14 November 2026).",
                  "Polije Gelar N-CAAS 2026 dan Pelantikan Pengurus ISPI Jatim 3 (berita 3 Oktober 2026).",
                ]),
                const Divider(height: 1),
                _expansion(Icons.emoji_events, "Prestasi mahasiswa", const [
                  "Mahasiswa MIK Polije meraih Juara 1 Lomba User Interface MIK-EXPO (Juli 2026).",
                  "Prodi Sarjana Terapan MIK meraih Juara Umum National Competition Medical Record ke-5 (Juli 2026).",
                  "Mahasiswa PSDKU Sidoarjo meraih Juara 2 Nasional Agribusiness Fair 2026 (September 2026).",
                  "Mahasiswa Pascasarjana meraih Juara 1 Inovasi Limbah Kopi di Bondowoso (September 2026).",
                  "Mahasiswa Polije lolos pendanaan PKM 2026 dan P2MW 2026 (Juli 2026).",
                ]),
                const Divider(height: 1),
                _expansion(Icons.handshake, "Kerja sama & kegiatan industri", const [
                  "KP2MI menggandeng Polije membuka pelatihan SMK Go Global Plantation Worker Sawit (Oktober 2026).",
                  "Polije menjajaki kerja sama akademik dengan UniMAP Malaysia (Oktober 2026).",
                  "Polije mendampingi petani Seputih meningkatkan mutu kopi robusta (Oktober 2026).",
                  "Kurikulum Teknik Informatika menyertakan magang industri 20 SKS di semester 7.",
                ]),
              ],
            )),

            _sectionTitle(Icons.link, "Sumber"),
            _box(const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "Seluruh informasi diambil dari situs resmi Politeknik Negeri Jember (diakses 7 Oktober 2026):\n"
                "• polije.ac.id (beranda, menu Jurusan, berita & prestasi)\n"
                "• polije.ac.id/sejarah\n"
                "• polije.ac.id/sekilas-polije\n"
                "• polije.ac.id/teknik-informatika\n"
                "• pasca.polije.ac.id (visi 2035)",
                style: TextStyle(height: 1.6, fontSize: 13),
              ),
            )),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
