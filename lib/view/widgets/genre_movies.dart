import 'dart:developer';

import 'package:cubos_movies/controllers/movie_controller.dart';
import 'package:cubos_movies/model/movie_genre.dart';
import 'package:cubos_movies/view/widgets/movie_card_widget.dart';
import 'package:cubos_movies/widgets/centered_message.dart';
import 'package:cubos_movies/widgets/centered_progress.dart';
import 'package:flutter/material.dart';

class GenreMovies extends StatefulWidget {
  final int genreId;
  final List<MovieGenre> genres;

  GenreMovies({
    required this.genreId,
    required this.genres,
  });

  @override
  _GenreMoviesState createState() => _GenreMoviesState();
}

class _GenreMoviesState extends State<GenreMovies> {
  final _controller = MovieController();
  final _scrollController = ScrollController();
  int lastPage = 1;

  @override
  void initState() {
    super.initState();
    _initScrollListener();
    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return _buildGenreMovies();
  }

  _initScrollListener() {
    _scrollController.addListener(() async {
      if (_scrollController.offset >=
          _scrollController.position.maxScrollExtent) {
        if (_controller.currentPage == lastPage) {
          lastPage++;
          log(lastPage.toString());
          await _controller.fetchMoviesByGenre(
              page: lastPage, genre: widget.genreId);
          setState(() {});
        }
      }
    });
  }

  Future<void> _initialize() async {
    setState(() {
      _controller.loading = true;
    });

    await _controller.fetchMoviesByGenre(genre: widget.genreId);

    setState(() {
      _controller.loading = false;
    });
  }

  Widget _buildGenreMovies() {
    if (_controller.loading) {
      return CenteredProgress();
    }

    if (_controller.movieError != null || !_controller.hasMovies) {
      return CenteredMessage(message: _controller.movieError!.message!);
    }
    return _buildMovies();
  }

  Widget _buildMovies() {
    return RefreshIndicator(
      onRefresh: _initialize,
      child: GridView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(2.0),
        itemCount: _controller.moviesCount,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 2,
          childAspectRatio: 0.65,
        ),
        itemBuilder: _buildMovieCard,
      ),
    );
  }

  Widget _buildMovieCard(context, index) {
    final movie = _controller.movies[index];
    return MovieCardWidget(
      movie: movie,
      movieGenres: _controller.movieGenderPoster(movie, widget.genres),
    );
  }
}
