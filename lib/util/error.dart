import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testing_app/util/snackbar.dart';


void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 201:
      // Handle successful creation
      onSuccess();
      break;
    case 204:
      // Handle successful but no content
      onSuccess();
      break;
    case 400:
      showCustomSnackBar(
        context,
        jsonDecode(response.body)['msg'] ?? 'Bad Request',
      );
      break;
    case 401:
      // Handle unauthorized
      showCustomSnackBar(
        context,
        'Unauthorized: Please login',
      );
      break;
    case 403:
      // Handle forbidden
      showCustomSnackBar(
        context,
        'Forbidden: You do not have permission',
      );
      break;
    case 404:
      // Handle not found
      showCustomSnackBar(
        context,
        'Not Found: Resource not available',
      );
      break;
    case 500:
      showCustomSnackBar(
        context,
        jsonDecode(response.body)['error'] ?? 'Internal Server Error',
      );
      break;
    case 503:
      // Handle service unavailable
      showCustomSnackBar(
        context,
        'Service Unavailable: Please try again later',
      );
      break;
    default:
      showCustomSnackBar(context, 'Unexpected Error: ${response.statusCode}');
  }
}
