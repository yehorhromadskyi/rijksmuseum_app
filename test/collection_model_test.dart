import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rijksmuseum_app/models/collection_model.dart';
import 'package:rijksmuseum_app/services/api_service.dart';

import 'collection_model_test.mocks.dart';

@GenerateMocks([ApiService])
void main() {
  group('When loading collection data', () {
    var body = "{ \"artObjects\":[{\"title\": \"Title\"}] }";
    var emptyBody = "{ \"artObjects\":[] }";
    var mockService = MockApiService();
    when(mockService.get(page: anyNamed('page')))
        .thenAnswer((_) async => jsonDecode(body));

    test('initial fetch returns 1 item', () async {
      final model = CollectionModel(mockService);

      await model.load();

      expect(model.artObjects.length, 1);
    });

    test('subsequent fetch adds 1 more item', () async {
      final model = CollectionModel(mockService);

      await model.load();
      await model.loadMore();

      expect(model.artObjects.length, 2);
    });

    test('subsequent fetch with no items keeps collection unchanged', () async {
      final model = CollectionModel(mockService);

      await model.load();

      when(mockService.get(page: anyNamed('page')))
          .thenAnswer((_) async => jsonDecode(emptyBody));

      await model.loadMore();

      expect(model.artObjects.length, 1);
    });
  });
}
