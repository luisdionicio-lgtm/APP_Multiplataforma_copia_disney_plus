# Disney+ · Experiencia móvil en Flutter

Réplica visual educativa con catálogo local en español. No se conecta al servicio Disney+ y no reproduce películas.

## Ejecutar

```sh
flutter pub get
flutter run -d chrome
```

En escritorio aparece un marco de celular; en pantallas menores a 600 px la interfaz ocupa toda la ventana.

## Componentes de aprendizaje

- ListView: inicio, carruseles y resultados de búsqueda.
- ListTile: resultados y opciones del perfil.
- Listas y Mapas: catálogo `movies` en `lib/main.dart`.
- Rutas: `PageRouteBuilder` para detalles con transición y `MaterialPageRoute` para tráileres.
- Tema global: `ThemeData` con paleta oscura en `MyApp`.
- Cards: afiches interactivos con `Card` e `InkWell`.

Catálogo de 23 películas con filtros Para ti, Acción, Fútbol, Clásicos y Pixar; búsqueda por título, estudio y género; detalles; favoritos persistentes en el dispositivo; perfil y carrusel destacado deslizable con indicadores sincronizados. La sección Populares es una selección editorial, no un ranking en tiempo real.

## Tráileres y diseño

Los 23 títulos enlazan a avances oficiales de Disney, registrados en `assets/sources.json`. En web se reproducen dentro de un iframe con controles de sonido y pantalla completa. El usuario inicia la reproducción. Se ofrece un enlace externo por si el proveedor o navegador bloquean el reproductor; en plataformas nativas se utiliza ese enlace externo. Requieren conexión y su disponibilidad depende de Disney y de la región. Se verificó reproducción real del avance de Moana 2 en el navegador.

Marcas navegables con colecciones, acceso a Ver todo por sección, edición de perfil y compartir enlaces a tráileres. Los GIFs, el movimiento, el nombre, favoritos y reacciones se guardan mediante SharedPreferences.

Marco con acabado metálico e isla de cámara, tipografía Outfit instalada localmente (licencia SIL OFL incluida), iconos Cupertino, paleta azul noche/turquesa, carrusel de populares numerado, transiciones de pantalla, entrada de afiches y respuesta a hover/pulsación. Las animaciones de navegación y tarjetas respetan reducir movimiento. Los afiches y la fuente se cargan localmente.

## Fútbol y GIFs

La sección Fútbol contiene acceso a ESPN/Disney+ (https://www.disneyplus.com/es-pe), FIFA+ (https://www.fifa.com/en/watch) y la agenda oficial de ESPN para Perú. Las transmisiones se abren en el sitio oficial; la aplicación no incorpora un stream propio ni inventa encuentros, resultados o disponibilidad en directo. Puede requerirse una cuenta o suscripción del proveedor.

Tres GIFs de reacción (corazón, estrella y balón), creados localmente con sus versiones PNG para reducir movimiento, aparecen en detalles de películas y fútbol. Una reacción se selecciona y se quita tocándola nuevamente; es personal, no un contador de otros usuarios. Los GIFs pueden desactivarse desde Perfil. El balón decorativo tiene una animación de giro y pulso que respeta reducir movimiento.

## Logos e iconos

Disney+, Disney, Pixar, Marvel, Star Wars, National Geographic y ESPN usan recursos gráficos locales; FIFA usa el gráfico de Wikimedia Commons. Las fuentes se registran en `assets/logo_sources.json`. El render adapta el contraste de los logos oscuros al fondo sin modificar los originales. Navegación, controles, estado del celular y acciones usan iconos Cupertino; el balón deportivo es un pictograma Material. También se sustituyeron el favicon y el icono web instalable. Los símbolos de los controles del reproductor pertenecen al proveedor del video.

## Imágenes

Afiches obtenidos de las páginas oficiales de Disney Movies, con sus URLs registradas en `assets/sources.json`. Hero de Moana 2: https://lumiere-a.akamaihd.net/v1/images/pp_moana2_herobanner_mobile_3113-1_b2ec5c0c.jpeg

La marca y las imágenes pertenecen a sus respectivos titulares. Las sinopsis son resúmenes redactados para la muestra. Esta implementación es una aproximación visual, no una reproducción verificada píxel por píxel de la aplicación oficial. No requiere REA.

## Validación

```sh
flutter analyze
flutter test
flutter build web
```
