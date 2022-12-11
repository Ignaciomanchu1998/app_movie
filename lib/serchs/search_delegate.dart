import 'package:app_movie/models/models.dart';
import 'package:app_movie/widgets/text_subtitle_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  // Todo: implement searchFieldLabel
  String get searchFieldLabel => "Buscar película";

  @override
  List<Widget>? buildActions(BuildContext context) {
    // Todo: implement buildActions
    return [
      IconButton(
        onPressed: () => query = "",
        icon: const FaIcon(FontAwesomeIcons.xmark),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // Todo: implement buildLeading
    return IconButton(
      onPressed: () {
        // Todo: aquí se puede retornar lo que sea
        close(context, null);
      },
      icon: const FaIcon(FontAwesomeIcons.arrowLeft),
    );
  }

  Widget _emptyContainer() {
    return const Center(
      child: FaIcon(
        FontAwesomeIcons.clapperboard,
        color: Colors.black26,
        size: 100,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Todo: implement buildResults
    return const Text("buildResults");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Todo: implement buildSuggestions
    if (query.isEmpty) {
      return _emptyContainer();
    }
    // Todo: temas avanzados!

    final movieProvider = Provider.of<MoviesProvider>(context, listen: false);
    movieProvider.getSuggestionByQuery(query);

    return StreamBuilder(
      stream: movieProvider.suggestionStream,
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) {
          return _emptyContainer();
        }

        final List<Movie> movies = snapshot.data!;

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (_, int index) => _MovieItems(getMovies: movies[index]),
        );
      },
    );
  }
}

class _MovieItems extends StatelessWidget {
  const _MovieItems({
    required this.getMovies,
  });

  final Movie getMovies;

  @override
  Widget build(BuildContext context) {
    getMovies.heroId = "search-${getMovies.id}";
    return ListTile(
      leading: Hero(
        tag: getMovies.heroId!,
        child: FadeInImage(
          placeholder: const AssetImage("assets/images/loading.gif"),
          image: NetworkImage(getMovies.fullPosterImg),
          width: 50,
          fit: BoxFit.contain,
        ),
      ),
      title: TextSubTitleWidget(
        sms: getMovies.title,
        color: Colors.black,
        fontFamily: "SemiBold",
        fontSize: 15,
      ),
      subtitle: TextSubTitleWidget(
        sms: getMovies.originalTitle,
        color: Colors.black38,
        fontFamily: "Regular",
        fontSize: 12,
      ),
      onTap: () {
        Navigator.pushNamed(context, "details", arguments: getMovies);
      },
    );
  }
}
