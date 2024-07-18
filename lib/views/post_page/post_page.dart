import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:techjar_task/models/post_model.dart';
import 'package:techjar_task/view_models/post_view_model.dart';
import 'package:techjar_task/views/core_widgets/shimmer_loading.dart';
import 'package:techjar_task/views/post_view_page/post_view_page.dart';
import 'package:techjar_task/views/post_page/widgets/post_card.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Page'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        child: FutureBuilder<List<PostModel>>(
          future: PostViewModel().getAllPosts(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ListView.separated(
                  itemBuilder: (_, __) =>
                      ShimmerLoading(height: 92.h, width: double.infinity),
                  separatorBuilder: (_, __) => SizedBox(height: 8.h),
                  itemCount: 5);
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              return ListView.separated(
                itemCount: snapshot.data!.length,
                separatorBuilder: (context, index) => SizedBox(height: 8.h),
                itemBuilder: (_, index) {
                  return Hero(
                    tag: "topic",
                    child: PostCard(
                      postModel: snapshot.data![index],
                      titleMaxLines: 1,
                      bodyMaxLines: 2,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PostViewPage(
                              postModel: snapshot.data![index],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
