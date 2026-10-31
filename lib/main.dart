import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'trailer_embed.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await preferences.load();
  runApp(const MyApp());
}

const background = Color(0xFF080C17);
const muted = Color(0xFF9DA7B9);
const accent = Color(0xFF32E0CD);

// Listas y Mapas: una fuente local compartida por las pantallas.
const movies = <Map<String, String>>[
  {
    'id': 'moana',
    'title': 'Moana 2',
    'studio': 'Disney',
    'year': '2024',
    'genre': 'Aventura · Animación',
    'description': 'Un llamado de sus ancestros lleva a Moana y Maui a navegar hacia mares lejanos en una nueva aventura junto a una tripulación inesperada.',
  },
  {
    'id': 'insideout',
    'title': 'Intensamente 2',
    'studio': 'Pixar',
    'year': '2024',
    'genre': 'Familia · Comedia',
    'description': 'Riley llega a la adolescencia y nuevas emociones aparecen en el cuartel general. Alegría y sus amigos deben aprender a compartir su mundo.',
  },
  {
    'id': 'encanto',
    'title': 'Encanto',
    'studio': 'Disney',
    'year': '2021',
    'genre': 'Musical · Familia',
    'description': 'Mirabel es la única integrante de su familia sin un don mágico. Cuando la magia de su hogar está en peligro, ella podría ser su última esperanza.',
  },
  {
    'id': 'zootopia',
    'title': 'Zootopia',
    'studio': 'Disney',
    'year': '2016',
    'genre': 'Aventura · Comedia',
    'description': 'Una coneja policía y un astuto zorro forman una pareja inesperada para resolver un misterio en una ciudad llena de posibilidades.',
  },
  {
    'id': 'luca',
    'title': 'Luca',
    'studio': 'Pixar',
    'year': '2021',
    'genre': 'Amistad · Aventura',
    'description': 'Un verano inolvidable en la Riviera italiana une a dos amigos que comparten un secreto extraordinario bajo el mar.',
  },
  {
    'id': 'soul',
    'title': 'Soul',
    'studio': 'Pixar',
    'year': '2020',
    'genre': 'Música · Animación',
    'description': 'Un músico de jazz descubre una nueva perspectiva sobre la vida y las pequeñas cosas que la hacen especial.',
  },
  {
    "id": "lionking",
    "title": "El rey león",
    "studio": "Disney",
    "year": "1994",
    "genre": "Aventura · Musical",
    "description": "Simba debe encontrar su lugar en el ciclo de la vida y recuperar el legado de su padre.",
  },
  {
    "id": "frozen",
    "title": "Frozen",
    "studio": "Disney",
    "year": "2013",
    "genre": "Musical · Aventura",
    "description": "Anna emprende un viaje junto a Kristoff y Olaf para encontrar a su hermana Elsa y devolver el verano a Arendelle.",
  },
  {
    "id": "toystory",
    "title": "Toy Story",
    "studio": "Pixar",
    "year": "1995",
    "genre": "Familia · Aventura",
    "description": "La llegada de Buzz Lightyear transforma el mundo de Woody y los juguetes de Andy.",
  },
  {
    "id": "nemo",
    "title": "Buscando a Nemo",
    "studio": "Pixar",
    "year": "2003",
    "genre": "Océano · Aventura",
    "description":
        "Marlin y Dory cruzan el océano para encontrar al pequeño Nemo.",
  },
  {
    "id": "beauty",
    "title": "La bella y la bestia",
    "studio": "Disney",
    "year": "1991",
    "genre": "Romance · Musical",
    "description": "Bella descubre que la magia más extraordinaria se encuentra más allá de las apariencias.",
  },
  {
    "id": "coco",
    "title": "Coco",
    "studio": "Pixar",
    "year": "2017",
    "genre": "Música · Familia",
    "description": "Miguel cruza a la Tierra de los Muertos para descubrir la historia de su familia y seguir su pasión por la música.",
  },
  {
    "id": "incredibles",
    "title": "Los increíbles",
    "studio": "Pixar",
    "year": "2004",
    "genre": "Acción · Familia",
    "description": "Una familia de superhéroes vuelve a la acción y descubre que su mayor poder es permanecer unida.",
  },
  {
    "id": "ratatouille",
    "title": "Ratatouille",
    "studio": "Pixar",
    "year": "2007",
    "genre": "Comedia · Cocina",
    "description": "Remy sueña con convertirse en chef en París y encuentra un aliado inesperado en una cocina profesional.",
  },
  {
    "id": "up",
    "title": "Up: una aventura de altura",
    "studio": "Pixar",
    "year": "2009",
    "genre": "Aventura · Amistad",
    "description": "Carl convierte su casa en una aeronave de globos y viaja con un pequeño explorador hacia una aventura extraordinaria.",
  },
  {
    "id": "tangled",
    "title": "Enredados",
    "studio": "Disney",
    "year": "2010",
    "genre": "Musical · Aventura",
    "description": "Rapunzel abandona su torre para descubrir las luces flotantes y conocer el mundo junto a Flynn Rider.",
  },
  {
    "id": "walle",
    "title": "WALL·E",
    "studio": "Pixar",
    "year": "2008",
    "genre": "Ciencia ficción · Romance",
    "description": "Un pequeño robot que limpia la Tierra encuentra una nueva misión cuando conoce a EVA.",
  },
  {
    "id": "endgame",
    "title": "Avengers: Endgame",
    "studio": "Marvel",
    "year": "2019",
    "genre": "Acción · Superhéroes",
    "description": "Los Vengadores se reúnen para una última misión que decidirá el destino del universo.",
    "rating": "13+",
  },
  {
    "id": "blackpanther",
    "title": "Black Panther",
    "studio": "Marvel",
    "year": "2018",
    "genre": "Acción · Aventura",
    "description": "T’Challa regresa a Wakanda para asumir el trono y proteger a su pueblo ante una nueva amenaza.",
    "rating": "13+",
  },
  {
    "id": "captainmarvel",
    "title": "Capitana Marvel",
    "studio": "Marvel",
    "year": "2019",
    "genre": "Acción · Ciencia ficción",
    "description": "Carol Danvers descubre su pasado y su extraordinario poder en medio de un conflicto galáctico.",
    "rating": "13+",
  },
  {
    "id": "pirates",
    "title": "Piratas del Caribe",
    "studio": "Disney",
    "year": "2003",
    "genre": "Acción · Aventura",
    "description": "Jack Sparrow y Will Turner se embarcan en una peligrosa travesía contra una tripulación maldita.",
    "rating": "13+",
  },
  {
    "id": "rogueone",
    "title": "Rogue One: una historia de Star Wars",
    "studio": "Star Wars",
    "year": "2016",
    "genre": "Acción · Ciencia ficción",
    "description": "Un grupo de rebeldes emprende una misión para robar los planos de la Estrella de la Muerte.",
    "rating": "13+",
  },
  {
    "id": "junglebook",
    "title": "El libro de la selva",
    "studio": "Disney",
    "year": "2016",
    "genre": "Acción · Aventura",
    "description": "Mowgli se enfrenta a nuevos peligros en la selva con la ayuda de Bagheera y Baloo.",
    "rating": "9+",
  },
];

