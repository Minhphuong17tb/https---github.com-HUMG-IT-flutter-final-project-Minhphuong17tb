import 'package:flutter/material.dart';
import 'package:flutter_project/modals/phone_contact_model.dart';
import 'package:flutter_project/views/add_contact_view.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AddContactView Widget Tests', () {
    testWidgets('Save button triggers onSaveContact with valid data',
        (WidgetTester tester) async {
      // Define a mock callback
      late PhoneContactModel capturedContact;

      await tester.pumpWidget(MaterialApp(
        home: AddContactView(
          onSaveContact: (contact) {
            capturedContact = contact;
          },
        ),
      ));

      // Enter valid data into the form fields
      await tester.enterText(find.byType(TextField).at(0), 'Bùi Quang Minh');
      await tester.enterText(find.byType(TextField).at(1), '0327763367');
      await tester.enterText(
          find.byType(TextField).at(2), 'minhquangbui2004@gmail.com');
      await tester.enterText(
          find.byType(TextField).at(3), '73 Cổ Nhuế - Bắc Từ Liêm - Hà Nội');

      // Use a more specific finder to locate the Save button
      final saveButton = find.descendant(
        of: find.byType(GestureDetector),
        matching: find.text('Lưu'),
      );

      // Tap the Save button
      await tester.tap(saveButton);
      await tester.pumpAndSettle();

      // Validate that the callback was triggered with the correct data
      expect(capturedContact.name, 'Bùi Quang Minh');
      expect(capturedContact.phoneNumber, '0327763367');
      expect(capturedContact.email, 'minhquangbui2004@gmail.com');
      expect(capturedContact.address, '73 Cổ Nhuế - Bắc Từ Liêm - Hà Nội');
    });

    testWidgets('Validation prevents saving with missing required fields',
        (WidgetTester tester) async {
      // Define a mock callback
      var wasCallbackTriggered = false;

      await tester.pumpWidget(MaterialApp(
        home: AddContactView(
          onSaveContact: (_) {
            wasCallbackTriggered = true;
          },
        ),
      ));

      // Leave the required fields empty
      await tester.enterText(find.byType(TextField).at(0), ''); // Name field
      await tester.enterText(
          find.byType(TextField).at(1), ''); // Phone Number field

      // Use a more specific finder to locate the Save button
      final saveButton = find.descendant(
        of: find.byType(GestureDetector),
        matching: find.text('Lưu'),
      );

      // Tap the Save button
      await tester.tap(saveButton);
      await tester.pumpAndSettle();

      // Expect a validation error message and the callback not to be triggered
      expect(find.text('Tên và số điện thoại không được để trống!'),
          findsOneWidget);
      expect(wasCallbackTriggered, isFalse);
    });
  });
}
