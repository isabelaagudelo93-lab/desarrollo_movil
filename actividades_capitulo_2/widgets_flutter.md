**# Investigación de widgets fundamentales en Flutter
**Nombre del estudiante:** Isabela Agudelo Rodríguez <br>
**Curso:** Desarrollo de Aplicaciones Móviles <br>
**Fecha:** 14 de mayo de 2026 <br>

## 1. `AppBar`

### Descripción del widget

El `AppBar` es un widget fundamental en Flutter que proporciona una barra de aplicaciones en la parte superior de la pantalla. Es comúnmente utilizado para mostrar el título de la aplicación, acciones y navegación. El `AppBar` puede contener elementos como botones, menús desplegables y otros widgets interactivos. Es altamente personalizable, lo que permite a los desarrolladores adaptar su apariencia y funcionalidad según las necesidades de la aplicación.

### Ejemplo de código

```dart
import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Ejemplo de AppBar'),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Acción de búsqueda
              },
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                // Acción de configuración
              },
            ),
          ],
        ),
        body: Center(child: Text('Contenido de la aplicación')),
      ),
    );
  }
}
```

## Explicación del código

En este ejemplo, se crea una aplicación básica de Flutter con un `AppBar` que contiene un título y dos botones de acción (búsqueda y configuración). El `AppBar` se define dentro del widget `Scaffold`, que proporciona la estructura básica de la pantalla. Los botones de acción están representados por `IconButton`, y cada uno tiene un icono y una función `onPressed` que se ejecuta cuando el botón es presionado. En este caso, las funciones están vacías, pero en una aplicación real, podrían contener lógica para realizar acciones específicas.

## Personalización del AppBar

| Propiedad | Descripción | Ejemplo |
|-----------|-------------|---------|
| `title` | Widget que se muestra como título de la barra. | `title: Text('Mi App')` |
| `backgroundColor` | Color de fondo de la AppBar. | `backgroundColor: Colors.teal` |
| `actions` | Lista de íconos o botones en el lado derecho. | `actions: [IconButton(...)]` |
| `leading` | Widget en el lado izquierdo (antes del título). | `leading: Icon(Icons.menu)` |
| `centerTitle` | Centra el título en la barra. | `centerTitle: true` |
| `elevation` | Sombra bajo la barra. | `elevation: 4` |

### Ejemplo con personalización

```dart
AppBar(
  backgroundColor: Colors.teal,
  centerTitle: true,
  title: Text(
    'Mi Aplicación',
    style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  ),
  leading: IconButton(
    icon: Icon(Icons.menu, color: Colors.white),
    onPressed: () {},
  ),
  actions: [
    IconButton(
      icon: Icon(Icons.search, color: Colors.white),
      onPressed: () {},
    ),
    IconButton(
      icon: Icon(Icons.notifications, color: Colors.white),
      onPressed: () {},
    ),
  ],
  elevation: 6,
)
```

## Explicación de la personalización

En este ejemplo, el `AppBar` se ha personalizado con un color de fondo verde azulado (`Colors.teal`), el título está centrado y tiene un estilo de texto personalizado. Además, se ha agregado un botón de menú en el lado izquierdo y dos botones de acción (búsqueda y notificaciones) en el lado derecho, todos con iconos blancos para mejorar la visibilidad. La propiedad `elevation` se ha establecido en 6 para agregar una sombra más pronunciada debajo de la barra. Esta personalización permite que el `AppBar` se adapte mejor al diseño y la estética de la aplicación.

## Conclusión 

El `AppBar` es un widget esencial en Flutter que proporciona una barra de aplicaciones funcional y personalizable. Permite a los desarrolladores mostrar información importante, como el título de la aplicación, y ofrecer acciones rápidas a los usuarios. La capacidad de personalización del `AppBar` facilita la creación de interfaces de usuario atractivas y coherentes con el diseño general de la aplicación. Al comprender cómo utilizar y personalizar el `AppBar`, los desarrolladores pueden mejorar significativamente la experiencia del usuario en sus aplicaciones Flutter.

## 2. `Scaffold`

### Descripción del widget

El `Scaffold` es un widget fundamental en Flutter que proporciona una estructura básica para la mayoría de las aplicaciones. Actúa como un contenedor que organiza los elementos visuales de la aplicación, como el `AppBar`, el cuerpo principal, el `Drawer`, el `BottomNavigationBar`, entre otros. El `Scaffold` facilita la creación de interfaces de usuario consistentes y bien organizadas, permitiendo a los desarrolladores centrarse en el contenido y la funcionalidad de la aplicación.

### Ejemplo de código