const trailerUrls = <String, String>{
  "moana": "https://secure.disney.com/embed/61f4bc35ea7c5dea2c651fcc?domain=video.disney.com",
  "insideout": "https://secure.disney.com/embed/61f2dc47b33ccdeacd351fcc?domain=video.disney.com",
  "encanto": "https://secure.disney.com/embed/5cd227e2fc288ebd6b4f2a72?domain=video.disney.com",
  "zootopia": "https://secure.disney.com/embed/531679143431a30118e2b3c7?domain=video.disney.com",
  "luca": "https://secure.disney.com/embed/5c10817bdff5debd6b4f2a72?domain=video.disney.com",
  "soul": "https://secure.disney.com/embed/5b1aa885f9dd1ebd6b4f2a72?domain=video.disney.com",
  "lionking": "https://secure.disney.com/embed/579b5be6b2980c85c6be499e?domain=video.disney.com",
  "frozen": "https://secure.disney.com/embed/4efa2d8359d0874d5702ee4d?domain=video.disney.com",
  "toystory": "https://secure.disney.com/embed/4bd800172718893a6ac45c67?domain=video.disney.com",
  "nemo": "https://secure.disney.com/embed/54895f79c9fb6fbe3c75ea63?domain=video.disney.com",
  "beauty": "https://secure.disney.com/embed/547a4ba31401a5f09a0fb097?domain=video.disney.com",
  "coco": "https://secure.disney.com/embed/56272aa0eddd0db78706b625?domain=video.disney.com",
  "incredibles": "https://secure.disney.com/embed/4be10336187da49519ec4e85?domain=video.disney.com",
  "ratatouille": "https://secure.disney.com/embed/548985412be9afbe3c75ea63?domain=video.disney.com",
  "up": "https://secure.disney.com/embed/548991c6e2f5afbe3c75ea63?domain=video.disney.com",
  "tangled": "https://secure.disney.com/embed/4be10fd66f75942f7f3ce022?domain=video.disney.com",
  "walle": "https://secure.disney.com/embed/4bd8003e33ca293a6ac45c67?domain=video.disney.com",
  "endgame": "https://secure.disney.com/embed/5840cf6e5b0ccebd6b4f2a72?domain=video.disney.com",
  "blackpanther": "https://secure.disney.com/embed/56b5689c28f4ee5e698e03fd?domain=video.disney.com",
  "captainmarvel": "https://secure.disney.com/embed/57624cdd54c4786c0e7eed34?domain=video.disney.com",
  "pirates": "https://secure.disney.com/embed/4bcd1e927ad4e5d339e69f42?domain=video.disney.com",
  "rogueone": "https://secure.disney.com/embed/53ec6724dcd393709056807f?domain=video.disney.com",
  "junglebook": "https://secure.disney.com/embed/536ecc1e7d1a1fdbe23921b5?domain=video.disney.com",
};

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: preferences,
    builder: (context, _) => MaterialApp(
      title: 'Disney+ · Experiencia móvil',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        platform: TargetPlatform.iOS,
        iconTheme: const IconThemeData(size: 21, color: Color(0xFFEAF1F7)),
        scaffoldBackgroundColor: background,
        colorScheme: const ColorScheme.dark(
          primary: accent,
          surface: Color(0xFF151D2E),
        ),
        fontFamily: 'Outfit',
        dividerColor: Colors.white12,
        appBarTheme: const AppBarTheme(
          backgroundColor: background,
          centerTitle: false,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: accent,
            foregroundColor: background,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
          ),
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFF172033),
          elevation: 0,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          disableAnimations:
              preferences.reduceMotion ||
              MediaQuery.disableAnimationsOf(context),
        ),
        child: PhoneFrame(child: child!),
      ),
      home: const StreamingApp(),
      onGenerateRoute: (route) {
        final uri = Uri.tryParse(route.name ?? '/');
        if (uri == null) return null;
        if (uri.path == '/football') {
          return MaterialPageRoute<void>(
            settings: route,
            builder: (_) => const FootballPage(),
          );
        }
        final parts = uri.pathSegments;
        if (parts.length == 2 &&
            (parts.first == 'title' || parts.first == 'trailer')) {
          final matches = movies.where((movie) => movie['id'] == parts.last);
          if (matches.isEmpty) return null;
          final movie = matches.first;
          return MaterialPageRoute<void>(
            settings: route,
            builder: (_) => parts.first == 'trailer'
                ? TrailerPage(movie: movie)
                : DetailPage(
                    movie: movie,
                    isSaved: preferences.saved.contains(movie['id']),
                    onSave: () => preferences.toggleFavorite(movie['id']!),
                  ),
          );
        }
        return null;
      },
    ),
  );
}

