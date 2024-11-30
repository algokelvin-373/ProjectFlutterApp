import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisata_app_level_two/provider/detail/bookmark_list_provider.dart';
import 'package:wisata_app_level_two/screen/home/tourism_card_widget.dart';
import 'package:wisata_app_level_two/static/navigation_route.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookmark List"),
      ),
      body: Consumer<BookmarkListProvider>(
        builder: (context, value, child) {
          final bookmarkList = value.bookmarkList;
          return switch (bookmarkList.isNotEmpty) {
            true => ListView.builder(
              itemCount: bookmarkList.length,
              itemBuilder: (context, index) {
                final tourism = bookmarkList[index];
                return TourismCard(
                  tourism: tourism,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      NavigationRoute.detailRoute.name,
                      arguments: tourism,
                    );
                  },
                );
              },
            ),
            _ => const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("No Bookmarked"),
                ],
              ),
            ),
          };
        },
      ),
    );
  }
}