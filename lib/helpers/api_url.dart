class ApiUrl {
  static const String baseUrl = 'http://103.196.155.42/api';
  static const String registrasi = baseUrl + '/registrasi';
  static const String login = baseUrl + '/login';
  static const String getAllCatatanAktivitasFisik = baseUrl + '/kesehatan/catatan_aktivitas_fisik';
  static const String createCatatanAktivitasFisik = baseUrl + '/kesehatan/catatan_aktivitas_fisik';

//nanti bisa jadi ada keselahan disini karna tipe data
  static String showCatatanAktivitasFisik(int id) {
    return baseUrl + '/kesehatan/catatan_aktivitas_fisik/' + id.toString();
  }

  static String updateCatatanAktivitasFisik(int id) {
    return baseUrl + '/kesehatan/catatan_aktivitas_fisik/' + id.toString() + '/update';
  }

  static String deleteCatatanAktivitasFisik(int id) {
    return baseUrl + '/kesehatan/catatan_aktivitas_fisik/' + id.toString() + '/delete';
  }
}