class PhoneFrame extends StatelessWidget {
  final Widget child;
  const PhoneFrame({super.key, required this.child});
  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      if (constraints.maxWidth < 600) return child;
      final height = (constraints.maxHeight - 40).clamp(360.0, 850.0);
      return ColoredBox(
        color: const Color(0xFF060A12),
        child: Stack(
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF19293A).withValues(alpha: .45),
                      const Color(0xFF060A12),
                    ],
                    radius: .8,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                width: 400,
                height: height,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF555F6A),
                      Color(0xFF151A21),
                      Color(0xFF353E49),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(46),
                  border: Border.all(
                    color: const Color(0xFF586471),
                    width: 1.5,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black87,
                      blurRadius: 60,
                      offset: Offset(0, 24),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(36),
                  child: Column(
                    children: [
                      Container(
                        color: background,
                        height: 32,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '9:41',
                              style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.none,
                                fontFamily: 'Outfit',
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 80,
                              height: 20,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  CupertinoIcons.chart_bar_alt_fill,
                                  size: 13,
                                ),
                                SizedBox(width: 5),
                                Icon(CupertinoIcons.wifi, size: 13),
                                SizedBox(width: 5),
                                Icon(CupertinoIcons.battery_100, size: 16),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(size: Size(385, height - 62)),
                          child: child,
                        ),
                      ),
                      Container(
                        height: 17,
                        color: background,
                        alignment: Alignment.center,
                        child: Container(
                          width: 110,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

class StreamingApp extends StatefulWidget {
  const StreamingApp({super.key});
  @override
  State<StreamingApp> createState() => _StreamingAppState();
}

class _StreamingAppState extends State<StreamingApp>
    with WidgetsBindingObserver {
  int tab = 0;
  int featured = 0;
  String query = '';
  String category = 'Para ti';
  final saved = preferences.saved;
  final featuredController = PageController(viewportFraction: .94);
  Timer? carouselTimer;
  bool foreground = true;
  List<Map<String, String>> get featuredMovies {
    final ids = switch (category) {
      'Pixar' => ['coco', 'insideout', 'luca', 'soul'],
      'Clásicos' => ['lionking', 'toystory', 'nemo', 'ratatouille'],
      _ => ['endgame', 'blackpanther', 'rogueone', 'captainmarvel'],
    };
    return ids
        .map((id) => movies.firstWhere((movie) => movie['id'] == id))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    preferences.addListener(configureCarousel);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    configureCarousel();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    foreground = state == AppLifecycleState.resumed;
    configureCarousel();
  }

  void configureCarousel() {
    carouselTimer?.cancel();
    if (!mounted ||
        !foreground ||
        preferences.reduceMotion ||
        MediaQuery.disableAnimationsOf(context)) {
      return;
    }
    carouselTimer = Timer.periodic(const Duration(seconds: 6), (_) {
      if (!mounted ||
          tab != 0 ||
          !foreground ||
          ModalRoute.of(context)?.isCurrent != true ||
          !featuredController.hasClients ||
          featuredController.position.isScrollingNotifier.value) {
        return;
      }
      featuredController.animateToPage(
        (featured + 1) % featuredMovies.length,
        duration: const Duration(milliseconds: 850),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  void dispose() {
    carouselTimer?.cancel();
    preferences.removeListener(configureCarousel);
    WidgetsBinding.instance.removeObserver(this);
    featuredController.dispose();
    super.dispose();
  }

  void toggleSaved(String id) {
    preferences.toggleFavorite(id);
  }

  void openCollection(String title, List<Map<String, String>> items) =>
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) =>
              CollectionPage(title: title, items: items, onSelect: details),
        ),
      );
  void openSports() => Navigator.of(context).push(
    MaterialPageRoute<void>(
      settings: const RouteSettings(name: '/football'),
      builder: (_) => const FootballPage(),
    ),
  );
  void chooseBrand(String title) {
    if (title == 'NAT GEO') {
      Navigator.of(context)
          .push(MaterialPageRoute<void>(builder: (_) => const NaturePage()));
      return;
    }
    final studio = title == 'PIXAR'
        ? 'Pixar'
        : title == 'MARVEL'
        ? 'Marvel'
        : title.contains('STAR')
        ? 'Star Wars'
        : 'Disney';
    openCollection(
      'Universo $studio',
      movies.where((m) => m['studio'] == studio).toList(),
    );
  }

  void details(Map<String, String> movie) => Navigator.of(context).push(
    PageRouteBuilder<void>(
      transitionDuration: const Duration(milliseconds: 420),
      reverseTransitionDuration: const Duration(milliseconds: 280),
      transitionsBuilder: (context, animation, secondary, child) =>
          MediaQuery.disableAnimationsOf(context)
          ? child
          : FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween(begin: const Offset(0, .06), end: Offset.zero)
                    .animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOutCubic,
                      ),
                    ),
                child: child,
              ),
            ),
      settings: RouteSettings(name: '/title/${movie['id']}'),
      pageBuilder: (_, animation, secondary) => DetailPage(
        movie: movie,
        isSaved: saved.contains(movie['id']),
        onSave: () {
          toggleSaved(movie['id']!);
        },
      ),
    ),
  );
  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: preferences,
    builder: (context, _) => Scaffold(
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: MediaQuery.disableAnimationsOf(context)
              ? Duration.zero
              : const Duration(milliseconds: 300),
          child: KeyedSubtree(
            key: ValueKey(tab),
            child: switch (tab) {
              0 => home(),
              1 => search(),
              2 => collection(),
              _ => profile(),
            },
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        height: 60,
        backgroundColor: const Color(0xFF080D18),
        indicatorColor: const Color(0xFF183F42),
        selectedIndex: tab,
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => TextStyle(
            fontSize: 10,
            color: states.contains(WidgetState.selected) ? Colors.white : muted,
          ),
        ),
        onDestinationSelected: (value) => setState(() => tab = value),
        destinations: [
          NavigationDestination(
            icon: Icon(CupertinoIcons.house, color: muted),
            selectedIcon: Icon(CupertinoIcons.house_fill, color: Colors.white),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(CupertinoIcons.search, color: muted),
            selectedIcon: Icon(CupertinoIcons.search, color: Colors.white),
            label: 'Buscar',
          ),
          NavigationDestination(
            icon: Icon(CupertinoIcons.bookmark, color: muted),
            selectedIcon: Icon(
              CupertinoIcons.bookmark_fill,
              color: Colors.white,
            ),
            label: 'Mi lista',
          ),
          NavigationDestination(
            icon: CircleAvatar(
              radius: 12,
              backgroundColor: Color(0xFF146B87),
              child: Text(
                preferences.name.characters.first.toUpperCase(),
                style: const TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
            label: 'Perfil',
          ),
        ],
      ),
    ),
  );
  Widget home() => ListView(
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 12, 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const BrandLogo(brand: 'Disney+', width: 87, height: 43),
            IconButton(
              tooltip: 'Mi perfil',
              onPressed: () => setState(() => tab = 3),
              icon: const Icon(CupertinoIcons.person_crop_circle, size: 25),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 43,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: ['Para ti', 'Acción', 'Fútbol', 'Clásicos', 'Pixar']
              .map(
                (name) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(
                      name,
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    selected: category == name,
                    showCheckmark: false,
                    selectedColor: const Color(0xFF284451),
                    backgroundColor: background,
                    side: BorderSide(
                      color: category == name
                          ? accent.withValues(alpha: .6)
                          : Colors.white24,
                    ),
                    onSelected: (_) {
                      if (name == 'Fútbol') {
                        openSports();
                      } else {
                        setState(() => category = name);
                      }
                    },
                  ),
                ),
              )
              .toList(),
        ),
      ),
      const SizedBox(height: 12),
      SizedBox(
        height: 292,
        child: PageView.builder(
          controller: featuredController,
          itemCount: 4,
          onPageChanged: (value) => setState(() => featured = value),
          itemBuilder: (_, index) => featuredCard(featuredMovies[index]),
        ),
      ),
      const SizedBox(height: 2),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          4,
          (index) => Semantics(
            label: 'Destacado ${index + 1}',
            button: true,
            child: InkWell(
              onTap: () => featuredController.animateToPage(
                index,
                duration: MediaQuery.disableAnimationsOf(context)
                    ? Duration.zero
                    : const Duration(milliseconds: 450),
                curve: Curves.easeOutCubic,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 3,
                ),
                child: Dot(active: index == featured),
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(18, 4, 18, 18),
        child: Row(
          children: [
            brand('Disney'),
            brand('PIXAR'),
            brand('MARVEL'),
            brand('STAR\nWARS'),
            brand('NAT GEO'),
          ],
        ),
      ),
      if (category == 'Para ti' || category == 'Acción')
        rail(
          'Acción sin límites',
          movies.where((m) => m['genre']!.contains('Acción')).toList(),
        ),
      if (category == 'Para ti') popularRail(),
      if (category == 'Para ti') footballBanner(),
      if (category == 'Para ti' || category == 'Clásicos')
        rail(
          'Clásicos que viven para siempre',
          movies.where((m) => int.parse(m['year']!) < 2011).toList(),
        ),
      rail(
        category == 'Pixar'
            ? 'El universo Pixar'
            : category == 'Acción'
            ? 'Héroes y aventuras'
            : 'Hechas para volver a ver',
        category == 'Pixar'
            ? movies.where((m) => m['studio'] == 'Pixar').toList()
            : category == 'Acción'
            ? movies.where((m) => m['genre']!.contains('Acción')).toList()
            : category == 'Clásicos'
            ? movies.where((m) => int.parse(m['year']!) < 2011).toList()
            : movies,
      ),
      if (category != 'Acción')
        rail(
          'Música, magia y grandes historias',
          movies
              .where(
                (m) =>
                    m['genre']!.contains('Musical') ||
                    m['genre']!.contains('Música'),
              )
              .toList(),
        ),
      const Padding(
        padding: EdgeInsets.all(22),
        child: Text(
          'Proyecto educativo · Interfaz de demostración\nSin conexión al servicio Disney+',
          textAlign: TextAlign.center,
          style: TextStyle(color: muted, fontSize: 10, height: 1.7),
        ),
      ),
    ],
  );
  Widget featuredCard(Map<String, String> movie) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: AnimatedBuilder(
      animation: featuredController,
      builder: (context, child) {
        final index = featuredMovies.indexWhere((m) => m['id'] == movie['id']);
        final page =
            featuredController.hasClients &&
                featuredController.position.hasContentDimensions
            ? featuredController.page ?? featured.toDouble()
            : featured.toDouble();
        final distance = (page - index).abs().clamp(0.0, 1.0);
        return Transform.scale(scale: 1 - distance * .035, child: child);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/${movie['id']}${['endgame', 'rogueone'].contains(movie['id']) ? '_hero' : ''}.jpg',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              errorBuilder: (_, error, stack) => Image.asset(
                'assets/images/${movie['id']}.jpg',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0, .3, .66, 1],
                  colors: [
                    Color(0x22080C17),
                    Colors.transparent,
                    Color(0xB3080C17),
                    background,
                  ],
                ),
              ),
            ),
            const Positioned(
              top: 15,
              left: 16,
              child: Text(
                'PELÍCULA DESTACADA',
                style: TextStyle(
                  fontSize: 8,
                  letterSpacing: 1.8,
                  fontWeight: FontWeight.w600,
                  color: Colors.white70,
                ),
              ),
            ),
            Positioned(
              left: 17,
              right: 17,
              bottom: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BrandLogo(brand: movie['studio']!, width: 74, height: 20),
                  const SizedBox(height: 8),
                  Text(
                    movie['title']!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 25,
                      height: 1.08,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -.6,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    '${movie['year']}  ·  ${movie['genre']}',
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFFCBD1DC),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: Tooltip(
                          message: 'Ver tráiler de ${movie['title']}',
                          child: FilledButton.icon(
                            onPressed: () => openTrailer(context, movie),
                            icon: const Icon(
                              CupertinoIcons.play_fill,
                              size: 13,
                            ),
                            label: const Text(
                              'Ver tráiler',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: background,
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton.outlined(
                        tooltip: 'Ver detalles de ${movie['title']}',
                        onPressed: () => details(movie),
                        icon: const Icon(CupertinoIcons.info, size: 19),
                        style: IconButton.styleFrom(
                          side: const BorderSide(color: Colors.white38),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
  Widget popularRail() {
    final popular = [
      movies[1],
      movies[0],
      movies[3],
      movies[8],
      movies[11],
      movies[7],
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 4, 20, 14),
          child: Row(
            children: [
              Text(
                'POPULARES',
                style: TextStyle(
                  color: accent,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2.5,
                ),
              ),
              SizedBox(width: 9),
              Expanded(child: Divider()),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20, bottom: 12),
          child: Text(
            'Grandes favoritas',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w700,
              letterSpacing: -.5,
            ),
          ),
        ),
        SizedBox(
          height: 210,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            itemCount: popular.length,
            separatorBuilder: (_, index) => const SizedBox(width: 10),
            itemBuilder: (_, index) => SizedBox(
              width: 143,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    bottom: 20,
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        fontSize: 90,
                        height: 1,
                        fontWeight: FontWeight.w900,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 1.5
                          ..color = const Color(0xFF78949E),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 28,
                    right: 0,
                    top: 0,
                    child: poster(popular[index]),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget brand(String title) => Expanded(
    child: InkWell(
      key: ValueKey('brand-$title'),
      onTap: () => chooseBrand(title),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 45,
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF263247), Color(0xFF131B2A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.white12),
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 8),
          child: BrandLogo(brand: title, width: 65, height: 30),
        ),
      ),
    ),
  );
  Widget rail(String title, List<Map<String, String>> items) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              tooltip: 'Ver todo: $title',
              onPressed: () => openCollection(title, items),
              icon: const Icon(
                CupertinoIcons.arrow_right,
                size: 18,
                color: accent,
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 193,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: items.length,
          separatorBuilder: (_, index) => const SizedBox(width: 10),
          itemBuilder: (_, index) =>
              SizedBox(width: 112, child: poster(items[index])),
        ),
      ),
      const SizedBox(height: 23),
    ],
  );
  Widget poster(Map<String, String> movie) => MotionCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          margin: EdgeInsets.zero,
          child: InkWell(
            onTap: () => details(movie),
            child: AspectRatio(
              aspectRatio: 2 / 3,
              child: Image.asset(
                'assets/images/${movie['id']}.jpg',
                fit: BoxFit.cover,
                semanticLabel: movie['title'],
              ),
            ),
          ),
        ),
        const SizedBox(height: 7),
        Text(
          movie['title']!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 11, color: muted),
        ),
      ],
    ),
  );
  Widget search() {
    final results = movies
        .where(
          (m) => '${m['title']} ${m['studio']} ${m['genre']}'
              .toLowerCase()
              .contains(query.toLowerCase()),
        )
        .toList();
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Buscar',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        TextField(
          onChanged: (value) => setState(() => query = value),
          decoration: InputDecoration(
            hintText: 'Películas, personajes y mucho más',
            hintStyle: const TextStyle(fontSize: 12),
            prefixIcon: const Icon(CupertinoIcons.search),
            filled: true,
            fillColor: const Color(0xFF202B3E),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 25),
        Text(
          query.isEmpty
              ? 'Explora nuestras películas'
              : '${results.length} resultados',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        if (results.isEmpty)
          const Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              'No encontramos ese título. Prueba con Disney o Pixar.',
              style: TextStyle(color: muted),
            ),
          ),
        ...results.map(
          (m) => ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 7),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                'assets/images/${m['id']}.jpg',
                width: 42,
                height: 62,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(m['title']!),
            subtitle: Text(
              '${m['year']} · ${m['studio']}',
              style: const TextStyle(color: muted, fontSize: 12),
            ),
            trailing: const Icon(CupertinoIcons.chevron_right),
            onTap: () => details(m),
          ),
        ),
      ],
    );
  }

  Widget collection() => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      const Text(
        'Mi lista',
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
      Text(
        '${saved.length} títulos guardados',
        style: const TextStyle(color: muted),
      ),
      const SizedBox(height: 25),
      if (saved.isEmpty)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 70),
          child: Column(
            children: [
              const Icon(CupertinoIcons.bookmark_fill, size: 55, color: muted),
              const SizedBox(height: 18),
              const Text(
                'Tus favoritos, en un solo lugar',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Toca + en una película para guardarla aquí.',
                style: TextStyle(color: muted, fontSize: 12),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                onPressed: () => setState(() => tab = 0),
                child: const Text('Explorar películas'),
              ),
            ],
          ),
        ),
      Wrap(
        spacing: 12,
        runSpacing: 16,
        children: movies
            .where((m) => saved.contains(m['id']))
            .map((m) => SizedBox(width: 100, child: poster(m)))
            .toList(),
      ),
    ],
  );
  Widget profile() => ListView(
    padding: const EdgeInsets.all(22),
    children: [
      const SizedBox(height: 20),
      Center(
        child: CircleAvatar(
          radius: 42,
          backgroundColor: const Color(0xFF146B87),
          child: Text(
            preferences.name.characters.first.toUpperCase(),
            style: const TextStyle(fontSize: 36, color: Colors.white),
          ),
        ),
      ),
      const SizedBox(height: 14),
      Center(
        child: Text(
          preferences.name,
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),
      Center(
        child: TextButton.icon(
          onPressed: editProfile,
          icon: const Icon(CupertinoIcons.pencil, size: 14),
          label: const Text('Editar perfil'),
        ),
      ),
      const SizedBox(height: 20),
      ListTile(
        leading: const Icon(CupertinoIcons.bookmark),
        title: const Text('Mi lista'),
        trailing: const Icon(CupertinoIcons.chevron_right),
        onTap: () => setState(() => tab = 2),
      ),
      ListTile(
        leading: const Icon(CupertinoIcons.film),
        title: const Text('Explorar catálogo'),
        trailing: const Icon(CupertinoIcons.chevron_right),
        onTap: () => setState(() => tab = 1),
      ),
      ListTile(
        leading: const Icon(Icons.sports_soccer),
        title: const Text('Fútbol y transmisiones'),
        trailing: const Icon(CupertinoIcons.chevron_right),
        onTap: openSports,
      ),
      const Divider(),
      SwitchListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        secondary: const Icon(CupertinoIcons.slider_horizontal_3),
        title: const Text('Animaciones'),
        subtitle: const Text(
          'Transiciones y efectos de movimiento',
          style: TextStyle(fontSize: 11, color: muted),
        ),
        value: !preferences.reduceMotion,
        onChanged: (value) => preferences.update(reduceMotion: !value),
      ),
      const Divider(),
      ListTile(
        leading: const Icon(CupertinoIcons.info_circle),
        title: const Text('Acerca de esta experiencia'),
        trailing: const Icon(CupertinoIcons.chevron_right),
        onTap: () => showDialog<void>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Una experiencia de cine'),
            content: const Text(
              'Catálogo educativo en español con tráileres oficiales. Tus favoritos y perfil se guardan en este dispositivo. El fútbol se abre en proveedores oficiales; puede requerir suscripción y depende de tu región.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Entendido'),
              ),
            ],
          ),
        ),
      ),
    ],
  );
  Future<void> editProfile() async {
    final controller = TextEditingController(text: preferences.name);
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tu perfil'),
        content: TextField(
          controller: controller,
          maxLength: 24,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Nombre'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                Navigator.pop(context, controller.text.trim());
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
    if (name != null) preferences.update(name: name);
    // Dispose after the dialog route finishes its exit transition.
    await Future<void>.delayed(const Duration(milliseconds: 300));
    controller.dispose();
  }

  Widget footballBanner() => Padding(
    padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
    child: MotionCard(
      child: InkWell(
        onTap: openSports,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: const LinearGradient(
              colors: [Color(0xFF123E37), Color(0xFF101D2C)],
            ),
            border: Border.all(color: accent.withValues(alpha: .3)),
          ),
          child: Row(
            children: [
              const BrandLogo(brand: 'ESPN', width: 56, height: 22),
              const SizedBox(width: 15),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'EL FÚTBOL NOS CONECTA',
                      style: TextStyle(
                        color: accent,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.4,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Tu próxima gran jugada',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Explora las transmisiones oficiales',
                      style: TextStyle(fontSize: 10, color: muted),
                    ),
                  ],
                ),
              ),
              const Icon(
                CupertinoIcons.arrow_up_right,
                size: 18,
                color: accent,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class DetailPage extends StatefulWidget {
  final Map<String, String> movie;
  final bool isSaved;
  final VoidCallback onSave;
  const DetailPage({
    super.key,
    required this.movie,
    required this.isSaved,
    required this.onSave,
  });
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late bool saved = widget.isSaved;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(widget.movie['title']!, style: const TextStyle(fontSize: 15)),
    ),
    body: SafeArea(
      child: ListView(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 380,
                width: double.infinity,
                child: Image.asset(
                  'assets/images/${widget.movie['id']}.jpg',
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
              Positioned.fill(
                child: const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, background],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BrandLogo(
                  brand: widget.movie['studio']!,
                  width: 105,
                  height: 30,
                ),
                const SizedBox(height: 8),
                Text(
                  widget.movie['title']!,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '${widget.movie['year']}   •   ${widget.movie['studio']}   •   Tráiler disponible',
                  style: const TextStyle(color: muted, fontSize: 12),
                ),
                const SizedBox(height: 7),
                Text(
                  widget.movie['genre']!,
                  style: const TextStyle(color: muted, fontSize: 12),
                ),
                const SizedBox(height: 22),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () => openTrailer(context, widget.movie),
                    icon: const Icon(CupertinoIcons.play_fill, size: 17),
                    label: const Text('VER TRÁILER OFICIAL'),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      widget.onSave();
                      setState(() => saved = !saved);
                    },
                    icon: Icon(
                      saved ? CupertinoIcons.check_mark : CupertinoIcons.plus,
                    ),
                    label: Text(saved ? 'EN MI LISTA' : 'AGREGAR A MI LISTA'),
                  ),
                ),
                const SizedBox(height: 23),
                Text(
                  widget.movie['description']!,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.7,
                    color: Color(0xFFD0D5E0),
                  ),
                ),
                const SizedBox(height: 25),

                OutlinedButton.icon(
                  onPressed: () async {
                    await Clipboard.setData(
                      ClipboardData(
                        text:
                            'Mira el tráiler de ${widget.movie['title']}: ${trailerUrls[widget.movie['id']]}',
                      ),
                    );
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Enlace al tráiler copiado'),
                        ),
                      );
                    }
                  },
                  icon: const Icon(CupertinoIcons.share, size: 16),
                  label: const Text('Compartir tráiler'),
                ),
                const SizedBox(height: 25),
                const Divider(),
                const SizedBox(height: 12),
                const Text(
                  'DETALLES',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'Estudio: ${widget.movie['studio']}\nEstreno: ${widget.movie['year']}\nGénero: ${widget.movie['genre']}',
                  style: const TextStyle(
                    color: muted,
                    height: 1.8,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class DisneyLogo extends StatelessWidget {
  const DisneyLogo({super.key});
  @override
  Widget build(BuildContext context) =>
      const BrandLogo(brand: 'Disney+', width: 100, height: 49);
}

class Dot extends StatelessWidget {
  final bool active;
  const Dot({super.key, this.active = false});
  @override
  Widget build(BuildContext context) => AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    width: active ? 22 : 5,
    height: 4,
    margin: const EdgeInsets.symmetric(horizontal: 3),
    decoration: BoxDecoration(
      color: active ? Colors.white : Colors.white30,
      borderRadius: BorderRadius.circular(4),
    ),
  );
}

void openTrailer(BuildContext context, Map<String, String> movie) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      settings: RouteSettings(name: '/trailer/${movie['id']}'),
      builder: (_) => TrailerPage(movie: movie),
    ),
  );
}

