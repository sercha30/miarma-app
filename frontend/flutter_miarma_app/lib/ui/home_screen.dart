import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miarma_app/blocs/posts_bloc/posts_bloc.dart';
import 'package:flutter_miarma_app/models/post_model.dart';
import 'package:flutter_miarma_app/resources/repository/posts_repository.dart/post_repository.dart';
import 'package:flutter_miarma_app/resources/repository/posts_repository.dart/post_repository_impl.dart';
import 'package:flutter_miarma_app/styles.dart';
import 'package:flutter_miarma_app/ui/widgets/error_page.dart';
import 'package:flutter_miarma_app/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PostRepository postRepository;

  @override
  void initState() {
    super.initState();
    postRepository = PostRepositoryImpl();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return PostsBloc(postRepository)
          ..add(FetchPostWithType(Constants.public));
      },
      child: Scaffold(
        body: _createPosts(context),
      ),
    );
  }

  Widget _createStories() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: const Border.fromBorderSide(
                    BorderSide(color: Color(0xffDF2D46), width: 2))),
            width: 75,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset('assets/images/mock-profile-photo.jpg'),
              ),
            ),
          ),
          const Text('Story')
        ],
      ),
    );
  }

  Widget _createPosts(BuildContext context) {
    return BlocBuilder<PostsBloc, PostsState>(builder: (context, state) {
      if (state is PostsInitial) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is PostFetchError) {
        return ErrorPage(
            message: state.message,
            retry: () {
              context
                  .watch<PostsBloc>()
                  .add(FetchPostWithType(Constants.public));
            });
      } else if (state is PostsFetched) {
        return _createPublicPostsView(context, state.posts);
      } else {
        return const Text('Not support');
      }
    });
  }

  Widget _createPublicPostsView(BuildContext context, List<Post> posts) {
    return CustomScrollView(
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
                children: List.generate(20, (index) {
                  return _createStories();
                })),
          ),
          SizedBox(
              height: 500,
              child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (BuildContext context, int index) {
                  return _createPublicPostViewItem(context, posts[index]);
                },
                padding: const EdgeInsets.all(0),
                scrollDirection: Axis.vertical,
              ))
        ]))
      ],
    );
  }

  Widget _createPublicPostViewItem(BuildContext context, Post post) {
    return Column(
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
                      child: Image.network(
                        'http://10.0.2.2' + post.avatar!.substring(16),
                        width: 30,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(post.nickUsuario!),
                ],
              ),
              const Icon(Icons.more_horiz)
            ],
          ),
        ),
        Image.network('http://10.0.2.2' + post.transformedMedia!.substring(16)),
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
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 3.0),
                child: Text(
                  post.nickUsuario!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(post.contenido!)
            ],
          ),
        )
      ],
    );
  }
}
