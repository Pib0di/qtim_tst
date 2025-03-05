import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// расширения испключительно для удобного пользования go_router
///
extension GoNamedByClass on GoRouter {
  void goClassNamed(
    className, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) =>
      goNamed(
        '$className',
        pathParameters: pathParameters,
        queryParameters: queryParameters,
        extra: extra,
      );

  Future<T?> pushClassNamed<T>(
    className, {
    Map<String, String> pathParameters = const {},
    Map<String, dynamic> queryParameters = const {},
    Object? extra,
  }) =>
      pushNamed<T>(
        '$className',
        pathParameters: pathParameters,
        queryParameters: queryParameters,
        extra: extra,
      );

  Future<T?> pushClassNamedLocation<T>(
    className, {
    Map<String, String> pathParameters = const {},
  }) =>
      push<T>(
        namedLocation(
          '$className',
          pathParameters: pathParameters,
        ),
      );
}

extension GoNamedByClassForContext on BuildContext {
  Future<T?> pushClassNamed<T>(
    className, {
    Map<String, String> pathParameters = const {},
    Map<String, dynamic> queryParameters = const {},
    Object? extra,
  }) =>
      GoRouter.of(this).pushNamed(
        '$className',
        pathParameters: pathParameters,
        queryParameters: queryParameters,
        extra: extra,
      );

  void goClassNamed(
    className, {
    Map<String, String> pathParameters = const {},
    Map<String, dynamic> queryParameters = const {},
    Object? extra,
  }) =>
      GoRouter.of(this).goNamed(
        '$className',
        pathParameters: pathParameters,
        queryParameters: queryParameters,
        extra: extra,
      );

  Future<T?> pushClassNamedLocation<T>(
    className, {
    Map<String, String> pathParameters = const {},
  }) =>
      GoRouter.of(this).push(
        GoRouter.of(this).namedLocation(
          '$className',
          pathParameters: pathParameters,
        ),
      );
}
