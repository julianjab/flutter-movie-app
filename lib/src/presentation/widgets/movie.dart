import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final dateFormat = DateFormat('dd \'de\' MMMM \'del\' yyyy', 'es_US');

class MovieWidget extends StatelessWidget {
  final String title;
  final String posterImage;
  final String? backdropImage;
  final DateTime? releaseDate;
  final String? overView;
  final Function()? onClick;

  const MovieWidget({
    Key? key,
    required this.title,
    required this.posterImage,
    this.releaseDate,
    this.backdropImage,
    this.overView,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    String formatedDate = 'No disponible';
    if (releaseDate != null) {
      formatedDate = dateFormat.format(releaseDate as DateTime);
    }

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        elevation: 10.0,
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(
                      posterImage,
                      key: const Key('image'),
                      width: MediaQuery.of(context).size.width * .33,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          key: const Key('title'),
                          style: theme.textTheme.headline6,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            formatedDate,
                            key: const Key('releaseDate'),
                            style: theme.textTheme.subtitle2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10.0,
                          ),
                          child: Text(
                            overView ?? '',
                            key: const Key('overview'),
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          onTap: onClick,
        ),
      ),
    );
  }
}
