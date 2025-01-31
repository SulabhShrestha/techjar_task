import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:techjar_task/models/album_model.dart';
import 'package:techjar_task/utils/app_colors.dart';
import 'package:techjar_task/view_models/album_view_model.dart';
import 'package:techjar_task/views/core_widgets/shimmer_loading.dart';
import 'package:techjar_task/views/view_album_photo_page/view_album_photo_page.dart';

class AlbumPage extends StatelessWidget {
  const AlbumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Album Page'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        child: Column(
          children: [
            FutureBuilder<List<AlbumModel>>(
                future: AlbumViewModel().fetchAlbums(),
                builder: (_, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text("Something went wrong"));
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.w,
                        mainAxisSpacing: 8.h,
                        children: List.generate(10, (index) {
                          return const ShimmerLoading();
                        }),
                      ),
                    );
                  }

                  return Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                      children: List.generate(snapshot.data!.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ViewAlbumPhotoPage(
                                  albumModel: snapshot.data![index],
                                ),
                              ),
                            );
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.blue.shade100,
                                child: Text(
                                  snapshot.data![index].id.toString(),
                                  style: const TextStyle(
                                    fontSize: 48,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
