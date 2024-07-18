import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:techjar_task/models/album_model.dart';
import 'package:techjar_task/view_models/album_view_model.dart';

/// Displays the photos from the album
///
class ViewAlbumPhotoPage extends StatelessWidget {
  final AlbumModel albumModel;
  const ViewAlbumPhotoPage({
    super.key,
    required this.albumModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Album ${albumModel.id}"),
      ),
      body: FutureBuilder(
        future: AlbumViewModel().fetchPhotos(albumModel.id),
        builder: (_, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 8.w,
                mainAxisSpacing: 8.h,
                children: List.generate(10, (index) {
                  return shimmerLoading();
                }),
              ),
            );
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 8.w,
              mainAxisSpacing: 8.h,
              children: List.generate(snapshot.data!.length, (index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(snapshot.data![index]["url"]),
                );
              }),
            ),
          );
        },
      ),
    );
  }

  Widget shimmerLoading() => Shimmer.fromColors(
        baseColor: Colors.grey.shade400,
        highlightColor: Colors.grey.shade100,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      );
}