class TrailerPage extends StatelessWidget {
  final Map<String, String> movie;
  const TrailerPage({super.key, required this.movie});
  @override
  Widget build(BuildContext context) {
    final url = trailerUrls[movie['id']]!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tráiler oficial', style: TextStyle(fontSize: 15)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 12),
          const Text(
            'UN PRIMER VISTAZO',
            style: TextStyle(
              color: accent,
              letterSpacing: 2.5,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            movie['title']!,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              letterSpacing: -.7,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${movie['studio']}  •  ${movie['year']}',
            style: const TextStyle(color: muted, fontSize: 12),
          ),
          const SizedBox(height: 25),
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: ColoredBox(
                color: Colors.black,
                child: TrailerEmbed(url: url),
              ),
            ),
          ),
          const SizedBox(height: 18),
          const Row(
            children: [
              Icon(CupertinoIcons.play_rectangle, color: accent, size: 17),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Reproductor oficial de Disney',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Pulsa reproducir dentro del video. Puedes activar el sonido y ampliar a pantalla completa desde sus controles.',
            style: TextStyle(color: muted, fontSize: 12, height: 1.7),
          ),
          const SizedBox(height: 25),
          OutlinedButton.icon(
            onPressed: () async {
              final opened = await launchUrl(
                Uri.parse(url),
                mode: LaunchMode.externalApplication,
              );
              if (!opened && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'No se pudo abrir el tráiler. Comprueba tu conexión.',
                    ),
                  ),
                );
              }
            },
            icon: const Icon(CupertinoIcons.arrow_up_right_square, size: 16),
            label: const Text('Abrir reproductor en otra pestaña'),
          ),
          const SizedBox(height: 10),
          const Text(
            'Si tu navegador bloquea el video o no carga, usa el enlace al reproductor. La disponibilidad depende del proveedor y de tu región.',
            style: TextStyle(fontSize: 11, color: muted, height: 1.6),
          ),
          const SizedBox(height: 25),
          const Divider(),
          const SizedBox(height: 14),
          Text(
            movie['description']!,
            style: const TextStyle(
              fontSize: 14,
              height: 1.7,
              color: Color(0xFFD0D5E0),
            ),
          ),
        ],
      ),
    );
  }
}

