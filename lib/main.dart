import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart';
import 'package:redux/redux.dart';
import 'package:tema5/actions/get_movies.dart';
import 'package:tema5/data/movies_api.dart';
import 'package:tema5/middleware/movies_middleware.dart';
import 'package:tema5/models/app_state.dart';
import 'package:tema5/presentation/home_page.dart';
import 'package:tema5/presentation/movie_details.dart';
import 'package:tema5/reducer/reducer.dart';

void main() {
  final String apiUrl = 'https://yts.mx/api/v2/';

  final Client client = Client();

  final MoviesApi moviesApi = MoviesApi(apiUrl: apiUrl, client: client);

  AppMiddleware appMiddleware = AppMiddleware(moviesApi: moviesApi);

  final Store<AppState> store = Store<AppState>(
    reducer,
    initialState: AppState(),
    middleware: appMiddleware.middleware,
  );

  store.dispatch(GetMovies(store.state.page));

  runApp(YtsApp(store: store));
}

class YtsApp extends StatelessWidget {
  const YtsApp({Key? key, required this.store}) : super(key: key);
  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        home: HomePage(),
        theme: ThemeData.dark(),
        routes: <String, WidgetBuilder>{
          '/details': (BuildContext context) {
            return MovieDetails();
          }
        },
      ),
    );
  }
}