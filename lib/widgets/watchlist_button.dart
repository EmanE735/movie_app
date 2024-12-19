/* -------------------------------------------------------------------------- */
/*                         Import Required Packages                            */
/* -------------------------------------------------------------------------- */
import 'package:flutter/material.dart';
import 'package:movie_app/model/model.dart';
import 'package:movie_app/service/firebase_service.dart';

/* -------------------------------------------------------------------------- */
/*                         Watchlist Button Widget                            */
/* -------------------------------------------------------------------------- */
class WatchlistButton extends StatefulWidget {
  final Movie movie;
  final Color? color;

  const WatchlistButton({
    required this.movie,
    this.color = Colors.white,
    super.key,
  });

  @override
  State<WatchlistButton> createState() => _WatchlistButtonState();
}

/* -------------------------------------------------------------------------- */
/*                         Watchlist Button State                             */
/* -------------------------------------------------------------------------- */
class _WatchlistButtonState extends State<WatchlistButton> {
  late Future<bool> _isInWatchlist;

  /* -------------------------------------------------------------------------- */
  /*                         Initialize State                                   */
  /* -------------------------------------------------------------------------- */
  @override
  void initState() {
    super.initState();
    _isInWatchlist =
        FirebaseService().isInWatchlist(widget.movie.id.toString());
  }

  /* -------------------------------------------------------------------------- */
  /*                         Build Widget                                       */
  /* -------------------------------------------------------------------------- */
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isInWatchlist,
      builder: (context, snapshot) {
        final isInWatchlist = snapshot.data ?? false;

        /* -------------------------------------------------------------------------- */
        /*                         Custom Flag Button                                */
        /* -------------------------------------------------------------------------- */
        return ClipPath(
          clipper: FlagClipper(),
          child: Container(
            width: 30,
            height: 40,
            decoration: BoxDecoration(
              color:
                  isInWatchlist ? Colors.amber : Colors.grey.withOpacity(0.7),
            ),
            /* -------------------------------------------------------------------------- */
            /*                         Watchlist Toggle Button                           */
            /* -------------------------------------------------------------------------- */
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                isInWatchlist ? Icons.check : Icons.add,
                size: 20,
                color: Colors.white,
              ),
              /* -------------------------------------------------------------------------- */
              /*                         Button Action Handler                            */
              /* -------------------------------------------------------------------------- */
              onPressed: () async {
                final service = FirebaseService();

                // Toggle watchlist status
                if (isInWatchlist) {
                  await service.removeFromWatchlist(widget.movie.id.toString());
                } else {
                  await service.addToWatchlist(widget.movie);
                }

                // Update UI if widget is still mounted
                if (mounted) {
                  setState(() {
                    _isInWatchlist =
                        service.isInWatchlist(widget.movie.id.toString());
                  });

                  /* -------------------------------------------------------------------------- */
                  /*                         Feedback Message                                  */
                  /* -------------------------------------------------------------------------- */
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isInWatchlist
                            ? 'Removed from watchlist'
                            : 'Added to watchlist',
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                         Custom Flag Shape Clipper                          */
/* -------------------------------------------------------------------------- */
class FlagClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.8);
    path.lineTo(size.width / 2, size.height); // Triangle tip
    path.lineTo(0, size.height * 0.8);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