```dart
import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Ejemplo de Scaffold'),
        ),
        body: Center(child: Text('Contenido de la aplicación')),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Menú de Navegación',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Inicio'),
                onTap: () {
                  // Acción para Inicio
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Configuración'),
                onTap: () {
                  // Acción para Configuración
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```
## Explicación del código

En este ejemplo, se crea una aplicación básica de Flutter utilizando el widget `Scaffold`. El `Scaffold` contiene un `AppBar` con un título y un `Drawer` que se despliega desde el lado izquierdo de la pantalla. El cuerpo principal del `Scaffold` muestra un texto centrado. El `Drawer` incluye un encabezado y dos elementos de lista que representan opciones de navegación (Inicio y Configuración). Cada elemento de la lista tiene un icono y una función `onTap` que se ejecuta cuando el usuario toca la opción, aunque en este caso las funciones están vacías. El `Scaffold` proporciona una estructura organizada para la aplicación, facilitando la inclusión de diferentes componentes visuales.

## Personalización del Scaffold

| Propiedad | Descripción | Ejemplo |
|-----------|-------------|---------|
| `appBar` | Widget que se muestra en la parte superior de la pantalla. | `appBar: AppBar(...)` |
| `body` | Widget que se muestra en el cuerpo principal de la pantalla. | `body: Center(child: Text('Contenido'))` |
| `drawer` | Widget que se muestra al deslizar desde el lado izquierdo. | `drawer: Drawer(...)` |
| `bottomNavigationBar` | Widget que se muestra en la parte inferior de la pantalla.
| `floatingActionButton` | Botón de acción flotante. | `floatingActionButton: FloatingActionButton(...)` |
| `backgroundColor` | Color de fondo del Scaffold. | `backgroundColor: Colors.grey[200]` |

### Ejemplo con personalización

```dart
Scaffold(
  appBar: AppBar(
    title: Text('Mi Aplicación'),
    backgroundColor: Colors.deepPurple,
  ),
  body: Center(
    child: Text(
      'Bienvenido a mi aplicación',
      style: TextStyle(fontSize: 24, color: Colors.deepPurple),
    ),
  ),
  drawer: Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.deepPurple,
          ),
          child: Text(
            'Menú Principal',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Inicio'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Configuración'),
          onTap: () {},
        ),
      ],
    ),
  ),
  floatingActionButton: FloatingActionButton(
    onPressed: () {
      // Acción del botón de acción flotante
    },
    child: Icon(Icons.add),
    backgroundColor: Colors.deepPurple,
  ),
)
```
## Explicación de la personalización

En este ejemplo, el `Scaffold` se ha personalizado con un `AppBar` de color púrpura oscuro y un título. El cuerpo del `Scaffold` muestra un mensaje de bienvenida con un estilo de texto personalizado. El `Drawer` también tiene un encabezado con el mismo color púrpura y dos opciones de navegación. Además, se ha agregado un `FloatingActionButton` con un icono de suma y el mismo color púrpura para mantener la coherencia visual. Esta personalización permite que el `Scaffold` se adapte mejor al diseño y la estética de la aplicación, proporcionando una experiencia de usuario más atractiva.

## Conclusión

El `Scaffold` es un widget esencial en Flutter que proporciona una estructura básica para la mayoría de las aplicaciones. Permite a los desarrolladores organizar los elementos visuales de la aplicación de manera coherente y eficiente. La capacidad de personalización del `Scaffold` facilita la creación de interfaces de usuario atractivas y funcionales, adaptándose a las necesidades específicas de cada aplicación. Al comprender cómo utilizar y personalizar el `Scaffold`, los desarrolladores pueden mejorar significativamente la experiencia del usuario en sus aplicaciones Flutter.

## 3. `Card`

### Descripción del widget

El `Card` es un widget fundamental en Flutter que se utiliza para crear contenedores con una apariencia de tarjeta. Es comúnmente utilizado para mostrar información relacionada, como imágenes, texto y botones, en un formato visualmente atractivo. El `Card` tiene bordes redondeados y una sombra que le da un efecto de elevación, lo que lo hace destacar del fondo. Es altamente personalizable, lo que permite a los desarrolladores adaptar su apariencia y contenido según las necesidades de la aplicación.

### Ejemplo de código

```dart
import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Ejemplo de Card'),
        ),
        body: Center(
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              width: 300,
              height: 150,
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Título de la Tarjeta',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('Descripción de la tarjeta.'),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Acción del botón
                    },
                    child: Text('Acción'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```
## Explicación del código

