import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _password1Controller = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC2F4E3),
      appBar: AppBar(
        actions: [
          Row(
            children: [
              Image.asset(
                "assets/images/Frame 33.png",
                width: 40,
                height: 40,
              ),
              const SizedBox(
                width: 90,
              ),
              const Text("Daftar Membaca"),
              const SizedBox(
                width: 30,
              ),
              const Text("Cari Buku"),
              const SizedBox(
                width: 30,
              ),
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFF3BEDB7),
                      borderRadius: BorderRadius.circular(16)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: const Text("Log out"),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
            ],
          )
        ],
      ),
      drawer: const Drawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 400,
              margin: EdgeInsets.symmetric(horizontal: 80),
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 51),
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF)
              ),
              child: Column(
                children: [
                  const Text(
                    "Edit Profile",
                    style: TextStyle(
                      fontSize: 35,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Masukkan username baru:"),
                      const SizedBox(height: 5,),
                      SizedBox(
                        height: 40,
                        child: TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            fillColor: const Color(0xFF3BEDB7).withOpacity(0.25),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: const Color(0xFF3BEDB7).withOpacity(0.25)),
                                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                              ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            ),
                            focusedErrorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            ),
                            labelStyle: const TextStyle(color: Color(0xFF8391A1)),
                          ),
                          obscureText: false,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Masukkan password baru:"),
                      const SizedBox(height: 5,),
                      SizedBox(
                        height: 40,
                        child: TextFormField(
                          controller: _password1Controller,
                          decoration: InputDecoration(
                            fillColor: const Color(0xFF3BEDB7).withOpacity(0.25),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: const Color(0xFF3BEDB7).withOpacity(0.25)),
                                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                              ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            ),
                            focusedErrorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            ),
                            labelStyle: const TextStyle(color: Color(0xFF8391A1)),
                          ),
                          obscureText: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Masukkan password baru:"),
                      const SizedBox(height: 5,),
                      SizedBox(
                        height: 40,
                        child: TextFormField(
                          controller: _password2Controller,
                          decoration: InputDecoration(
                            fillColor: const Color(0xFF3BEDB7).withOpacity(0.25),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: const Color(0xFF3BEDB7).withOpacity(0.25)),
                                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                              ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            ),
                            focusedErrorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            ),
                            labelStyle: const TextStyle(color: Color(0xFF8391A1)),
                          ),
                          obscureText: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  GestureDetector(
                    onTap: () {
                      // Future async function
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF027788),
                        borderRadius: BorderRadius.circular(25)
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 45),
                      child: const Text("Save"),
                    ),
                  )
                ],
              ),
              
            ),
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
        selectedItemColor:
            Colors.teal[800], // Adjust the color to match your design
        // Add onTap or currentIndex logic as needed
      ),
    );
  }
}
