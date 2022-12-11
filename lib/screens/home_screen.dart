import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:app_movie/theme/app_theme.dart';
import 'package:app_movie/widgets/widgets.dart';
import 'package:provider/provider.dart';


import '../providers/providers.dart';
import '../serchs/search.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MoviesProvider>(context);
    return Scaffold(
      backgroundColor: AppTheme.screen,
      appBar: AppBar(
        title: const TextTitleWidget(
          sms: "Películas en cines",
          color: AppTheme.primary,
          fontFamily: 'SemiBold',
          fontSize: 22,
        ),
        actions: [
          IconButton(
            onPressed: () =>
                showSearch(context: context, delegate: MovieSearchDelegate()),
            icon: const FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              color: AppTheme.primary,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CardSwiperWidget(movies: movieProvider.getMovies),

            // List movie
            if (movieProvider.popularMovies.isNotEmpty)
              MovieSliderWidget(
                popular: movieProvider.popularMovies,
                onNextPage: () => movieProvider.getPopularMovies(),
                title: "Populares",
              ),
          ],
        ),
      ),
    );
  }
}
