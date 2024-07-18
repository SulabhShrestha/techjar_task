import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:techjar_task/providers/user_info_provider.dart';
import 'package:techjar_task/view_models/user_view_model.dart';
import 'package:techjar_task/views/core_widgets/shimmer_loading.dart';

/// Displays information related to user
class UserPage extends ConsumerWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myInfo = ref.watch(userInfoProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: Column(
            children: [
              // User details
              Card(
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(myInfo["name"]),
                  subtitle: Text(myInfo["email"]),
                ),
              ),

              SizedBox(height: 20.h),

              // show all user
              FutureBuilder(
                  future: UserViewModel().getAllUser(),
                  builder: (_, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(child: Text("Something went wrong"));
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (_, __) => ShimmerLoading(
                              height: 62.h, width: double.infinity),
                          separatorBuilder: (_, __) => SizedBox(height: 8.h),
                          itemCount: 5);
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Total users: ${snapshot.data!.length}"),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (_, index) {
                            return Card(
                              child: ListTile(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      barrierColor: Colors.black54,
                                      builder: (_) {
                                        return Dialog(
                                          shadowColor: Colors.blue.shade300,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 18.w,
                                                vertical: 12.h),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  richText(
                                                      "Name: ",
                                                      snapshot
                                                          .data![index].name),
                                                  SizedBox(height: 2.h),
                                                  richText(
                                                      "Username: ",
                                                      snapshot.data![index]
                                                          .username),
                                                  SizedBox(height: 2.h),
                                                  richText(
                                                      "Email: ",
                                                      snapshot
                                                          .data![index].email),
                                                  SizedBox(height: 2.h),
                                                  richText(
                                                      "Phone number: ",
                                                      snapshot
                                                          .data![index].phone),
                                                ]),
                                          ),
                                        );
                                      });
                                },
                                title: Text(snapshot.data![index].username),
                                subtitle: Text(snapshot.data![index].email),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget richText(String firstWord, String secondWord) => Text.rich(
        TextSpan(
          text: firstWord,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black54),
          children: [
            TextSpan(
                text: secondWord, style: const TextStyle(color: Colors.black))
          ],
        ),
      );
}
