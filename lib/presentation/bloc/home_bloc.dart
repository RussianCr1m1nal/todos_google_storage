import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class HomeBloc {
  final PageController pageController = PageController();

  final BehaviorSubject<int> _pageSubject = BehaviorSubject<int>.seeded(0);
  Stream<int> get pageStream => _pageSubject.stream;

  void onPageChanged(int page) {
    _pageSubject.add(page);
  }

  void onNavigationItemTap(int index) {
    pageController.jumpToPage(index);
  }

  void dispose() {
    _pageSubject.close();
    pageController.dispose();
  }
}
