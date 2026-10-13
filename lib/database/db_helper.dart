import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/project.dart';

class DbHelper {
  DbHelper._();

  static final DbHelper instance = DbHelper._();

  // HP fisik: ganti dengan IP laptop (cek dengan ipconfig)
  // Emulator Android: bisa pakai http://10.0.2.2/portfolio_api
  static const String _androidBaseUrl = 'http://192.168.1.10/portfolio_api';

  // Chrome / Flutter Web
  static const String _otherBaseUrl = 'http://localhost/portfolio_api';

  String get baseUrl => kIsWeb ? _otherBaseUrl : _androidBaseUrl;

  Future<dynamic> _request(
    String method,
    String path, {
    Map<String, dynamic>? body,
  }) async {
    final uri = Uri.parse('$baseUrl/$path');

    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    late http.Response response;

    switch (method) {
      case 'GET':
        response = await http.get(uri, headers: headers);
        break;

      case 'POST':
        response = await http.post(
          uri,
          headers: headers,
          body: jsonEncode(body ?? {}),
        );
        break;

      case 'PUT':
        response = await http.put(
          uri,
          headers: headers,
          body: jsonEncode(body ?? {}),
        );
        break;

      case 'DELETE':
        response = await http.delete(uri, headers: headers);
        break;

      default:
        throw Exception('Metode HTTP tidak didukung');
    }

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        'Server ${response.statusCode}: ${response.body}',
      );
    }

    final decoded = jsonDecode(response.body);

    if (decoded is Map && decoded['success'] == false) {
      throw Exception(
        decoded['message'] ?? 'Permintaan gagal',
      );
    }

    return decoded;
  }

  Future<int> insert(Project p) async {
    final result = await _request(
      'POST',
      'create.php',
      body: p.toMap(),
    );

    // create.php mengirim: {"success":true,"data":{"id":5}}
    return int.parse(result['data']['id'].toString());
  }

  Future<List<Project>> getAll() async {
    final result = await _request(
      'GET',
      'read.php',
    );

    final rows = (result['data'] as List<dynamic>? ?? []);

    return rows
        .map(
          (e) => Project.fromMap(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList();
  }

  Future<int> update(Project p) async {
    final result = await _request(
      'PUT',
      'update.php',
      body: p.toMap(),
    );

    return int.parse(
      (result['data']?['id'] ?? p.id).toString(),
    );
  }

  Future<int> delete(int id) async {
    final result = await _request(
      'DELETE',
      'delete.php?id=$id',
    );

    return int.parse(
      (result['data']?['id'] ?? id).toString(),
    );
  }

  Future<int> count() async {
    final data = await getAll();
    return data.length;
  }

  Future<void> resetToSeed() async {
    await _request(
      'POST',
      'reset.php',
    );
  }

  // =========================================================
  // UPLOAD GAMBAR (pakai bytes, jalan di Web dan HP)
  // =========================================================

  Future<String> uploadImage(Uint8List bytes, String filename) async {
    final uri = Uri.parse('$baseUrl/upload_image.php');

    final request = http.MultipartRequest('POST', uri);

    request.files.add(
      http.MultipartFile.fromBytes(
        'image',
        bytes,
        filename: filename,
      ),
    );

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Upload gagal: ${response.body}');
    }

    final result = jsonDecode(response.body);

    if (result['success'] != true) {
      throw Exception(result['message'] ?? 'Upload gambar gagal');
    }

    return result['image'].toString();
  }
}