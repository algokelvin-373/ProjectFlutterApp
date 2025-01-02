// Mocks generated by Mockito 5.4.4 from annotations
// in movie_tv_level_maximum/test/data/repositories/tv_show/tv_show_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i9;
import 'package:movie_tv_level_maximum/data/data_sources/tv_show/tv_show_local_data_source.dart'
    as _i7;
import 'package:movie_tv_level_maximum/data/data_sources/tv_show/tv_show_remote_data_source.dart'
    as _i4;
import 'package:movie_tv_level_maximum/data/models/tv_show/tv_show_detail_response.dart'
    as _i2;
import 'package:movie_tv_level_maximum/data/models/tv_show/tv_show_episodes_response.dart'
    as _i3;
import 'package:movie_tv_level_maximum/data/models/tv_show/tv_show_model.dart'
    as _i6;
import 'package:movie_tv_level_maximum/data/models/tv_show/tv_show_table.dart'
    as _i8;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeTvShowDetailResponse_0 extends _i1.SmartFake
    implements _i2.TvShowDetailResponse {
  _FakeTvShowDetailResponse_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTvShowEpisodeResponse_1 extends _i1.SmartFake
    implements _i3.TvShowEpisodeResponse {
  _FakeTvShowEpisodeResponse_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TvShowRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvShowRemoteDataSource extends _i1.Mock
    implements _i4.TvShowRemoteDataSource {
  MockTvShowRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<List<_i6.TvShowModel>> getAiringTodayTvShow() =>
      (super.noSuchMethod(
        Invocation.method(
          #getAiringTodayTvShow,
          [],
        ),
        returnValue:
            _i5.Future<List<_i6.TvShowModel>>.value(<_i6.TvShowModel>[]),
      ) as _i5.Future<List<_i6.TvShowModel>>);

  @override
  _i5.Future<List<_i6.TvShowModel>> getOnTheAirTvShow() => (super.noSuchMethod(
        Invocation.method(
          #getOnTheAirTvShow,
          [],
        ),
        returnValue:
            _i5.Future<List<_i6.TvShowModel>>.value(<_i6.TvShowModel>[]),
      ) as _i5.Future<List<_i6.TvShowModel>>);

  @override
  _i5.Future<List<_i6.TvShowModel>> getPopularTvShow() => (super.noSuchMethod(
        Invocation.method(
          #getPopularTvShow,
          [],
        ),
        returnValue:
            _i5.Future<List<_i6.TvShowModel>>.value(<_i6.TvShowModel>[]),
      ) as _i5.Future<List<_i6.TvShowModel>>);

  @override
  _i5.Future<List<_i6.TvShowModel>> getTopRatedTvShow() => (super.noSuchMethod(
        Invocation.method(
          #getTopRatedTvShow,
          [],
        ),
        returnValue:
            _i5.Future<List<_i6.TvShowModel>>.value(<_i6.TvShowModel>[]),
      ) as _i5.Future<List<_i6.TvShowModel>>);

  @override
  _i5.Future<_i2.TvShowDetailResponse> getTvShowDetail(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTvShowDetail,
          [id],
        ),
        returnValue: _i5.Future<_i2.TvShowDetailResponse>.value(
            _FakeTvShowDetailResponse_0(
          this,
          Invocation.method(
            #getTvShowDetail,
            [id],
          ),
        )),
      ) as _i5.Future<_i2.TvShowDetailResponse>);

  @override
  _i5.Future<List<_i6.TvShowModel>> searchTvShow(String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchTvShow,
          [query],
        ),
        returnValue:
            _i5.Future<List<_i6.TvShowModel>>.value(<_i6.TvShowModel>[]),
      ) as _i5.Future<List<_i6.TvShowModel>>);

  @override
  _i5.Future<List<_i6.TvShowModel>> getTvShowRecommendation(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTvShowRecommendation,
          [id],
        ),
        returnValue:
            _i5.Future<List<_i6.TvShowModel>>.value(<_i6.TvShowModel>[]),
      ) as _i5.Future<List<_i6.TvShowModel>>);

  @override
  _i5.Future<_i3.TvShowEpisodeResponse> getAllEpisodes(
    int? id,
    int? season,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAllEpisodes,
          [
            id,
            season,
          ],
        ),
        returnValue: _i5.Future<_i3.TvShowEpisodeResponse>.value(
            _FakeTvShowEpisodeResponse_1(
          this,
          Invocation.method(
            #getAllEpisodes,
            [
              id,
              season,
            ],
          ),
        )),
      ) as _i5.Future<_i3.TvShowEpisodeResponse>);
}

/// A class which mocks [TvShowLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvShowLocalDataSource extends _i1.Mock
    implements _i7.TvShowLocalDataSource {
  MockTvShowLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<String> insertWatchlistTvShow(_i8.TvShowTable? tvShow) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertWatchlistTvShow,
          [tvShow],
        ),
        returnValue: _i5.Future<String>.value(_i9.dummyValue<String>(
          this,
          Invocation.method(
            #insertWatchlistTvShow,
            [tvShow],
          ),
        )),
      ) as _i5.Future<String>);

  @override
  _i5.Future<String> removeWatchlistTvShow(_i8.TvShowTable? tvShow) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlistTvShow,
          [tvShow],
        ),
        returnValue: _i5.Future<String>.value(_i9.dummyValue<String>(
          this,
          Invocation.method(
            #removeWatchlistTvShow,
            [tvShow],
          ),
        )),
      ) as _i5.Future<String>);

  @override
  _i5.Future<List<_i8.TvShowTable>> getWatchlistTvShow() => (super.noSuchMethod(
        Invocation.method(
          #getWatchlistTvShow,
          [],
        ),
        returnValue:
            _i5.Future<List<_i8.TvShowTable>>.value(<_i8.TvShowTable>[]),
      ) as _i5.Future<List<_i8.TvShowTable>>);

  @override
  _i5.Future<_i8.TvShowTable?> getTvShowById(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getTvShowById,
          [id],
        ),
        returnValue: _i5.Future<_i8.TvShowTable?>.value(),
      ) as _i5.Future<_i8.TvShowTable?>);
}
