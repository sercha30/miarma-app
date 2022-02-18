import 'package:flutter/material.dart';
import 'package:flutter_miarma_app/styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              'MiarmaApp',
              style: CustomStyles.appBarTitleText,
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.add_box_outlined,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.send_outlined,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ],
            floating: true,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: const Border.fromBorderSide(BorderSide(
                                  color: Color(0xffDF2D46), width: 2))),
                          width: 75,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                  'assets/images/mock-profile-photo.jpg'),
                            ),
                          ),
                        ),
                        const Text('Story')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: const Border.fromBorderSide(BorderSide(
                                  color: Color(0xffDF2D46), width: 2))),
                          width: 75,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                  'assets/images/mock-profile-photo.jpg'),
                            ),
                          ),
                        ),
                        const Text('Story')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: const Border.fromBorderSide(BorderSide(
                                  color: Color(0xffDF2D46), width: 2))),
                          width: 75,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                  'assets/images/mock-profile-photo.jpg'),
                            ),
                          ),
                        ),
                        const Text('Story')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: const Border.fromBorderSide(BorderSide(
                                  color: Color(0xffDF2D46), width: 2))),
                          width: 75,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                  'assets/images/mock-profile-photo.jpg'),
                            ),
                          ),
                        ),
                        const Text('Story')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: const Border.fromBorderSide(BorderSide(
                                  color: Color(0xffDF2D46), width: 2))),
                          width: 75,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                  'assets/images/mock-profile-photo.jpg'),
                            ),
                          ),
                        ),
                        const Text('Story')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: const Border.fromBorderSide(BorderSide(
                                  color: Color(0xffDF2D46), width: 2))),
                          width: 75,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                  'assets/images/mock-profile-photo.jpg'),
                            ),
                          ),
                        ),
                        const Text('Story')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: const Border.fromBorderSide(BorderSide(
                                  color: Color(0xffDF2D46), width: 2))),
                          width: 75,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                  'assets/images/mock-profile-photo.jpg'),
                            ),
                          ),
                        ),
                        const Text('Story')
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 500,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.asset(
                                      'assets/images/mock-profile-photo.jpg',
                                      width: 30,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Text('User1234'),
                              ],
                            ),
                            const Icon(Icons.more_horiz)
                          ],
                        ),
                      ),
                      Image.network(
                          'https://cdn.pixabay.com/photo/2022/01/26/04/47/house-6967908_960_720.jpg'),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: Icon(Icons.favorite_border),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: Icon(Icons.chat_bubble_outline),
                                ),
                                Icon(Icons.send_outlined)
                              ],
                            ),
                            const Icon(Icons.bookmark_outline)
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0, top: 5.0),
                        child: Text(
                          '100 Me gusta',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(right: 3.0),
                              child: Text(
                                'User1234',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text('Lorem ipsum dolor sit amet...')
                          ],
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.asset(
                                      'assets/images/mock-profile-photo.jpg',
                                      width: 30,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Text('User1234'),
                              ],
                            ),
                            const Icon(Icons.more_horiz)
                          ],
                        ),
                      ),
                      Image.network(
                          'https://cdn.pixabay.com/photo/2022/01/26/04/47/house-6967908_960_720.jpg'),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: Icon(Icons.favorite_border),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: Icon(Icons.chat_bubble_outline),
                                ),
                                Icon(Icons.send_outlined)
                              ],
                            ),
                            const Icon(Icons.bookmark_outline)
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0, top: 5.0),
                        child: Text(
                          '100 Me gusta',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(right: 3.0),
                              child: Text(
                                'User1234',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text('Lorem ipsum dolor sit amet...')
                          ],
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.asset(
                                      'assets/images/mock-profile-photo.jpg',
                                      width: 30,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Text('User1234'),
                              ],
                            ),
                            const Icon(Icons.more_horiz)
                          ],
                        ),
                      ),
                      Image.network(
                          'https://cdn.pixabay.com/photo/2022/01/26/04/47/house-6967908_960_720.jpg'),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: Icon(Icons.favorite_border),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: Icon(Icons.chat_bubble_outline),
                                ),
                                Icon(Icons.send_outlined)
                              ],
                            ),
                            const Icon(Icons.bookmark_outline)
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0, top: 5.0),
                        child: Text(
                          '100 Me gusta',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(right: 3.0),
                              child: Text(
                                'User1234',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text('Lorem ipsum dolor sit amet...')
                          ],
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.asset(
                                      'assets/images/mock-profile-photo.jpg',
                                      width: 30,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Text('User1234'),
                              ],
                            ),
                            const Icon(Icons.more_horiz)
                          ],
                        ),
                      ),
                      Image.network(
                          'https://cdn.pixabay.com/photo/2022/01/26/04/47/house-6967908_960_720.jpg'),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: Icon(Icons.favorite_border),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: Icon(Icons.chat_bubble_outline),
                                ),
                                Icon(Icons.send_outlined)
                              ],
                            ),
                            const Icon(Icons.bookmark_outline)
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0, top: 5.0),
                        child: Text(
                          '100 Me gusta',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(right: 3.0),
                              child: Text(
                                'User1234',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text('Lorem ipsum dolor sit amet...')
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ]))
        ],
      ),
    );
  }
}
