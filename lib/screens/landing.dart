import 'package:flutter/material.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC2F4E3),
      // appBar: AppBar(
      //   actions: [
      //     Row(
      //       children: [
      //         Image.asset(
      //           "assets/images/Frame 33.png",
      //           width: 40,
      //           height: 40,
      //         ),
      //         const SizedBox(
      //           width: 90,
      //         ),
      //         const Text("Daftar Membaca"),
      //         const SizedBox(
      //           width: 30,
      //         ),
      //         const Text("Cari Buku"),
      //         const SizedBox(
      //           width: 30,
      //         ),
      //         GestureDetector(
      //           child: Container(
      //             decoration: BoxDecoration(
      //                 color: const Color(0xFF3BEDB7),
      //                 borderRadius: BorderRadius.circular(16)),
      //             padding:
      //                 const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      //             child: const Text("Log out"),
      //           ),
      //         ),
      //         const SizedBox(
      //           width: 30,
      //         ),
      //       ],
      //     )
      //   ],
      // ),
      drawer: const Drawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/Book Vector.png",
              width: 300,
              height: 300,
            ),
            const SizedBox(
              width: 300,
              child: Text(
                "Cari, Ulas\n Buku, dan Buat\n Daftar Bacamu",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
