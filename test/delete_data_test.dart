import 'package:flutter/material.dart';
import 'package:flutter_project/views/home_view.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test HomeView: Delete Contact', (WidgetTester tester) async {
    // Build the HomeView widget
    await tester.pumpWidget(const MaterialApp(home: HomeView()));

    // Verify initial contacts are displayed
    expect(find.text('Nguyễn Văn A'), findsOneWidget);
    expect(find.text('Trần Thị B'), findsOneWidget);
    expect(find.text('Lê Văn C'), findsOneWidget);

    // Tap on the "more_vert" icon of the first contact
    await tester.tap(find.byIcon(Icons.more_vert).first);
    await tester.pumpAndSettle(); // Ensure the dialog has been rendered

    // Verify the contact details dialog is shown
    expect(
        find.text('Nguyễn Văn A'), findsWidgets); // Name is shown in the dialog

    // Find the "Xóa" button inside the dialog
    final deleteButton = find.descendant(
      of: find.byType(Dialog),
      matching: find.widgetWithText(GestureDetector, 'Xóa'),
    );

    // Verify that the delete button is found
    expect(deleteButton, findsOneWidget);

    // Tap the "Xóa" button inside the dialog
    await tester.tap(deleteButton);
    await tester.pumpAndSettle(); // Wait for the dialog to settle

    // Verify the confirmation dialog is shown
    expect(find.text('Xóa liên hệ'), findsOneWidget);
    expect(
        find.text('Bạn có chắc chắn muốn xóa Nguyễn Văn A?'), findsOneWidget);

    // Confirm the deletion by tapping the "Xóa" button in the confirmation dialog
    final confirmDeleteButton = find.widgetWithText(TextButton, 'Xóa');
    expect(confirmDeleteButton,
        findsOneWidget); // Ensure the confirmation button is found
    await tester.tap(confirmDeleteButton);
    await tester.pumpAndSettle(); // Wait for the action to complete

    // Verify the contact is removed from the list
    expect(find.text('Nguyễn Văn A'), findsNothing);
  });
}
