import 'package:flutter/material.dart';
import 'package:apl_manajemen_kesehatan/bloc/catatan_aktivitas_fisik_bloc.dart';
import 'package:apl_manajemen_kesehatan/model/catatan_aktivitas_fisik.dart';
import 'package:apl_manajemen_kesehatan/ui/aktivitas_form.dart';
import 'package:apl_manajemen_kesehatan/ui/aktivitas_page.dart';
import 'package:apl_manajemen_kesehatan/widget/warning_dialog.dart';

// ignore: must_be_immutable
class AktivitasDetail extends StatefulWidget {
  CatatanAktivitasFisik? aktivitas;

  AktivitasDetail({Key? key, this.aktivitas}) : super(key: key);

  @override
  _AktivitasDetailState createState() => _AktivitasDetailState();
}

class _AktivitasDetailState extends State<AktivitasDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Aktivitas',
          style: TextStyle(fontFamily: 'Calibri'),
        ),
        backgroundColor: const Color(0xFF81C784), // Warna pastel hijau muda
      ),
      backgroundColor: const Color(0xFFF5F5DC), // Warna pastel beige
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Aktivitas: ${widget.aktivitas!.activityName}",
              style: const TextStyle(fontSize: 20.0, fontFamily: 'Calibri'),
            ),
            Text(
              "Durasi: ${widget.aktivitas!.duration} menit",
              style: const TextStyle(fontSize: 18.0, fontFamily: 'Calibri'),
            ),
            Text(
              "Intensitas: ${widget.aktivitas!.intensity}",
              style: const TextStyle(fontSize: 18.0, fontFamily: 'Calibri'),
            ),
            const SizedBox(height: 20),
            _tombolHapusEdit(),
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tombol Edit
        OutlinedButton(
          child: const Text("EDIT", style: TextStyle(fontFamily: 'Calibri')),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AktivitasForm(aktivitas: widget.aktivitas!),
              ),
            );
          },
        ),
        const SizedBox(width: 10), // Menambahkan jarak antara tombol
        // Tombol Hapus
        OutlinedButton(
          child: const Text("DELETE", style: TextStyle(fontFamily: 'Calibri')),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text(
        "Yakin ingin menghapus data ini?",
        style: TextStyle(fontFamily: 'Calibri'),
      ),
      actions: [
        // Tombol Ya
        OutlinedButton(
          child: const Text("Ya", style: TextStyle(fontFamily: 'Calibri')),
          onPressed: () {
            CatatanAktivitasFisikBloc.deleteAktivitas(
              id: (widget.aktivitas!.id!),
            ).then(
              (value) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const CatatanAktivitasFisikPage(),
                ));
              },
              onError: (error) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                    description: "Hapus gagal, silahkan coba lagi",
                  ),
                );
              },
            );
          },
        ),
        // Tombol Batal
        OutlinedButton(
          child: const Text("Batal", style: TextStyle(fontFamily: 'Calibri')),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }
}
