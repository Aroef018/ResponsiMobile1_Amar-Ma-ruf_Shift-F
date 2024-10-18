import 'package:flutter/material.dart';
import 'package:apl_manajemen_kesehatan/bloc/catatan_aktivitas_fisik_bloc.dart';
import 'package:apl_manajemen_kesehatan/model/catatan_aktivitas_fisik.dart';
import 'package:apl_manajemen_kesehatan/ui/aktivitas_page.dart';
import 'package:apl_manajemen_kesehatan/widget/warning_dialog.dart';

// ignore: must_be_immutable
class AktivitasForm extends StatefulWidget {
  CatatanAktivitasFisik? aktivitas;

  AktivitasForm({Key? key, this.aktivitas}) : super(key: key);

  @override
  _AktivitasFormState createState() => _AktivitasFormState();
}

class _AktivitasFormState extends State<AktivitasForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH AKTIVITAS";
  String tombolSubmit = "SIMPAN";

  final _namaAktivitasController = TextEditingController();
  final _durasiController = TextEditingController();
  final _intensitasController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkIfUpdate();
  }

  void _checkIfUpdate() {
    if (widget.aktivitas != null) {
      setState(() {
        judul = "UBAH AKTIVITAS";
        tombolSubmit = "UBAH";
        _namaAktivitasController.text = widget.aktivitas!.activityName!;
        _durasiController.text = widget.aktivitas!.duration.toString();
        _intensitasController.text = widget.aktivitas!.intensity!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          judul,
          style: const TextStyle(fontFamily: 'Calibri'),
        ),
        backgroundColor: const Color(0xFF81C784), // Warna pastel hijau muda
      ),
      backgroundColor: const Color(0xFFF5F5DC), // Warna pastel beige
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _namaAktivitasField(),
                _durasiField(),
                _intensitasField(),
                _submitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Field Nama Aktivitas
  Widget _namaAktivitasField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama Aktivitas"),
      controller: _namaAktivitasController,
      validator: (value) {
        if (value!.isEmpty) return "Nama aktivitas harus diisi";
        return null;
      },
    );
  }

  // Field Durasi
  Widget _durasiField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Durasi (menit)"),
      keyboardType: TextInputType.number,
      controller: _durasiController,
      validator: (value) {
        if (value!.isEmpty) return "Durasi harus diisi";
        return null;
      },
    );
  }

  // Field Intensitas
  Widget _intensitasField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Intensitas (Rendah/Sedang/Tinggi)"),
      controller: _intensitasController,
      validator: (value) {
        if (value!.isEmpty) return "Intensitas harus diisi";
        return null;
      },
    );
  }

  // Tombol Simpan/Ubah
  Widget _submitButton() {
    return OutlinedButton(
      child: Text(
        tombolSubmit,
        style: const TextStyle(fontFamily: 'Calibri'),
      ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          if (!_isLoading) {
            widget.aktivitas != null ? _updateData() : _saveData();
          }
        }
      },
    );
  }

  void _saveData() {
    setState(() {
      _isLoading = true;
    });

    CatatanAktivitasFisik createAktivitas = CatatanAktivitasFisik(id: null);
    createAktivitas.activityName = _namaAktivitasController.text;
    createAktivitas.intensity = _intensitasController.text;
    createAktivitas.duration = int.parse(_durasiController.text);

    CatatanAktivitasFisikBloc.addAktivitas(aktivitas: createAktivitas).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const CatatanAktivitasFisikPage(),
      ));
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Gagal menyimpan data, silahkan coba lagi",
        ),
      );
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _updateData() {
    setState(() {
      _isLoading = true;
    });

    CatatanAktivitasFisik updateAktivitas = CatatanAktivitasFisik(id: widget.aktivitas!.id);
    updateAktivitas.activityName = _namaAktivitasController.text;
    updateAktivitas.intensity = _intensitasController.text;
    updateAktivitas.duration = int.parse(_durasiController.text);

    CatatanAktivitasFisikBloc.updateAktivitas(aktivitas: updateAktivitas).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const CatatanAktivitasFisikPage(),
      ));
    }).catchError((error) {
       print('Error saat memperbarui aktivitas: $error'); // Cetak error ke konsol
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Gagal memperbarui data, silahkan coba lagi",
        ),
      );
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }
}
