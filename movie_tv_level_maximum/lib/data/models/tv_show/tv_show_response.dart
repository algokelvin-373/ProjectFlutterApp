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

  factory TvShowResponse.fromJson(Map<String, dynamic> json) => TvShowResponse(
    page: json["page"],
    tvShowList: List<TvShowModel>.from(json["results"].map((x) => TvShowModel.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": List<dynamic>.from(tvShowList.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}