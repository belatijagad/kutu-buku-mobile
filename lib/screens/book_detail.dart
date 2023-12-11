import 'package:flutter/material.dart';

class BookDetailPage extends StatefulWidget {
  const BookDetailPage({Key? key}) : super(key: key);

  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.network(
                          'https://upload.wikimedia.org/wikipedia/id/0/0b/Your_Name_poster.png',
                          fit: BoxFit.contain,
                        ),
                        const Positioned(
                          top: 0,
                          right: 0,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.bookmark,
                              color: Colors.teal,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: List.generate(
                                5,
                                (index) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                              ),
                            ),
                            Text(
                              'Kimi no Na wa. (2016)',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('Makoto Shinkai'),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.teal),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Romance',
                                  style: TextStyle(color: Colors.teal),
                                ),
                              ),
                            ),
                            Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Mulai Membaca',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: Colors.blue,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Ingin mengulas buku ini?',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [StarRating()]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(
                              width: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(),
                                color: Colors.white,
                              ),
                              child: TextField(
                                maxLines: 5,
                                decoration: InputDecoration(
                                  hintText: 'Your review...',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal.shade100,
                              ),
                              child: Text('Kirim ulasan'),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Ulasan Buku',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text('Urutkan berdasarkan'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: DropdownButton(
                              value: 'Reputasi',
                              items: [
                                DropdownMenuItem(
                                  child: Text('Reputasi'),
                                  value: 'Reputasi',
                                ),
                                DropdownMenuItem(
                                  child: Text('Tanggal Terbaru'),
                                  value: 'Tanggal Terbaru',
                                ),
                              ],
                              onChanged: (value) {},
                            ),
                          ),
                          FloatingActionButton(
                            child: Icon(Icons.arrow_downward_rounded),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0, 2.0),
                                  blurRadius: 4.0,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ini username',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Lorem ipsum',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 16.0,
                                    ),
                                    Text(
                                      '12/10/2023',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StarRating extends StatefulWidget {
  @override
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  int rating = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        5,
        (index) => GestureDetector(
          onTap: () {
            setState(() {
              rating = index + 1;
            });
          },
          child: Icon(
            index < rating ? Icons.star : Icons.star_outline,
            color: Colors.amber,
          ),
        ),
      ),
    );
  }
}
