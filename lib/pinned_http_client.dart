import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:flutter/services.dart';

class PinnedHttpClient extends http.BaseClient {
  final SecurityContext securityContext;
  late final http.Client _innerClient;

  PinnedHttpClient({required this.securityContext}) {
    final httpClient = HttpClient(context: securityContext);

    httpClient.connectionTimeout = const Duration(seconds: 10);

    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) {
      return false;
    };

    _innerClient = IOClient(httpClient);
  }

 @override
Future<http.StreamedResponse> send(http.BaseRequest request) async {
  try {
    final response = await _innerClient.send(request);
    print('Request ke ${request.url} berhasil dengan status ${response.statusCode}');
    return response;
  } catch (e) {
    print('Gagal melakukan request: $e');
    throw Exception('Gagal melakukan request: $e');
  }
}


  @override
  void close() => _innerClient.close();

 static Future<PinnedHttpClient> create() async {
  try {
    final sslCert = await rootBundle.load('certificates/certificates.pem');
    print('Sertifikat berhasil dimuat, ukuran: ${sslCert} bytes');
    final securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());

    return PinnedHttpClient(securityContext: securityContext);
  } catch (e) {
    print('Gagal memuat sertifikat: $e');
    throw Exception('Gagal memuat sertifikat: $e');
  }
}

}
