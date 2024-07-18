import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:techjar_task/models/post_model.dart';

class PostCard extends StatelessWidget {
  final PostModel postModel;
  final VoidCallback? onTap;
  final int? titleMaxLines;
  final int? bodyMaxLines;

  const PostCard(
      {super.key,
      required this.postModel,
      this.onTap,
      this.titleMaxLines,
      this.bodyMaxLines});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // user info will go here
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.person),
                  Text(postModel.userId.toString()),
                ],
              ),

              SizedBox(height: 6.h),

              Text(
                postModel.title,
                maxLines: titleMaxLines,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 4.h),

              Text(
                postModel.body,
                maxLines: bodyMaxLines,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
