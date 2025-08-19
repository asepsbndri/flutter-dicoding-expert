import 'dart:convert';

import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/tv_series_detail_model.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvSeriesDetailResponse = TvSeriesDetailResponse(
    adult: false,
    backdropPath: "/path/to/backdrop.jpg",
    episodeRunTime: [60],
    firstAirDate: "2023-01-01",
    genres: [GenreModel(id: 1, name: "Drama")],
    homepage: "https://example.com",
    id: 1,
    inProduction: false,
    languages: ["en"],
    lastAirDate: "2023-01-31",
    name: "Test Series",
    numberOfEpisodes: 10,
    numberOfSeasons: 1,
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "Original Test Series",
    overview: "This is a test overview",
    popularity: 123.45,
    posterPath: "/path/to/poster.jpg",
    productionCompanies: [],
    productionCountries: [],
    spokenLanguages: [],
    status: "Ended",
    tagline: "Just a tagline",
    type: "Scripted",
    voteAverage: 8.5,
    voteCount: 100,
  );

  final tTvSeriesDetailEntity = TvSeriesDetail(
    id: 1,
    name: "Test Series",
    overview: "This is a test overview",
    posterPath: "/path/to/poster.jpg",
    backdropPath: "/path/to/backdrop.jpg",
    voteAverage: 8.5,
    voteCount: 100,
    genres: [GenreModel(id: 1, name: "Drama").toEntity()],
    firstAirDate: "2023-01-01",
    numberOfSeasons: 1,
    numberOfEpisodes: 10,
  );

  test('should return a valid model from JSON', () {
    final Map<String, dynamic> jsonMap = json.decode('''
    {
      "adult": false,
      "backdrop_path": "/path/to/backdrop.jpg",
      "episode_run_time": [60],
      "first_air_date": "2023-01-01",
      "genres": [{"id": 1, "name": "Drama"}],
      "homepage": "https://example.com",
      "id": 1,
      "in_production": false,
      "languages": ["en"],
      "last_air_date": "2023-01-31",
      "name": "Test Series",
      "number_of_episodes": 10,
      "number_of_seasons": 1,
      "origin_country": ["US"],
      "original_language": "en",
      "original_name": "Original Test Series",
      "overview": "This is a test overview",
      "popularity": 123.45,
      "poster_path": "/path/to/poster.jpg",
      "production_companies": [],
      "production_countries": [],
      "spoken_languages": [],
      "status": "Ended",
      "tagline": "Just a tagline",
      "type": "Scripted",
      "vote_average": 8.5,
      "vote_count": 100
    }
    ''');

    final result = TvSeriesDetailResponse.fromJson(jsonMap);
    expect(result, equals(tTvSeriesDetailResponse));
  });

  test('should return a valid JSON map from model', () {
    final result = tTvSeriesDetailResponse.toJson();
    final expectedMap = {
      "adult": false,
      "backdrop_path": "/path/to/backdrop.jpg",
      "episode_run_time": [60],
      "first_air_date": "2023-01-01",
      "genres": [
        {"id": 1, "name": "Drama"}
      ],
      "homepage": "https://example.com",
      "id": 1,
      "in_production": false,
      "languages": ["en"],
      "last_air_date": "2023-01-31",
      "name": "Test Series",
      "number_of_episodes": 10,
      "number_of_seasons": 1,
      "origin_country": ["US"],
      "original_language": "en",
      "original_name": "Original Test Series",
      "overview": "This is a test overview",
      "popularity": 123.45,
      "poster_path": "/path/to/poster.jpg",
      "production_companies": [],
      "production_countries": [],
      "spoken_languages": [],
      "status": "Ended",
      "tagline": "Just a tagline",
      "type": "Scripted",
      "vote_average": 8.5,
      "vote_count": 100
    };
    expect(result, expectedMap);
  });

  test('should convert TvSeriesDetailResponse to entity correctly', () {
    final result = tTvSeriesDetailResponse.toEntity();
    expect(result, equals(tTvSeriesDetailEntity));
  });
}
