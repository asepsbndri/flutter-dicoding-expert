import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:flutter/services.dart';

class PinnedHttpClient extends http.BaseClient {
  final SecurityContext securityContext;
  late final http.Client _innerClient;

  PinnedHttpClient({required this.securityContext}) {
    final httpClient = HttpClient(context: securityContext);
    httpClient.connectionTimeout = Duration(seconds: 10);
    _innerClient = IOClient(httpClient);
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    try {
      final response = await _innerClient.send(request);
      return response;
    } catch (e) {
      throw Exception('Gagal melakukan request: $e');
    }
  }

  @override
  void close() => _innerClient.close();

  static Future<PinnedHttpClient> create() async {
    try {
      final sslCert = await rootBundle.load('certificates/certificates.pem');
      final securityContext = SecurityContext(withTrustedRoots: false);
      securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
      return PinnedHttpClient(securityContext: securityContext);
    } catch (e) {
      throw Exception('Gagal memuat sertifikat: $e');
    }
  }
}