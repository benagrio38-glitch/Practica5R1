# Práctica 5 · Plebiscito Vecinal de Dolores Hidalgo

App de votación en Flutter. Los vecinos votan por la obra prioritaria del municipio, las barras de porcentaje se animan en pantalla y un diálogo anuncia la opción ganadora.

- **Alumno:** Oscar Manuel Ayala Ortiz
- **Grupo:** GTID244 · **Núm. de control:** 1225100784
- **Materia:** Desarrollo de Aplicaciones Móviles (UTNG)

## Funcionalidades

- Pregunta con 4 opciones: Rehabilitación del Jardín Principal, Nueva Biblioteca Digital, Alumbrado en el Barrio de Analco y Parque Infantil en la Colonia Guanajuato.
- Cada usuario vota una sola vez; después de votar, los botones desaparecen.
- Barras y porcentajes con animación.
- Botón **Ver resultado del plebiscito**: diálogo con la opción ganadora, o el empate si lo hay.
- La lógica rechaza votos repetidos, opciones inexistentes y votos fuera de fecha.

## Estructura

```
lib/
├── logica/
│   ├── servicio_votacion.dart   Reglas: registrar voto, resultados, ganador
│   └── resultado_voto.dart      exitoso, opcionInvalida, usuarioYaVoto, votacionCerrada
├── modelos/
│   ├── votacion.dart            Pregunta, opciones, fecha de cierre y votantes
│   ├── opcion_votacion.dart     Opción con su contador de votos
│   └── resultado_opcion.dart    Opción con su porcentaje
├── presentation/
│   └── votacion_screen.dart     Pantalla única
└── main.dart
```

La lógica de votación está separada de la pantalla, por eso se prueba sin abrir la app.

## Cómo ejecutarla

```
flutter pub get
flutter run -d chrome
flutter test
```

## Evidencia de funcionamiento

| Inicio, todo en 0% | Voto registrado | Resultado del plebiscito |
|---|---|---|
| ![Inicio](evidencia/01_inicio_0porciento.png) | ![Voto](evidencia/02_voto_registrado.png) | ![Resultado](evidencia/03_resultado_plebiscito.png) |

## Pruebas (TDD, ronda por ronda)

Cada ronda muestra la prueba en **rojo** (falla) y después en **verde** (pasa). Como la app ya estaba terminada, el rojo se provocó cambiando temporalmente una línea del código, indicada en cada ronda. Después se revirtió el cambio con `git checkout` y se volvió a correr la prueba.

### Ronda 1 – Porcentajes

**Prueba:** calcula el porcentaje de cada opción correctamente

**Cambio para provocar el fallo:** `servicio_votacion.dart`: el cálculo del porcentaje se multiplicó por 10 en lugar de 100.

**ROJO** – La prueba falla

![Ronda 1 rojo](evidencia/tdd/r1_rojo.png)

**VERDE** – Se revierte el cambio y la prueba pasa

![Ronda 1 verde](evidencia/tdd/r1_verde.png)

### Ronda 2 – Un usuario no vota dos veces

**Prueba:** un usuario no puede votar dos veces

**Cambio para provocar el fallo:** `servicio_votacion.dart`: se desactivó la validación de voto repetido (`if (false)`).

**ROJO** – La prueba falla

![Ronda 2 rojo](evidencia/tdd/r2_rojo.png)

**VERDE** – Se revierte el cambio y la prueba pasa

![Ronda 2 verde](evidencia/tdd/r2_verde.png)

### Ronda 3 – Ganador y empate

**Prueba:** determinarGanador regresa la opción con más votos

**Cambio para provocar el fallo:** `servicio_votacion.dart`: se invirtió la comparación que busca el máximo de votos.

**ROJO** – La prueba falla

![Ronda 3 rojo](evidencia/tdd/r3_rojo.png)

**VERDE** – Se revierte el cambio y la prueba pasa

![Ronda 3 verde](evidencia/tdd/r3_verde.png)

### Ronda 4 – Votación cerrada

**Prueba:** no se puede votar si la votación ya cerró

**Cambio para provocar el fallo:** `servicio_votacion.dart`: `isAfter` se cambió por `isBefore` al revisar la fecha de cierre.

**ROJO** – La prueba falla

![Ronda 4 rojo](evidencia/tdd/r4_rojo.png)

**VERDE** – Se revierte el cambio y la prueba pasa

![Ronda 4 verde](evidencia/tdd/r4_verde.png)

### Ronda 5 – Simulación completa

**Prueba:** simulación completa: varios vecinos votan y se determina un ganador

**Cambio para provocar el fallo:** `servicio_votacion.dart`: cada voto sumaba 2 en lugar de 1.

**ROJO** – La prueba falla

![Ronda 5 rojo](evidencia/tdd/r5_rojo.png)

**VERDE** – Se revierte el cambio y la prueba pasa

![Ronda 5 verde](evidencia/tdd/r5_verde.png)

### Ronda 6 – Pantalla

**Prueba:** las dos pruebas de `widget_test.dart`

**Cambio para provocar el fallo:** `votacion_screen.dart`: el texto del botón se cambió de «Votar por esta opcion» a «Votar».

**ROJO** – La prueba falla

![Ronda 6 rojo](evidencia/tdd/r6_rojo.png)

**VERDE** – Se revierte el cambio y la prueba pasa

![Ronda 6 verde](evidencia/tdd/r6_verde.png)

### Resultado final

`flutter test` pasa las 11 pruebas.

![flutter test](evidencia/04_flutter_test.png)

- `servicio_votacion_test.dart` (9): porcentajes, cero votos, voto repetido, opción inválida, ganador, empate, votación cerrada, votación abierta y simulación completa.
- `widget_test.dart` (2): la pantalla arranca en 0% y, al votar, la opción sube a 100% y los botones desaparecen.

Los avisos de voto repetido y de votación cerrada no se ven en pantalla, porque tras votar la app oculta los botones; esos casos se comprueban con pruebas.
