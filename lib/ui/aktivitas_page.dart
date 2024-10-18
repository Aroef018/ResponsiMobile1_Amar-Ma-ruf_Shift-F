import 'package:flutter/material.dart';
import 'package:apl_manajemen_kesehatan/bloc/logout_bloc.dart';
import 'package:apl_manajemen_kesehatan/bloc/catatan_aktivitas_fisik_bloc.dart';
import 'package:apl_manajemen_kesehatan/model/catatan_aktivitas_fisik.dart';
import 'package:apl_manajemen_kesehatan/ui/login_page.dart';
import 'package:apl_manajemen_kesehatan/ui/aktivitas_detail.dart';
import 'package:apl_manajemen_kesehatan/ui/aktivitas_form.dart';

class CatatanAktivitasFisikPage extends StatefulWidget {
  const CatatanAktivitasFisikPage({Key? key}) : super(key: key);

  @override
  _CatatanAktivitasFisikPageState createState() =>
      _CatatanAktivitasFisikPageState();
}

class _CatatanAktivitasFisikPageState
    extends State<CatatanAktivitasFisikPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5DC), // Warna pastel (beige)
      appBar: AppBar(
        title: const Text(
          'Catatan Aktivitas Fisik',
          style: TextStyle(fontFamily: 'Calibri'),
        ),
        backgroundColor: const Color(0xFF81C784), // Warna pastel hijau muda
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26.0),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AktivitasForm()),
                );
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout', style: TextStyle(fontFamily: 'Calibri')),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout().then((value) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false,
                  );
                });
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<CatatanAktivitasFisik>>(
        future: CatatanAktivitasFisikBloc.getAktivitas(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListAktivitas(list: snapshot.data!)
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ListAktivitas extends StatelessWidget {
  final List<CatatanAktivitasFisik>? list;

  const ListAktivitas({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list?.length ?? 0,
      itemBuilder: (context, i) {
        return ItemAktivitas(aktivitas: list![i]);
      },
    );
  }
}

class ItemAktivitas extends StatelessWidget {
  final CatatanAktivitasFisik aktivitas;

  const ItemAktivitas({Key? key, required this.aktivitas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AktivitasDetail(aktivitas: aktivitas),
          ),
        );
      },
      child: Card(
        color: const Color(0xFFFFF0F5), // Warna pastel (lavender blush)
        child: ListTile(
          title: Text(
            aktivitas.activityName!,
            style: const TextStyle(fontFamily: 'Calibri', fontSize: 18),
          ),
          subtitle: Text(
            '${aktivitas.duration} minutes - ${aktivitas.intensity}',
            style: const TextStyle(fontFamily: 'Calibri'),
          ),
        ),
      ),
    );
  }
}
