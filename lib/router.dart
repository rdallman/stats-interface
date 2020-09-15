import 'package:flutter/material.dart';
import 'package:goswapinfo/views/home/home_view.dart';
import 'package:goswapinfo/views/tokens_list_view.dart';
import 'package:goswapinfo/views/pairs_list_view.dart';
import 'package:goswapinfo/views/accounts_list_view.dart';
import 'package:goswapinfo/views/transactions_list_view.dart';
import 'dart:developer';

Route<dynamic> gerenateRoute(RouteSettings settings) {
  log('data: $settings');

  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => HomeView());
    case 'tokens':
      return MaterialPageRoute(builder: (context) => TokensListView());
    case 'pairs':
      return MaterialPageRoute(builder: (context) => PairsListView());
    case 'accounts':
      return MaterialPageRoute(builder: (context) => AccountsListView());
    case 'transactions':
      return MaterialPageRoute(builder: (context) => TransactionsListView());
    default:
      return MaterialPageRoute(builder: (context) => HomeView());
  }
}
