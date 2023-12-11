import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController bookNameController = TextEditingController();
  final TextEditingController genreController = TextEditingController();
  final TextEditingController pageCountController = TextEditingController();
  final TextEditingController coverLinkController = TextEditingController();
  final TextEditingController synopsisController = TextEditingController();
  bool termsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Conversion',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Conversion'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildTopBar(),
              _buildAddBookSection(),
              _buildFooterSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      // Atur sesuai desain
    );
  }

  Widget _buildAddBookSection() {
    return Container(
      padding: EdgeInsets.all(32),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Tambah buku',
            style: TextStyle(
              color: Colors.black,
              fontSize: 48,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 32),
          _buildTextField(bookNameController, 'Nama buku', 'Masukkan nama buku di sini'),
          _buildTextField(genreController, 'Genre buku', 'Masukkan genre buku di sini'),
          _buildTextField(pageCountController, 'Jumlah halaman buku', 'Masukkan jumlah halaman di sini'),
          _buildTextField(coverLinkController, 'Link cover buku', 'Masukkan link menuju gambar cover di sini'),
          _buildTextField(synopsisController, 'Sinopsis buku', 'Masukkan sinopsis buku di sini', maxLines: 10),
          SizedBox(height: 16),
          Row(
            children: <Widget>[
              Checkbox(
                value: termsAccepted,
                onChanged: (bool? value) {
                  setState(() {
                    termsAccepted = value ?? false;
                  });
                },
              ),
              Expanded(
                child: Text(
                  'Saya menyetujui syarat dan ketentuan yang berlaku',
                  style: TextStyle(
                    color: Color(0xFF115BFB),
                    fontSize: 25,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (termsAccepted) {
                  // Handle Publish Logic
                }
                // Handle validation or show error
              },
              child: Text(
                'Terbitkan buku',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontFamily: 'Raleway',
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF3BEDB7),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterSection() {
    return Container(
      // Atur sesuai desain
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, String placeholder, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            color: Colors.black,
            fontSize: 45,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.normal,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Color.fromRGBO(1, 1, 1, 0.25),
              ),
            ),
            hintText: placeholder,
            hintStyle: TextStyle(
              color: Color.fromRGBO(1, 1, 1, 0.60),
              fontSize: 32,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
