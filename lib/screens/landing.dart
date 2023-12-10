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
      backgroundColor: Color(0xFFC2F4E3),
      appBar: AppBar(
        actions: [
          Row(
            children: [
              Image.asset("assets/images/Frame 33.png", width: 40, height: 40,),
              const SizedBox(width: 90,),
              Text("Daftar Membaca"),
              const SizedBox(width: 30,),
              Text("Cari Buku"),
              const SizedBox(width: 30,),
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF3BEDB7),
                    borderRadius: BorderRadius.circular(16)
                  ),
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Text("Log out"),
                ),
              ),
              const SizedBox(width: 30,),
            ],
          )
        ],
      ),
      drawer: Drawer(
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/Book Vector.png", width: 300, height: 300,),
            Container(
              width: 300,
              child: Text(
                "Cari, Ulas\n Buku, dan Buat\n Daftar Bacamu",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),
              ),
            )
          ],
        ),
      ),
bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Daftar Membaca',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Cari Buku',
          ),
        ],
        selectedItemColor: Colors.teal[800], // Adjust the color to match your design
        // Add onTap or currentIndex logic as needed
      ),
    );
  }
}