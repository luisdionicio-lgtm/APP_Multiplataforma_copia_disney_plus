import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_2/main.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    preferences.saved.clear();
    preferences.name = 'Luis';
    preferences.reduceMotion = true;
  });
  testWidgets('Busca, abre detalles y guarda una película en Mi lista', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Buscar'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Luca');
    await tester.pumpAndSettle();
    expect(find.text('1 resultados'), findsOneWidget);
    await tester.tap(find.widgetWithText(ListTile, 'Luca'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('AGREGAR A MI LISTA'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('AGREGAR A MI LISTA'));
    await tester.pumpAndSettle();
    expect(find.text('EN MI LISTA'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mi lista'));
    await tester.pumpAndSettle();
    expect(find.text('1 títulos guardados'), findsOneWidget);
    expect(find.text('Luca'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
  testWidgets('Abre el tráiler desde el inicio en tamaño móvil', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(movies.length, 23);
    expect(movies.every((m) => trailerUrls.containsKey(m['id'])), isTrue);
    await tester.tap(find.byTooltip('Ver tráiler de Avengers: Endgame'));
    await tester.pumpAndSettle();
    expect(find.text('Tráiler oficial'), findsOneWidget);
    expect(find.text('Reproductor oficial de Disney'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Clásicos'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Clásicos'));
    await tester.pumpAndSettle();
    expect(find.text('Clásicos que viven para siempre'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
  testWidgets('Las marcas abren sus colecciones y Acción muestra películas', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Acción'));
    await tester.pumpAndSettle();
    expect(find.text('Avengers: Endgame'), findsWidgets);
    await tester.scrollUntilVisible(
      find.byKey(const ValueKey('brand-MARVEL')),
      150,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('brand-MARVEL')));
    await tester.pumpAndSettle();
    expect(find.text('Universo Marvel'), findsOneWidget);
    expect(find.text('Black Panther'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
  testWidgets('Fútbol presenta accesos oficiales sin fingir una señal propia', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Fútbol'));
    await tester.tap(find.text('Fútbol'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.text('Abrir ESPN / Disney+'), 150);
    await tester.pumpAndSettle();
    expect(find.text('Abrir ESPN / Disney+'), findsOneWidget);
    final launched = <String>[];
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('plugins.flutter.io/url_launcher'),
          (call) async {
            if (call.method == 'launch') {
              launched.add((call.arguments as Map)['url'] as String);
            }
            return true;
          },
        );
    addTearDown(
      () => TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
            const MethodChannel('plugins.flutter.io/url_launcher'),
            null,
          ),
    );
    await tester.tap(find.text('Abrir ESPN / Disney+'));
    await tester.pumpAndSettle();
    expect(launched, contains(FootballPage.disneyUrl));
    expect(find.text('SUSCRIPCIÓN'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Explorar FIFA+'), 150);
    await tester.pumpAndSettle();
    expect(find.text('Explorar FIFA+'), findsOneWidget);
    await tester.tap(find.text('Explorar FIFA+'));
    await tester.pumpAndSettle();
    expect(launched, contains(FootballPage.fifaUrl));
    expect(tester.takeException(), isNull);
  });
  testWidgets('Los favoritos persisten en el dispositivo', (tester) async {
    preferences.toggleFavorite('endgame');
    await preferences.persist();
    preferences.saved.clear();
    await preferences.load();
    expect(preferences.saved, contains('endgame'));
  });
  testWidgets('El perfil permite editar y guardar el nombre', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Perfil'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Editar perfil'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Alex');
    await tester.tap(find.text('Guardar'));
    await tester.pumpAndSettle();
    expect(find.text('Alex'), findsOneWidget);
    await preferences.persist();
    expect(
      (await SharedPreferences.getInstance()).getString('profileName'),
      'Alex',
    );
    expect(tester.takeException(), isNull);
  });
  testWidgets('El carrusel avanza y respeta reducir movimiento', (
    tester,
  ) async {
    preferences.reduceMotion = false;
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(
      find.byTooltip('Ver tráiler de Avengers: Endgame').hitTestable(),
      findsOneWidget,
    );
    await tester.pump(const Duration(seconds: 6));
    await tester.pump(const Duration(seconds: 1));
    expect(
      find.byTooltip('Ver tráiler de Black Panther').hitTestable(),
      findsOneWidget,
    );
    preferences.update(reduceMotion: true);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 13));
    expect(
      find.byTooltip('Ver tráiler de Black Panther').hitTestable(),
      findsOneWidget,
    );
    await tester.pumpWidget(const SizedBox.shrink());
    expect(tester.takeException(), isNull);
  });
}