En este ejemplo, se crea una aplicación básica de Flutter que muestra un `Card` en el centro de la pantalla. El `Card` tiene una elevación de 4 y bordes redondeados con un radio de 15. Dentro del `Card`, hay un contenedor que define su tamaño y padding. El contenido del `Card` incluye un título, una descripción y un botón de acción. El título está estilizado con un tamaño de fuente más grande y negrita para destacarlo. El botón de acción es un `ElevatedButton` que puede ejecutar una función cuando se presiona, aunque en este caso la función está vacía. El `Card` proporciona una forma visualmente atractiva de presentar información relacionada en la aplicación.

## Personalización del Card

| Propiedad | Descripción | Ejemplo |
|-----------|-------------|---------|
| `elevation` | Sombra que da un efecto de elevación. | `elevation: 4` |
| `shape` | Forma del card, como bordes redondeados. | `shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))` |
| `color` | Color de fondo del card. | `color: Colors.white` |
| `child` | Widget que se muestra dentro del card. | `child: Container(...)` |
| `margin` | Espacio alrededor del card. | `margin: EdgeInsets.all(16)` |
| `shadowColor` | Color de la sombra del card. | `shadowColor: Colors.grey` |

### Ejemplo con personalización

```dart
Card(
  elevation: 6,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  ),
  color: Colors.white,
  shadowColor: Colors.grey,
  child: Container(
    width: 350,
    height: 200,
    padding: EdgeInsets.all(20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Tarjeta Personalizada',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple),
        ),
        SizedBox(height: 15),
        Text('Esta es una tarjeta personalizada con un diseño atractivo.'),
        SizedBox(height: 15),
        ElevatedButton(
          onPressed: () {
            // Acción del botón
          },
          child: Text('Acción Personalizada'),
          style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
        ),
      ],
    ),
  ),
)
```

## Explicación de la personalización

En este ejemplo, el `Card` se ha personalizado con una elevación de 6, bordes redondeados con un radio de 20, un color de fondo blanco y una sombra gris. El contenido del `Card` incluye un título estilizado con un tamaño de fuente más grande, negrita y color púrpura oscuro para destacarlo. La descripción también se ha separado con un espacio adicional para mejorar la legibilidad. El botón de acción se ha personalizado con un color de fondo púrpura para mantener la coherencia visual con el título. Esta personalización permite que el `Card` se adapte mejor al diseño y la estética de la aplicación, proporcionando una experiencia de usuario más atractiva.

## Conclusión

El `Card` es un widget esencial en Flutter que proporciona una forma visualmente atractiva de presentar información relacionada en la aplicación. Permite a los desarrolladores organizar contenido como texto, imágenes y botones dentro de un contenedor con bordes redondeados y sombra. La capacidad de personalización del `Card` facilita la creación de interfaces de usuario atractivas y coherentes con el diseño general de la aplicación. Al comprender cómo utilizar y personalizar el `Card`, los desarrolladores pueden mejorar significativamente la experiencia del usuario en sus aplicaciones Flutter.

## 4. `Icon`

### Descripción del widget

El `Icon` es un widget fundamental en Flutter que se utiliza para mostrar iconos gráficos en la interfaz de usuario. Los iconos son símbolos visuales que representan acciones, objetos o conceptos, y el widget `Icon` facilita su inclusión en la aplicación. Flutter proporciona una amplia variedad de iconos a través de la clase `Icons`, que incluye iconos comunes como flechas, botones de reproducción, íconos de redes sociales, entre otros. El `Icon` es altamente personalizable, lo que permite a los desarrolladores ajustar su tamaño, color y estilo para adaptarse al diseño de la aplicación.

### Ejemplo de código

```dart
import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Ejemplo de Icon'),
        ),
        body: Center(
          child: Icon(
            Icons.favorite,
            color: Colors.red,
            size: 50,
          ),
        ),
      ),
    );
  }
}
```

## Explicación del código

En este ejemplo, se crea una aplicación básica de Flutter que muestra un icono de corazón en el centro de la pantalla. El icono se obtiene de la clase `Icons` utilizando `Icons.favorite`, que representa un corazón. El color del icono se establece en rojo y su tamaño se ajusta a 50. El widget `Icon` facilita la inclusión de iconos gráficos en la interfaz de usuario, lo que puede mejorar la experiencia del usuario al proporcionar símbolos visuales claros para acciones o conceptos específicos.

## Personalización del Icon

| Propiedad | Descripción | Ejemplo |
|-----------|-------------|---------|
| `icon` | El icono que se desea mostrar. | `Icons.favorite` |
| `color` | Color del icono. | `color: Colors.red` |
| `size` | Tamaño del icono. | `size: 50` |
| `semanticLabel` | Etiqueta semántica para accesibilidad. | `semanticLabel: 'Icono de corazón'` |
| `textDirection` | Dirección del texto para iconos que dependen de la dirección. | `textDirection: TextDirection.ltr` |
| `shadows` | Sombra para el icono. | `shadows: [Shadow(...)]` |

