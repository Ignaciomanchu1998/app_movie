import 'package:app_movie/models/movie.dart';
import 'package:app_movie/theme/app_theme.dart';
import 'package:app_movie/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MovieSliderWidget extends StatefulWidget {
  const MovieSliderWidget({
    Key? key,
    required this.popular,
    required this.onNextPage,
    this.title,
  }) : super(key: key);

  final List<Movie> popular;
  final Function onNextPage;
  final String? title;

  @override
  State<MovieSliderWidget> createState() => _MovieSliderWidgetState();
}

class _MovieSliderWidgetState extends State<MovieSliderWidget> {
  final ScrollController scrollControl = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollControl.addListener(() {
      if (scrollControl.position.pixels >=
          scrollControl.position.maxScrollExtent - 500) {
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: TextSubTitleWidget(
              sms: widget.title ?? "",
              color: AppTheme.primary,
              fontFamily: "Regular",
              fontSize: 20,
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: scrollControl,
              scrollDirection: Axis.horizontal,
              itemCount: 20,
              itemBuilder: (_, int index) => _MoviePoster(
                getMovie: widget.popular[index],
                heroId: "${widget.title}-$index-${widget.popular[index].id}",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  const _MoviePoster({
    Key? key,
    required this.getMovie,
    required this.heroId,
  }) : super(key: key);

  final Movie getMovie;
  final String heroId;

  @override
  Widget build(BuildContext context) {
    getMovie.heroId = heroId;
    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'details', arguments: getMovie);
            },
            child: Hero(
              tag: getMovie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: FadeInImage(
                  placeholder: const AssetImage("assets/images/loading.gif"),
                  image: NetworkImage(getMovie.fullPosterImg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          TextSubTitleWidget(
            sms: getMovie.originalTitle,
            color: AppTheme.primary,
            fontFamily: "Regular",
            fontSize: 12,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
