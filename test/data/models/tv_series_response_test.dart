import 'dart:convert';

import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvSeriesModel = TvSeriesModel(
    adult: false,
    posterPath: '/36xXlhEpQqVVPuiZhfoQuaY4OlA.jpg',
    popularity: 539.2278,
    id: 119051,
    backdropPath: '/qg8Gv2w0dDL8cMsG2QO2hWp58wy.jpg',
    voteAverage: 8.403,
    overview:
        "Smart, sarcastic and a little dead inside, Wednesday Addams investigates twisted mysteries while making new friends — and foes — at Nevermore Academy.",
    firstAirDate: "2022-11-23",
    genreIds: [10765, 9648, 35],
    voteCount: 9445,
    name: "Wednesday",
    originalName: "Wednesday",
  );

  final tTvSeriesResponse = TvSeriesResponse(tvSeriesList: [tTvSeriesModel]);

  group('TvSeriesResponse', () {
    test('fromJson should return valid model', () {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode('''
      {
        "results": [
          {
            "adult": false,
            "poster_path": "/36xXlhEpQqVVPuiZhfoQuaY4OlA.jpg",
            "popularity": 539.2278,
            "id": 119051,
            "backdrop_path": "/qg8Gv2w0dDL8cMsG2QO2hWp58wy.jpg",
            "vote_average": 8.403,
            "overview": "Smart, sarcastic and a little dead inside, Wednesday Addams investigates twisted mysteries while making new friends — and foes — at Nevermore Academy.",
            "first_air_date": "2022-11-23",
            "genre_ids": [10765, 9648, 35],
            "vote_count": 9445,
            "name": "Wednesday",
            "original_name": "Wednesday"
          }
        ]
      }
      ''');

      // act
      final result = TvSeriesResponse.fromJson(jsonMap);

      // assert
      expect(result, equals(tTvSeriesResponse));
    });

    test('toJson should return valid Map', () {
      // act
      final result = tTvSeriesResponse.toJson();

      // assert
      final expectedJson = {
        "results": [
          {
            "adult": false,
            "poster_path": "/36xXlhEpQqVVPuiZhfoQuaY4OlA.jpg",
            "popularity": 539.2278,
            "id": 119051,
            "backdrop_path": "/qg8Gv2w0dDL8cMsG2QO2hWp58wy.jpg",
            "vote_average": 8.403,
            "overview":
                "Smart, sarcastic and a little dead inside, Wednesday Addams investigates twisted mysteries while making new friends — and foes — at Nevermore Academy.",
            "first_air_date": "2022-11-23",
            "genre_ids": [10765, 9648, 35],
            "vote_count": 9445,
            "name": "Wednesday",
            "original_name": "Wednesday"
          }
        ]
      };

      expect(result, equals(expectedJson));
    });
  });
}