// Entrada suave y respuesta táctil; respeta la preferencia de reducir movimiento.
class MotionCard extends StatefulWidget {
  final Widget child;
  const MotionCard({super.key, required this.child});
  @override
  State<MotionCard> createState() => _MotionCardState();
}

class _MotionCardState extends State<MotionCard> {
  bool hover = false;
  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    final reduced = MediaQuery.disableAnimationsOf(context);
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: reduced ? 1 : 0, end: 1),
      duration: reduced ? Duration.zero : const Duration(milliseconds: 650),
      curve: Curves.easeOutCubic,
      builder: (_, value, child) => Opacity(
        opacity: value,
        child: Transform.translate(
          offset: Offset(0, (1 - value) * 18),
          child: child,
        ),
      ),
      child: MouseRegion(
        onEnter: (_) => setState(() => hover = true),
        onExit: (_) => setState(() => hover = false),
        child: Listener(
          onPointerDown: (_) => setState(() => pressed = true),
          onPointerUp: (_) => setState(() => pressed = false),
          onPointerCancel: (_) => setState(() => pressed = false),
          child: AnimatedScale(
            scale: pressed
                ? .96
                : hover
                ? 1.035
                : 1,
            duration: reduced
                ? Duration.zero
                : const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                boxShadow: hover
                    ? [
                        BoxShadow(
                          color: accent.withValues(alpha: .18),
                          blurRadius: 16,
                        ),
                      ]
                    : [],
              ),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}

final preferences = AppPreferences();

class AppPreferences extends ChangeNotifier {
  String name = 'Luis';
  bool reduceMotion = false;
  final Set<String> saved = {};
  Future<void> load() async {
    final store = await SharedPreferences.getInstance();
    name = store.getString('profileName') ?? 'Luis';
    reduceMotion = store.getBool('reduceMotion') ?? false;
    saved.addAll(store.getStringList('favorites') ?? []);
    notifyListeners();
  }

  Future<void> persist() async {
    final store = await SharedPreferences.getInstance();
    await store.setString('profileName', name);
    await store.setBool('reduceMotion', reduceMotion);
    await store.setStringList('favorites', saved.toList());
  }

  void update({String? name, bool? reduceMotion}) {
    if (name != null && name.trim().isNotEmpty) this.name = name.trim();
    if (reduceMotion != null) this.reduceMotion = reduceMotion;
    notifyListeners();
    persist();
  }

  void toggleFavorite(String id) {
    if (!saved.add(id)) saved.remove(id);
    notifyListeners();
    persist();
  }
}

class CollectionPage extends StatelessWidget {
  final String title;
  final List<Map<String, String>> items;
  final void Function(Map<String, String>) onSelect;
  const CollectionPage({
    super.key,
    required this.title,
    required this.items,
    required this.onSelect,
  });
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title, style: const TextStyle(fontSize: 17))),
    body: CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
          sliver: SliverToBoxAdapter(
            child: Text(
              '${items.length} historias para descubrir',
              style: const TextStyle(color: muted, fontSize: 12),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              final movie = items[index];
              return MotionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Card(
                        margin: EdgeInsets.zero,
                        child: InkWell(
                          onTap: () => onSelect(movie),
                          child: Image.asset(
                            'assets/images/${movie['id']}.jpg',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            semanticLabel: movie['title'],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      movie['title']!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      movie['year']!,
                      style: const TextStyle(fontSize: 10, color: muted),
                    ),
                  ],
                ),
              );
            }, childCount: items.length),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .59,
              mainAxisSpacing: 20,
              crossAxisSpacing: 14,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 30)),
      ],
    ),
  );
}

