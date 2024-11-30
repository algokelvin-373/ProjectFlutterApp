import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisata_app_level_two/data/api/api_services.dart';
import 'package:wisata_app_level_two/data/model/tourism.dart';
import 'package:wisata_app_level_two/data/model/tourism_detail_response.dart';
import 'package:wisata_app_level_two/provider/detail/bookmaart_icon_provider.dart';
import 'package:wisata_app_level_two/screen/detail/bookmark_icon_widget.dart';

import 'body_of_detail_screen_widget.dart';

class DetailScreen extends StatefulWidget {
  final int tourismId;

  const DetailScreen({
    super.key,
    required this.tourismId,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final Completer<Tourism> _completerTourism = Completer<Tourism>();
  late Future<TourismDetailResponse> _futureTourismDetail;

  @override
  void initState() {
    super.initState();
    _futureTourismDetail = ApiServices().getTourismDetail(widget.tourismId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tourism Detail"),
        actions: [
          ChangeNotifierProvider(
            create: (context) => BookmarkIconProvider(),
            child: FutureBuilder(
              future: _completerTourism.future,
              builder: (context, snapshot) {
                return switch (snapshot.connectionState) {
                  ConnectionState.done => BookmarkIconWidget(tourism: snapshot.data!),
                  _ => const SizedBox(),
                };
              }),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _futureTourismDetail,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              final tourismData = snapshot.data!.place;
              _completerTourism.complete(tourismData);
              return BodyOfDetailScreenWidget(tourism: tourismData);
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}