import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_6/features/ecommerce/domain/entities/product.dart';
import 'package:task_6/features/ecommerce/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:task_6/features/ecommerce/presentation/pages/add_product_page.dart';
import 'package:task_6/features/ecommerce/presentation/pages/home_page.dart';

// import '../../../../helper/test_helper.mocks.dart';

class MockImagePickerController extends GetxController
    with Mock
    implements ImagePickerController {}

class MockProductBloc extends MockBloc<ProductEvent, ProductState>
    implements ProductBloc {}

class MockProductState extends Fake implements ProductState {}

void main() {
  late ProductBloc productBloc;
  late ImagePickerController imagePickerController;

  final products = [
    const ProductEntity(
        id: 'id',
        name: 'name',
        description: 'description',
        imageUrl: 'imageUrl',
        price: 20)
  ];

  setUp(() {
    registerFallbackValue(MockProductState());
    productBloc = MockProductBloc();

    imagePickerController =
        Get.put<ImagePickerController>(MockImagePickerController());
  });

  tearDown(() {
    Get.delete<ImagePickerController>();
  });

  group('home page', () {
    testWidgets(
        'test if home page shows list of shimmer when AllProductsLoading',
        (tester) async {
      when(() => productBloc.state).thenAnswer((_) => AllProductsLoading());

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: productBloc,
            child: const HomePage(),
          ),
        ),
      );

      expect(find.byKey(const Key('LIST_SHIMMER')), findsOneWidget);
    });

    testWidgets(
        'test if home page show list of products when AllProductsLoaded',
        (tester) async {
      when(() => productBloc.state).thenReturn(AllProductsLoaded(products));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: productBloc,
            child: const HomePage(),
          ),
        ),
      );

      expect(find.text('Hello'), findsOneWidget);
      expect(find.byKey(const Key('LIST_PRODUCT')), findsOneWidget);
      await tester.pump();
    });

    testWidgets('should show error widget when state is ProductError',
        (tester) async {
      when(() => productBloc.state).thenReturn(ProductError('error'));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: productBloc,
            child: const HomePage(),
          ),
        ),
      );

      expect(find.byKey(const Key('ERROR_SHOW')), findsOneWidget);
    });
  });

  group('add page', () {
    testWidgets('verify that new products can be created correctly',
        (tester) async {
      when(() => productBloc.state).thenReturn(CreateProductLoading());
      whenListen(productBloc,
          Stream.fromIterable([CreateProductLoading(), CreateProductLoaded()]));

      when(() => imagePickerController.imageUrl.value)
          .thenReturn('some_image.jpg');

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: productBloc,
            child: const AddProductPage(),
          ),
        ),
      );

      // tester.enterText(find.byKey(const Key('NAME_TEXTFIELD')), 'shoe');
      // tester.enterText(find.byKey(const Key('CATAGORY_TEXTFIELD')), 'shoe');
      // tester.enterText(find.byKey(const Key('PRICE_TEXTFIELD')), '20');
      // tester.enterText(
      //     find.byKey(const Key('DESCRIPTION_TEXTFIELD')), 'this is a shoe');

      await tester.pump();

      await tester.tap(find.byKey(const Key('ADD_BUTTON')));

      await tester.pump();

      expect(find.text('Add Product'), findsOneWidget);
      expect(find.text('name'), findsOneWidget);
    });
  });
}
