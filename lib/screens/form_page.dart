import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../database/db_helper.dart';
import '../models/project.dart';
import '../widgets/app_header.dart';

class FormPage extends StatefulWidget {
  final Project? project;
  final VoidCallback onSaved;

  const FormPage({
    super.key,
    this.project,
    required this.onSaved,
  });

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _title;
  late final TextEditingController _tech;
  late final TextEditingController _year;
  late final TextEditingController _desc;

  late String _category;

  String? _imagePath;

  XFile? _pickedFile;
  Uint8List? _selectedBytes;

  bool _saving = false;
  bool _uploading = false;

  bool get isEdit => widget.project != null;

  @override
  void initState() {
    super.initState();

    final p = widget.project;

    _title = TextEditingController(text: p?.title ?? '');
    _tech = TextEditingController(text: p?.tech ?? '');
    _year = TextEditingController(
      text: p?.year ?? DateTime.now().year.toString(),
    );
    _desc = TextEditingController(text: p?.desc ?? '');

    _category = p?.category ?? kTechOptions.first;

    _imagePath = p?.image;
  }

  @override
  void dispose() {
    _title.dispose();
    _tech.dispose();
    _year.dispose();
    _desc.dispose();

    super.dispose();
  }

  InputDecoration _decor(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(
        icon,
        color: const Color(0xFF6C63FF),
      ),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(
          color: Colors.grey.shade300,
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();

      final XFile? picked = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (picked == null) return;

      final bytes = await picked.readAsBytes();

      setState(() {
        _pickedFile = picked;
        _selectedBytes = bytes;
        _imagePath = null;
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal memilih gambar'),
        ),
      );
    }
  }

  Widget _imagePreview() {
    if (_selectedBytes != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Image.memory(
          _selectedBytes!,
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
        ),
      );
    }

    if (_imagePath != null && _imagePath!.isNotEmpty) {
      final image = _imagePath!;

      if (image.startsWith('assets/')) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Image.asset(
            image,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => _emptyImage(),
          ),
        );
      }

      final url = image.startsWith('http')
          ? image
          : '${DbHelper.instance.baseUrl}/$image';

      return ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Image.network(
          url,
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
          webHtmlElementStrategy: WebHtmlElementStrategy.fallback,
          errorBuilder: (_, __, ___) => _emptyImage(),
        ),
      );
    }

    return _emptyImage();
  }

  Widget _emptyImage() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_outlined,
            size: 55,
            color: Colors.grey,
          ),
          SizedBox(height: 8),
          Text(
            'Belum ada gambar',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_saving) return;

    setState(() {
      _saving = true;
    });

    try {
      String? finalImage = _imagePath;

      if (_selectedBytes != null) {
        setState(() {
          _uploading = true;
        });

        finalImage = await DbHelper.instance.uploadImage(
          _selectedBytes!,
          _pickedFile!.name,
        );

        setState(() {
          _uploading = false;
        });
      }

      final old = widget.project;

      final p = Project(
        id: old?.id,
        title: _title.text.trim(),
        category: _category,
        year: _year.text.trim(),
        tech: _tech.text.trim(),
        desc: _desc.text.trim(),
        color: colorForTech(_category),
        image: finalImage,
      );

      if (isEdit) {
        await DbHelper.instance.update(p);
      } else {
        await DbHelper.instance.insert(p);
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isEdit
                ? 'Karya berhasil diperbarui'
                : 'Karya berhasil ditambahkan',
          ),
        ),
      );

      widget.onSaved();
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _saving = false;
        _uploading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menyimpan: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppHeader(
              title: isEdit ? "Edit Karya" : "Tambah Karya",
              subtitle: "Isi data dengan lengkap",
              icon: isEdit ? Icons.edit : Icons.add_circle,
              showBack: isEdit,
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _title,
                      decoration: _decor("Judul karya", Icons.title),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return "Judul wajib diisi";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 14),

                    DropdownButtonFormField<String>(
                      value: _category,
                      decoration: _decor("Kategori", Icons.category),
                      items: kTechOptions
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ),
                          )
                          .toList(),
                      onChanged: (v) {
                        if (v != null) {
                          setState(() {
                            _category = v;
                          });
                        }
                      },
                    ),

                    const SizedBox(height: 14),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Gambar Sampul",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    _imagePreview(),

                    const SizedBox(height: 12),

                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: _saving ? null : _pickImage,
                        icon: const Icon(Icons.photo_library),
                        label: const Text("Pilih Gambar dari Galeri"),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF6C63FF),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    TextFormField(
                      controller: _tech,
                      decoration: _decor(
                        "Teknologi (pisahkan dengan koma)",
                        Icons.layers,
                      ),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return "Teknologi wajib diisi";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 14),

                    TextFormField(
                      controller: _year,
                      keyboardType: TextInputType.number,
                      decoration: _decor("Tahun", Icons.calendar_month),
                      validator: (v) {
                        final y = int.tryParse(v ?? '');

                        if (y == null || y < 2000 || y > 2100) {
                          return "Masukkan tahun yang valid (2000-2100)";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 14),

                    TextFormField(
                      controller: _desc,
                      maxLines: 4,
                      decoration: _decor("Deskripsi", Icons.notes),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return "Deskripsi wajib diisi";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6C63FF),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 0,
                        ),
                        onPressed: _saving ? null : _save,
                        icon: _saving
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.save),
                        label: Text(
                          _uploading
                              ? "Mengupload gambar..."
                              : _saving
                                  ? "Menyimpan..."
                                  : "Simpan",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}