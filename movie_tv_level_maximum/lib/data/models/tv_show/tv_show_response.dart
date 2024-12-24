import 'package:movie_tv_level_maximum/data/models/tv_show/tv_show_model.dart';

class TvShowResponse {
  int page;
  List<TvShowModel> tvShowList;
  int totalPages;
  int totalResults;

  TvShowResponse({
    required this.page,
    required this.tvShowList,
    required this.totalPages,
    required this.totalResults,
  });

  factory TvShowResponse.fromJson(Map<String, dynamic> json) {
    return TvShowResponse(
      tvShowList: List<TvShowModel>.from(
        (json['results'] as List).map((item) => TvShowModel.fromJson(item)),
      ),
      page: json['page'],
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'results': tvShowList.map((item) => item.toJson()).toList(),
      'page': page,
      'total_pages': totalPages,
      'total_results': totalResults,
    };
  }

}
