class CatatanAktivitasFisik {
  int? id;
  String? activityName;
  int? duration;
  String? intensity;

  CatatanAktivitasFisik({
    this.id,
    this.activityName,
    this.duration,
    this.intensity,
  });

  factory CatatanAktivitasFisik.fromJson(Map<String, dynamic> obj) {
    return CatatanAktivitasFisik(
      id: int.tryParse(obj['id'].toString()), 
      activityName: obj['activity_name'], 
      duration: int.tryParse(obj['duration'].toString()),
      intensity: obj['intensity'],
    );
  }
}
