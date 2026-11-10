// Prueba de la pantalla: votar por una opción y ver los resultados.
import 'package:flutter_test/flutter_test.dart';

import 'package:vota_dolores_hidalgo/main.dart';

void main() {
  testWidgets('la pantalla muestra la pregunta y las opciones en 0%',
      (WidgetTester tester) async {
    await tester.pumpWidget(const VotaDoloresApp());
    await tester.pumpAndSettle();

    expect(find.text('Plebiscito Vecinal - Dolores Hidalgo'), findsOneWidget);
    expect(find.text('Nueva Biblioteca Digital'), findsOneWidget);
    expect(find.text('Votar por esta opcion'), findsWidgets);
    expect(find.text('100%'), findsNothing);
  });

  testWidgets('al votar, la opción sube a 100% y desaparecen los botones',
      (WidgetTester tester) async {
    await tester.pumpWidget(const VotaDoloresApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Votar por esta opcion').first);
    await tester.pumpAndSettle();

    expect(find.text('100%'), findsOneWidget);
    expect(find.text('Votar por esta opcion'), findsNothing);
  });
}