Future<void> openOfficial(BuildContext context, String url) async {
  try {
    final opened = await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No se pudo abrir el proveedor. Intenta nuevamente.'),
        ),
      );
    }
  } catch (_) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No se pudo abrir el enlace. Comprueba tu navegador.'),
        ),
      );
    }
  }
}

class FootballPage extends StatelessWidget {
  const FootballPage({super.key});
  static const disneyUrl = 'https://www.disneyplus.com/es-pe';
  static const fifaUrl = 'https://www.fifa.com/en/watch';
  static const agendaUrl =
      'https://www.espn.com.ve/television/nota/_/id/6790109/peru-agenda-disney-plus-lo-mejor-de-la-programacion-de-espn';
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Fútbol', style: TextStyle(fontSize: 18))),
    body: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Container(
          padding: const EdgeInsets.all(23),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF16483E), Color(0xFF10212D), background],
            ),
            border: Border.all(color: accent.withValues(alpha: .25)),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'EL JUEGO EMPIEZA AQUÍ',
                      style: TextStyle(
                        color: accent,
                        letterSpacing: 1.5,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  BrandLogo(brand: 'ESPN', width: 60, height: 22),
                ],
              ),
              SizedBox(height: 22),
              Text(
                'La pasión\nno se pausa.',
                style: TextStyle(
                  fontSize: 35,
                  height: 1.05,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1,
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Encuentra dónde ver fútbol en directo con los proveedores oficiales.',
                style: TextStyle(
                  color: Color(0xFFC0D8D3),
                  height: 1.6,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 27),
        const Text(
          'Elige dónde verlo',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 7),
        const Text(
          'Las señales se abren en el sitio del proveedor.',
          style: TextStyle(fontSize: 11, color: muted),
        ),
        const SizedBox(height: 17),
        providerCard(
          context,
          title: 'ESPN en Disney+',
          badge: 'SUSCRIPCIÓN',
          subtitle: 'Deportes y fútbol con el plan habilitado en tu país. Inicia sesión en Disney+ para consultar los eventos disponibles.',
          icon: CupertinoIcons.tv,
          color: const Color(0xFFFF6C75),
          url: disneyUrl,
          button: 'Abrir ESPN / Disney+',
        ),
        const SizedBox(height: 2),
        providerCard(
          context,
          title: 'FIFA+',
          badge: 'SEGÚN DISPONIBILIDAD',
          subtitle: 'Explora transmisiones, repeticiones y resúmenes de FIFA. La disponibilidad varía por región y competición.',
          icon: Icons.sports_soccer,
          color: accent,
          url: fifaUrl,
          button: 'Explorar FIFA+',
        ),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: () => openOfficial(context, agendaUrl),
          icon: const Icon(CupertinoIcons.calendar, size: 16),
          label: const Text('Consultar agenda oficial de ESPN'),
        ),
        const SizedBox(height: 25),

        const SizedBox(height: 25),
        const Text(
          'La app no integra una señal propia ni verifica qué partido está en vivo en este momento. Los proveedores pueden requerir cuenta o suscripción.',
          style: TextStyle(color: muted, fontSize: 11, height: 1.6),
        ),
      ],
    ),
  );
  Widget providerCard(
    BuildContext context, {
    required String title,
    required String badge,
    required String subtitle,
    required IconData icon,
    required Color color,
    required String url,
    required String button,
  }) => MotionCard(
    child: Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF121C2B),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              BrandLogo(
                brand: title.startsWith('ESPN') ? 'ESPN' : 'FIFA',
                width: 64,
                height: 25,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            badge,
            style: TextStyle(
              color: color,
              fontSize: 8,
              letterSpacing: 1.6,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 9),
          Text(
            subtitle,
            style: const TextStyle(color: muted, fontSize: 12, height: 1.7),
          ),
          const SizedBox(height: 17),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () => openOfficial(context, url),
              icon: const Icon(CupertinoIcons.arrow_up_right, size: 14),
              label: Text(button, style: const TextStyle(fontSize: 12)),
            ),
          ),
        ],
      ),
    ),
  );
}

