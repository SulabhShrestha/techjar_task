import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:techjar_task/models/comment_model.dart';
import 'package:techjar_task/models/post_model.dart';
import 'package:techjar_task/providers/post_comment_provider.dart';
import 'package:techjar_task/providers/user_info_provider.dart';
import 'package:techjar_task/services/comment_web_services.dart';
import 'package:techjar_task/view_models/comment_view_models.dart';
import 'package:techjar_task/views/post_page/widgets/post_card.dart';

class PostViewPage extends ConsumerStatefulWidget {
  final PostModel postModel;
  const PostViewPage({
    super.key,
    required this.postModel,
  });

  @override
  ConsumerState<PostViewPage> createState() => _PostViewPageState();
}

class _PostViewPageState extends ConsumerState<PostViewPage> {
  final TextEditingController _commentController = TextEditingController();
  int totalComments = 0;

  late final List<CommentModel> comments;

  @override
  void initState() {
    super.initState();
    comments = ref.read(postCommentsProvider);

    // only initialize comments if it's empty
    var comment = comments.firstWhere(
        (comment) => comment.postId == widget.postModel.id,
        orElse: () =>
            CommentModel(postId: 0, id: 0, name: "", email: "", body: ""));

    if (comment.body.isEmpty) {
      initializeComments(ref);
    }
  }

  Future<void> initializeComments(WidgetRef ref) async {
    final allComments = await CommentViewModel()
        .getAllCommentsForPost(widget.postModel.id.toString());

    totalComments = allComments.length;

    ref.read(postCommentsProvider.notifier).addAllComments(allComments);
  }

  @override
  Widget build(BuildContext context) {
    final postComments = ref
        .watch(postCommentsProvider)
        .where((comment) => comment.postId == widget.postModel.id)
        .toList();

    return Scaffold(
      floatingActionButton: Container(
        height: 66.h,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
        child: Center(
          child: TextField(
            controller: _commentController,
            onSubmitted: (comment) {
              addComment(comment);
              _commentController.clear();
            },
            decoration: const InputDecoration(
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
                PostCard(postModel: widget.postModel),

                SizedBox(height: 12.h),

                // Post's comments
                Builder(builder: (_) {
                  if (postComments.isEmpty) {
                    return const Center(
                      child: Text('No comments yet'),
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Comments $totalComments'),
                      for (var comment in postComments)
                        Card(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 8.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  comment.email,
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(comment.body),
                              ],
                            ),
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

  void addComment(String comment) {
    final userData = ref.watch(userInfoProvider);
    final commentModel = CommentModel(
      postId: widget.postModel.id,
      id: totalComments + 1,
      name: userData["name"],
      email: userData["email"],
      body: comment,
    );

    try {
      CommentViewModel().addComment(
          details: commentModel.toMap(),
          postID: widget.postModel.id.toString());
      ref.read(postCommentsProvider.notifier).addComment(commentModel);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}
