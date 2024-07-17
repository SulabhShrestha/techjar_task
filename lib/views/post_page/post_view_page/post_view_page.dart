import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:techjar_task/models/comment_model.dart';
import 'package:techjar_task/models/post_model.dart';
import 'package:techjar_task/services/comment_web_services.dart';
import 'package:techjar_task/views/post_page/widgets/post_card.dart';

class PostViewPage extends StatelessWidget {
  final PostModel postModel;
  const PostViewPage({
    super.key,
    required this.postModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        height: 66.h,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
        child: Center(
          child: TextField(
            onSubmitted: (comment) {},
            decoration: InputDecoration(
              hintText: 'Write your comment here',
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 8.w, right: 8.w, bottom: 70.h),
            child: Column(
              children: [
                // Post details,
                PostCard(postModel: postModel),

                SizedBox(height: 12.h),

                // Post's comments
                FutureBuilder<List<CommentModel>>(
                    future: CommentWebServices()
                        .getAllCommentsForPost(postModel.id.toString()),
                    builder: (_, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text('Something went wrong'),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 16.0),
                            child: Text(
                              "All comments",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                          ),
                          for (var comment in snapshot.data!)
                            Card(
                              child: ListTile(
                                title: Text(comment.name),
                                subtitle: Text(comment.body),
                              ),
                            ),
                          for (var comment in snapshot.data!)
                            Card(
                              child: ListTile(
                                title: Text(comment.name),
                                subtitle: Text(comment.body),
                              ),
                            ),
                        ],
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
