import 'dart:convert';
import 'package:apl_manajemen_kesehatan/helpers/api.dart';
import 'package:apl_manajemen_kesehatan/helpers/api_url.dart';
import 'package:apl_manajemen_kesehatan/model/catatan_aktivitas_fisik.dart';

class CatatanAktivitasFisikBloc {
  // Mendapatkan semua data aktivitas fisik
  static Future<List<CatatanAktivitasFisik>> getAktivitas() async {
    String apiUrl = ApiUrl.getAllCatatanAktivitasFisik;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listAktivitas = (jsonObj as Map<String, dynamic>)['data'];
    List<CatatanAktivitasFisik> aktivitasList = [];
    for (var item in listAktivitas) {
      aktivitasList.add(CatatanAktivitasFisik.fromJson(item));
    }
    return aktivitasList;
  }

  // Mendapatkan detail aktivitas fisik berdasarkan ID
  static Future<CatatanAktivitasFisik?> showAktivitasFisik(int id) async {
    String apiUrl = ApiUrl.showCatatanAktivitasFisik(id);
    var response = await Api().get(apiUrl);
    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      return CatatanAktivitasFisik.fromJson(jsonObj['data']);
    }
    return null;
  }

  // Menambahkan aktivitas fisik baru
  static Future addAktivitas({CatatanAktivitasFisik? aktivitas}) async {
    String apiUrl = ApiUrl.createCatatanAktivitasFisik;
    var body = {
      "activity_name": aktivitas!.activityName,
      "duration": aktivitas.duration.toString(),
      "intensity": aktivitas.intensity,
    };
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  // Memperbarui aktivitas fisik
  static Future updateAktivitas({required CatatanAktivitasFisik aktivitas}) async {
    String apiUrl = ApiUrl.updateCatatanAktivitasFisik(aktivitas.id!);
    print(apiUrl);
    var body = {
      "activity_name": aktivitas.activityName,
      "duration": aktivitas.duration.toString(),
      "intensity": aktivitas.intensity,
    };
    print("Body : $body");
    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  // Menghapus aktivitas fisik berdasarkan ID
  static Future<bool> deleteAktivitas({int? id}) async {
    String apiUrl = ApiUrl.deleteCatatanAktivitasFisik(id!);
    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
