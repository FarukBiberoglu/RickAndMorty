
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:untitled15/views/characters_view/characters_view.dart';
import '../models/characters_model.dart';
import '../models/episode_model.dart';
import '../models/location_model.dart';
import '../views/app_view.dart';
import '../views/character_profile_view/character_profile_view.dart';
import '../views/character_profile_view/character_profile_viewmodel.dart';
import '../views/characters_view/characters_viewmodel.dart';
import '../views/favourites_view/favourites_view.dart';
import '../views/favourites_view/favourites_viewmodel.dart';
import '../views/locations_view/location_viewmodel.dart';
import '../views/locations_view/locations_view.dart';
import '../views/residents_view/resident_view.dart';
import '../views/residents_view/resident_viewmodel.dart';
import '../views/section_characters_view/section_characters_view.dart';
import '../views/section_characters_view/section_characters_viewmodel.dart';
import '../views/sections_view/sections_view.dart';
import '../views/sections_view/sections_viewmodel.dart';
import '../views/settings_view/settings_view.dart';
import '../views/settings_view/settings_viewmodel.dart';

final _routerKey = GlobalKey<NavigatorState>();
final _shellNavigatorCharactersKey =
GlobalKey<NavigatorState>(debugLabel: 'shellCharacters');
final _shellNavigatorFavouritesKey =
GlobalKey<NavigatorState>(debugLabel: 'shellFavourites');
final _shellNavigatorLocationsKey =
GlobalKey<NavigatorState>(debugLabel: 'shellLocations');
final _shellNavigatorSectionsKey =
GlobalKey<NavigatorState>(debugLabel: 'shellSections');

class AppRoutes {
  AppRoutes._();

  static const String characters = '/';
  static const String favourites = '/favourites';
  static const String locations = '/locations';
  static const String sections = '/sections';
  static const String settings = '/settings';

  static const String profileRoute = 'characterProfile';
  static const String characterProfile = '/characterProfile';

  static const String residentsRoute = 'residents';
  static const String residents = '/locations/residents';

  static const String sectionCharactersRoute = 'characters';
  static const String sectionCharacters = '/sections/characters';
}

final router = GoRouter(
  navigatorKey: _routerKey,
  initialLocation: AppRoutes.characters,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppView(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorCharactersKey,
          routes: [
            GoRoute(
              path: AppRoutes.characters,
              builder: (context, state) => ChangeNotifierProvider(
                create: (context) => CharactersViewmodel(),
                child: const CharactersView(),
              ),
              routes: [
                GoRoute(
                  path: AppRoutes.profileRoute,
                  builder: (context, state) => ChangeNotifierProvider(
                    create: (context) => CharacterProfileViewmodel(),
                    child: CharacterProfileView(
                      characterModel: state.extra as CharacterModel,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorFavouritesKey,
          routes: [
            GoRoute(
              path: AppRoutes.favourites,
              builder: (context, state) => ChangeNotifierProvider(
                create: (context) => FavouritesViewmodel(),
                child: const FavouritesView(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorLocationsKey,
          routes: [
            GoRoute(
              path: AppRoutes.locations,
              builder: (context, state) => ChangeNotifierProvider(
                create: (context) => LocationViewmodel(),
                child: const LocationsView(),
              ),
              routes: [
                GoRoute(
                  path: AppRoutes.residentsRoute,
                  builder: (context, state) => ChangeNotifierProvider(
                    create: (context) => ResidentViewmodel(),
                    child: ResidentsView(
                      locationItem: state.extra as LocationItem,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorSectionsKey,
          routes: [
            GoRoute(
              path: AppRoutes.sections,
              builder: (context, state) => ChangeNotifierProvider(
                create: (context) => SectionsViewmodel(),
                child: const SectionsView(),
              ),
              routes: [
                GoRoute(
                  path: AppRoutes.sectionCharactersRoute,
                  builder: (context, state) => ChangeNotifierProvider(
                    create: (context) => SectionCharactersViewmodel(),
                    child: SectionCharactersView(
                      episodeModel: state.extra as EpisodeModel,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.settings,
      builder: (context, state) => ChangeNotifierProvider(
        create: (context) => SettingsViewmodel(),
        child: const SettingsView(),
      ),
    ),
  ],
);