### Ejemplo con personalización

```dart
Icon(
  Icons.star,
  color: Colors.amber,
  size: 60,
  semanticLabel: 'Icono de estrella',
  shadows: [
    Shadow(
      color: Colors.black45,
      offset: Offset(2, 2),
      blurRadius: 4,
    ),
  ],
)
```
## Explicación de la personalización

En este ejemplo, el `Icon` se ha personalizado para mostrar una estrella en color ámbar con un tamaño de 60. Se ha agregado una etiqueta semántica para mejorar la accesibilidad, lo que permite a los lectores de pantalla describir el icono como "Icono de estrella". Además, se ha añadido una sombra al icono para darle un efecto de profundidad, utilizando un color de sombra negro con una opacidad del 45%, un desplazamiento de 2 píxeles en ambas direcciones y un radio de desenfoque de 4. Esta personalización permite que el `Icon` se adapte mejor al diseño y la estética de la aplicación, proporcionando una experiencia de usuario más atractiva y accesible.

# Conclusión

El `Icon` es un widget fundamental en Flutter que permite mostrar iconos gráficos en la interfaz de usuario. Su alta personalización facilita la creación de interfaces de usuario atractivas y coherentes con el diseño general de la aplicación. Al comprender cómo utilizar y personalizar el `Icon`, los desarrolladores pueden mejorar significativamente la experiencia del usuario en sus aplicaciones Flutter.

## 5. `Image`

### Descripción

El widget `Image` permite **mostrar imágenes** dentro de la interfaz de usuario. Flutter soporta imágenes desde distintas fuentes: desde la red mediante una URL, desde los assets del proyecto, desde archivos del dispositivo o desde memoria. Cada fuente tiene su propio constructor.

Es fundamental en cualquier aplicación que necesite mostrar fotografías, ilustraciones, banners, avatares de usuario o cualquier contenido visual gráfico.

### Ejemplo de código

```dart
Image.network(
  'https://picsum.photos/300/200',
)
```

### Explicación del ejemplo

Este ejemplo carga y muestra una imagen desde una URL utilizando el constructor `Image.network`. Flutter descarga la imagen automáticamente y la muestra en pantalla. Si la URL no está disponible, se puede manejar el error con la propiedad `errorBuilder`.

### Personalización

| Propiedad | Descripción | Ejemplo |
|-----------|-------------|---------|
| `width` | Ancho de la imagen. | `width: 200` |
| `height` | Alto de la imagen. | `height: 150` |
| `fit` | Cómo se ajusta la imagen dentro de su espacio. | `fit: BoxFit.cover` |
| `alignment` | Alineación de la imagen dentro de su contenedor. | `alignment: Alignment.center` |
| `loadingBuilder` | Widget que se muestra mientras carga la imagen. | `loadingBuilder: (...)` |
| `errorBuilder` | Widget que se muestra si la imagen falla al cargar. | `errorBuilder: (...)` |

### Ejemplo con personalización

```dart
ClipRRect(
  borderRadius: BorderRadius.circular(16),
  child: Image.network(
    'https://picsum.photos/400/250',
    width: double.infinity,
    height: 200,
    fit: BoxFit.cover,
    alignment: Alignment.center,
    loadingBuilder: (context, child, loadingProgress) {
      if (loadingProgress == null) return child;
      return Container(
        height: 200,
        color: Colors.grey[200],
        child: Center(child: CircularProgressIndicator()),
      );
    },
    errorBuilder: (context, error, stackTrace) {
      return Container(
        height: 200,
        color: Colors.grey[300],
        child: Icon(Icons.broken_image, size: 60, color: Colors.grey),
      );
    },
  ),
)
```

### Explicación de la personalización

Este ejemplo carga una imagen desde internet con ancho completo y altura fija de 200 píxeles. Se usa `BoxFit.cover` para que la imagen llene su espacio sin distorsionarse. `ClipRRect` agrega bordes redondeados. Mientras la imagen carga se muestra un indicador de progreso, y si falla, aparece un ícono de imagen rota. Este patrón es el estándar en apps con contenido dinámico.

### Conclusión

`Image` es indispensable en cualquier aplicación moderna que trabaje con contenido visual. Su capacidad para cargar imágenes desde múltiples fuentes, combinada con opciones de ajuste, recorte y manejo de errores, lo convierten en uno de los widgets más completos y necesarios del ecosistema Flutter.
**
