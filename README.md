# Disney+ · Experiencia móvil en Flutter

Interfaz educativa en español, con 23 películas, tráileres oficiales y un marco de celular adaptable en la web. No se conecta al catálogo privado ni reproduce películas completas.

## Ejecutar

```sh
flutter pub get
flutter run -d chrome
```

En escritorio se presenta un marco de 400 px de ancho; en ventanas menores a 600 px la aplicación ocupa toda la pantalla.

## Diseño y navegación

- Carrusel compacto con Avengers: Endgame al inicio, seguido de Black Panther, Rogue One y Capitana Marvel. Cambia automáticamente cada seis segundos, con deslizamiento manual e indicadores interactivos.
- El carrusel se adapta a los filtros Pixar y Clásicos. Moana ya no aparece entre los destacados iniciales; se conserva en el catálogo.
- La rotación se pausa en segundo plano, al cambiar de pantalla, durante el desplazamiento y al activar reducir movimiento.
- Tema azul noche, tipografía local Outfit, logos gráficos y controles Cupertino. Se retiraron los GIFs, las reacciones y los adornos de estrellas.
- Filtros, búsqueda, colecciones por marca, Ver todo, detalles, perfil editable, compartir tráileres y favoritos persistentes en el dispositivo.
- Rutas de detalles, tráileres y fútbol que admiten recarga en web.

## Componentes de aprendizaje

- ListViews para inicio, carruseles y resultados.
- ListTiles para búsqueda y perfil.
- Listas y Mapas para el catálogo local.
- Rutas con MaterialPageRoute y PageRouteBuilder.
- Tema Global con ThemeData.
- Cards interactivas para las películas.

## Tráileres y fútbol

Los tráileres utilizan el reproductor oficial de Disney dentro de la web, con enlace externo alternativo. Requieren conexión y su disponibilidad depende del proveedor y la región. Se comprobó reproducción real de Moana 2 y Avengers: Endgame.

Fútbol ofrece acceso a ESPN/Disney+, FIFA+ y la agenda oficial de ESPN. Las transmisiones se abren en el proveedor y pueden requerir cuenta o suscripción. No se inventan marcadores ni partidos en directo.

## Recursos

Afiches e imágenes promocionales de páginas de Disney, documentados en `assets/sources.json`. Logos de Disney y ESPN, y gráfico de FIFA desde Wikimedia Commons, documentados en `assets/logo_sources.json`. La fuente Outfit incluye su licencia SIL OFL. Las marcas e imágenes pertenecen a sus titulares. Las sinopsis son resúmenes redactados para esta muestra.

## Validación

```sh
flutter analyze
flutter test
flutter build web
```

Las pruebas cubren búsqueda, detalles, favoritos, marcas, acceso a proveedores de fútbol, edición de perfil y avance automático del carrusel con respeto a reducir movimiento.
