import 'package:flutter/material.dart';
import 'package:flutter_project/modals/phone_contact_model.dart';
import 'package:flutter_project/views/update_contact_view.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test EditContactView: Update Contact',
      (WidgetTester tester) async {
    // Create a mock contact
    final contact = PhoneContactModel(
      id: '1',
      name: 'Bùi Quang Minh',
      phoneNumber: '0327763367',
      email: 'minhquangbui2004@gmail.com',
      address: '73 Cổ Nhuế - Bắc Từ Liêm - Hà Nội',
    );

    // Create a mock onUpdateContact function
    late PhoneContactModel updatedContact;
    void onUpdateContact(PhoneContactModel contact) {
      updatedContact = contact;
    }

    // Build the EditContactView widget
    await tester.pumpWidget(MaterialApp(
      home: EditContactView(
        contact: contact,
        onUpdateContact: onUpdateContact,
      ),
    ));

    // Verify the initial values are displayed
    expect(find.text('Bùi Quang Minh'), findsOneWidget);
    expect(find.text('0327763367'), findsOneWidget);
    expect(find.text('minhquangbui2004@gmail.com'), findsOneWidget);
    expect(find.text('73 Cổ Nhuế - Bắc Từ Liêm - Hà Nội'), findsOneWidget);

    // Update the name and phone number fields
    await tester.enterText(find.byType(TextField).at(0), 'Bùi Quang Minh');
    await tester.enterText(find.byType(TextField).at(1), '0327763367');

    // Tap the update button
    await tester.tap(
        find.byKey(const Key('update_contact_button'))); // Use the unique key
    await tester.pumpAndSettle();

    // Verify that the contact was updated
    expect(updatedContact.name, 'Bùi Quang Minh');
    expect(updatedContact.phoneNumber, '0327763367');
    expect(updatedContact.email, 'minhquangbui2004@gmail.com'); // Unchanged
    expect(updatedContact.address,
        '73 Cổ Nhuế - Bắc Từ Liêm - Hà Nội'); // Unchanged
  });
}
