import 'package:app_movie/models/models.dart';
import 'package:app_movie/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Todo: Agregar param enviado desde la otra vista.
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Todo: Header sliver
          _SliverAppBar(headerMovie: movie),

          // Todo: Body sliver
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _PosterAndTitle(posterAndTitleMovie: movie),
                _OverView(overview: movie),
                CastingCard(movieId: movie.id),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Todo: Header sliver
class _SliverAppBar extends StatelessWidget {
  const _SliverAppBar({
    Key? key,
    required this.headerMovie,
  }) : super(key: key);

  final Movie headerMovie;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 10),
          color: Colors.black12,
          child: TextSubTitleWidget(
            sms: headerMovie.title,
            color: Colors.white,
            fontFamily: "SemiBold",
            fontSize: 16,
            align: TextAlign.center,
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage("assets/images/loading.gif"),
          image: NetworkImage(headerMovie.fullBackdropPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

// Todo: Body sliver
class _PosterAndTitle extends StatelessWidget {
  const _PosterAndTitle({
    Key? key,
    required this.posterAndTitleMovie,
  }) : super(key: key);

  final Movie posterAndTitleMovie;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: posterAndTitleMovie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage("assets/images/loading.gif"),
                image: NetworkImage(posterAndTitleMovie.fullPosterImg),
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 20),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextSubTitleWidget(
                  sms: posterAndTitleMovie.title,
                  color: Colors.black,
                  fontFamily: "SemiBold",
                  fontSize: 20,
                  maxLines: 2,
                ),
                TextSubTitleWidget(
                  sms: posterAndTitleMovie.originalTitle,
                  color: Colors.black,
                  fontFamily: "Regular",
                  fontSize: 18,
                ),
                Row(
                  children: [
                    const FaIcon(FontAwesomeIcons.star),
                    const SizedBox(width: 5),
                    TextSubTitleWidget(
                      sms: posterAndTitleMovie.voteAverage.toString(),
                      color: Colors.black,
                      fontFamily: "Regular",
                      fontSize: 15,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Todo: Description sliver
class _OverView extends StatelessWidget {
  const _OverView({
    Key? key,
    required this.overview,
  }) : super(key: key);

  final Movie overview;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextBodyWidget(
        sms: overview.overview,
        color: Colors.black,
        fontFamily: "Regular",
        fontSize: 15,
        align: TextAlign.justify,
      ),
    );
  }
}