class NaturePage extends StatelessWidget {
  const NaturePage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('National Geographic', style: TextStyle(fontSize: 17)),
    ),
    body: ListView(
      padding: const EdgeInsets.all(25),
      children: [
        const BrandLogo(brand: 'NAT GEO', width: 220, height: 80),
        const SizedBox(height: 30),
        const Text(
          'El mundo merece\nser explorado.',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 18),
        const Text(
          'Descubre naturaleza, ciencia y aventuras en el catálogo oficial de National Geographic. Los documentales completos no están incluidos en esta muestra.',
          style: TextStyle(color: muted, fontSize: 14, height: 1.8),
        ),
        const SizedBox(height: 25),
        FilledButton.icon(
          onPressed: () => openOfficial(context, 'https://www.natgeotv.com/'),
          icon: const Icon(CupertinoIcons.arrow_up_right, size: 15),
          label: const Text('Explorar National Geographic'),
        ),
      ],
    ),
  );
}

/// Local artwork from Disney's newsroom, ESPN and Wikimedia Commons.
/// Cropping and tinting happen at render time; original files remain intact.
class BrandLogo extends StatelessWidget {
  final String brand;
  final double width;
  final double height;
  const BrandLogo({
    super.key,
    required this.brand,
    this.width = 90,
    this.height = 30,
  });
  @override
  Widget build(BuildContext context) {
    final key = switch (brand.toUpperCase().replaceAll('\n', ' ')) {
      'DISNEY+' => 'disneyplus',
      'PIXAR' => 'pixar',
      'MARVEL' => 'marvel',
      'STAR WARS' => 'starwars',
      'NAT GEO' || 'NATIONAL GEOGRAPHIC' => 'natgeo',
      'ESPN' => 'espn',
      'FIFA' => 'fifa',
      _ => 'disney',
    };
    final crop = switch (key) {
      'disney' => .76,
      'pixar' => .34,
      'starwars' => .73,
      'natgeo' => .53,
      'marvel' => .65,
      _ => 1.0,
    };
    Widget image = Image.asset(
      'assets/images/logo_$key.png',
      width: 800,
      height: key == 'disneyplus'
          ? 438
          : key == 'espn'
          ? 203
          : key == 'fifa'
          ? 262
          : 450,
      fit: BoxFit.fill,
      excludeFromSemantics: true,
    );
    if (key == 'natgeo') {
      image = ColorFiltered(
        colorFilter: const ColorFilter.matrix([
          0,
          0,
          -1,
          0,
          255,
          0,
          0,
          -1,
          0,
          255,
          -1,
          0,
          0,
          0,
          255,
          0,
          0,
          0,
          1,
          0,
        ]),
        child: image,
      );
    } else if (key != 'disneyplus' && key != 'marvel' && key != 'espn') {
      image = ColorFiltered(
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        child: image,
      );
    }
    return Semantics(
      label: brand.replaceAll('\n', ' '),
      image: true,
      child: SizedBox(
        width: width,
        height: height,
        child: FittedBox(
          fit: BoxFit.contain,
          child: ClipRect(
            child: Align(
              heightFactor: crop,
              alignment: Alignment.center,
              child: image,
            ),
          ),
        ),
      ),
    );
  }
}
