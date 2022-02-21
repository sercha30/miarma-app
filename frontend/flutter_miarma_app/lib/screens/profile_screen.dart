import 'package:flutter/material.dart';
import 'package:flutter_miarma_app/styles.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              'username',
              style: CustomStyles.usernameProfileText,
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 145.0),
                child: const Icon(
                  Icons.expand_more,
                  color: Colors.black,
                ),
              ),
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
                      Icons.menu,
                      color: Colors.black,
                    ),
                  )
                ],
              )
            ],
            floating: true,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: const Border.fromBorderSide(
                                    BorderSide(color: Colors.grey, width: 2))),
                            width: 100,
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(
                                    'assets/images/mock-profile-photo.jpg'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        '0,000',
                                        style: CustomStyles.countNumberText,
                                      ),
                                      Text(
                                        'Posts',
                                        style: CustomStyles.userProfileSubText,
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        '0,000',
                                        style: CustomStyles.countNumberText,
                                      ),
                                      Text(
                                        'Seguidores',
                                        style: CustomStyles.userProfileSubText,
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        '0,000',
                                        style: CustomStyles.countNumberText,
                                      ),
                                      Text(
                                        'Siguiendo',
                                        style: CustomStyles.userProfileSubText,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Username',
                          style: CustomStyles.userProfileNameText,
                        ),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                          style: CustomStyles.userProfileSubText,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 135.0, vertical: 5.0),
                            decoration: const BoxDecoration(
                                border: Border.fromBorderSide(
                                    BorderSide(color: Colors.grey, width: 1))),
                            child: Text(
                              'Editar perfil',
                              style: CustomStyles.userProfileNameText,
                            ),
                          ),
                        ),
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
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: const Border.fromBorderSide(
                                              BorderSide(
                                                  color: Colors.grey,
                                                  width: 2))),
                                      width: 75,
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
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
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: const Border.fromBorderSide(
                                              BorderSide(
                                                  color: Colors.grey,
                                                  width: 2))),
                                      width: 75,
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
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
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: const Border.fromBorderSide(
                                              BorderSide(
                                                  color: Colors.grey,
                                                  width: 2))),
                                      width: 75,
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
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
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: const Border.fromBorderSide(
                                              BorderSide(
                                                  color: Colors.grey,
                                                  width: 2))),
                                      width: 75,
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
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
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: const Border.fromBorderSide(
                                              BorderSide(
                                                  color: Colors.grey,
                                                  width: 2))),
                                      width: 75,
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
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
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: const Border.fromBorderSide(
                                              BorderSide(
                                                  color: Colors.grey,
                                                  width: 2))),
                                      width: 75,
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
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
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: const Border.fromBorderSide(
                                              BorderSide(
                                                  color: Colors.grey,
                                                  width: 2))),
                                      width: 75,
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
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
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 50,
                child: TabBar(
                    indicatorColor: Colors.grey,
                    controller: tabController,
                    tabs: const [
                      Tab(
                        icon: Icon(
                          Icons.grid_on,
                          color: Colors.black,
                        ),
                      ),
                      Tab(
                        icon: Icon(
                          Icons.portrait,
                          color: Colors.black,
                        ),
                      )
                    ]),
              ),
              SizedBox(
                height: 215,
                child: TabBarView(controller: tabController, children: [
                  GridView.count(
                    padding: const EdgeInsets.all(0),
                    mainAxisSpacing: 3,
                    crossAxisSpacing: 3,
                    crossAxisCount: 3,
                    children: List.generate(20, (index) {
                      return Image.asset(
                          'assets/images/mock-profile-photo.jpg');
                    }),
                  ),
                  GridView.count(
                    padding: const EdgeInsets.all(0),
                    mainAxisSpacing: 3,
                    crossAxisSpacing: 3,
                    crossAxisCount: 3,
                    children: List.generate(20, (index) {
                      return Image.asset(
                          'assets/images/mock-profile-photo.jpg');
                    }),
                  ),
                ]),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
