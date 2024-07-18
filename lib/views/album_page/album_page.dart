import 'package:flutter/material.dart';
import 'package:techjar_task/models/album_model.dart';
import 'package:techjar_task/view_models/album_view_model.dart';
import 'package:techjar_task/views/view_album_photo_page/view_album_photo_page.dart';

class AlbumPage extends StatelessWidget {
  const AlbumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Album Page'),
        backgroundColor: Colors.blue.shade300,
      ),
      body: Column(
        children: [
          FutureBuilder<List<AlbumModel>>(
              future: AlbumViewModel().fetchAlbums(),
              builder: (_, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text("Something went wrong"));
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
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
    );
  }
}
