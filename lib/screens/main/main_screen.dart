import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:test_purple_ventures/blocs/base/base_bloc_status.dart';
import 'package:test_purple_ventures/blocs/main/main_bloc.dart';
import 'package:test_purple_ventures/blocs/main/main_event.dart';
import 'package:test_purple_ventures/blocs/main/main_state.dart';
import 'package:test_purple_ventures/models/response/task/task.dart';
import 'package:test_purple_ventures/screens/base/base_page_screen.dart';
import 'package:test_purple_ventures/utils/network_manager/network_manager.dart';
import 'package:test_purple_ventures/utils/shared_preferences_manager/shared_preferences_manager.dart';
import 'package:test_purple_ventures/values/app_color.dart';
import 'package:test_purple_ventures/values/app_constant.dart';
import 'package:test_purple_ventures/values/app_dependency_injection.dart';
import 'package:test_purple_ventures/values/app_string.dart';

class MainScreen extends BasePageScreen {
  MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends BasePageScreenState<MainScreen> with BaseScreen, SingleTickerProviderStateMixin {
  late MainBloc _bloc;
  ErrorType? errorType;
  DateTime? appSuspendedTime;
  int elapsedTimeInSeconds = 0;
  bool passcodeShowing = false;
  int offset = 0;
  String selectedTab = AppConstant.STATUS_TODO;
  late TabController _tabController;
  bool isTabBarClick = false;

  @override
  void initState() {
    super.initState();
    _bloc = MainBloc();
    screenOptions(title: "Main");
    _getData();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (!isTabBarClick) {
        switch (_tabController.index) {
          case 0:
            {
              selectedTab = AppConstant.STATUS_TODO;
              break;
            }
          case 1:
            {
              selectedTab = AppConstant.STATUS_DOING;
              break;
            }
          case 2:
            {
              selectedTab = AppConstant.STATUS_DONE;
              break;
            }
        }
        _getData();
      }
      isTabBarClick = false;
    });
  }

  void _getData() {
    isLoading?.add(true);
    _bloc.add(GetTodoListEvent(offset: offset, status: selectedTab));
  }

  void _blocListener(BuildContext context, MainState state) {
    if (state.status is StateSuccess) {
      errorType = null;
      isLoading?.add(false);
      state.taskResponse?.groupItemsByDate();
    } else if (state.status is StateFail) {
      isLoading?.add(false);
      String? message = (state.status as StateFail).errorMessage;
      if (message == AppString.ERROR_INTERNET) {
        errorType = ErrorType.internet;
      } else if (message == AppString.ERROR_SERVER) {
        errorType = ErrorType.server;
      } else {
        errorType = ErrorType.client;
      }
    }
  }

  @override
  Widget body() {
    var statusBarHeight = MediaQuery.of(context).viewPadding.top;

    return WillPopScope(
      onWillPop: () async {
        if (!passcodeShowing) {
          AppDependency.instance.sharedPreferencesManager.update(key: SharedPreferencesKey.appSuspendedTime, value: DateTime.now().toString());
        }
        passcodeShowing = false;
        return true;
      },
      child: BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<MainBloc, MainState>(
          listener: _blocListener,
          child: DefaultTabController(
            length: 3,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Container(
                padding: EdgeInsets.only(top: statusBarHeight),
                child: _tabBar(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _tabBar() {
    return Column(
      children: [
        Stack(
          children: [
            Positioned.fill(
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: AppColor.lightViolet,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 16, bottom: 16),
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.settings,
                      color: AppColor.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8),
                    child: Text(
                      "Hi! User",
                      style: const TextStyle(
                        color: AppColor.darkGrey,
                        fontSize: 40,
                        fontFamily: AppString.FONT_FAMILY_BOLD,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8, top: 8),
                    child: Text(
                      "Have a nice day.",
                      style: const TextStyle(
                        color: AppColor.darkGrey,
                        fontSize: 24,
                        fontFamily: AppString.FONT_FAMILY_BOLD,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 24),
                    height: 50,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: AppColor.moreLightGrey),
                    child: TabBar(
                      controller: _tabController,
                      onTap: (index) {
                        isTabBarClick = true;
                      },
                      splashFactory: NoSplash.splashFactory,
                      indicatorPadding: EdgeInsets.all(8),
                      indicator: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.topRight,
                          colors: <Color>[
                            AppColor.lightBlue,
                            AppColor.moreLightBlue,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: AppColor.grey,
                      tabs: [
                        Tab(
                          child: Text(
                            "To-do",
                            style: const TextStyle(
                              fontSize: 22,
                              fontFamily: AppString.FONT_FAMILY_MEDIUM,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Doing",
                            style: const TextStyle(
                              fontSize: 22,
                              fontFamily: AppString.FONT_FAMILY_MEDIUM,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Done",
                            style: const TextStyle(
                              fontSize: 22,
                              fontFamily: AppString.FONT_FAMILY_MEDIUM,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [
              _tabBarView(),
              _tabBarView(),
              _tabBarView(),
            ],
          ),
        )
      ],
    );
  }

  Widget _tabBarView() {
    return BlocBuilder<MainBloc, MainState>(
      buildWhen: (o, n) => n.taskResponse != null,
      builder: (context, state) {
        return errorType == null
            ? isLoading?.value == false
                ? state.taskResponse?.tasks?.isEmpty ?? true
                    ? _emptyView()
                    : _listView(state)
                : Container()
            : errorType == ErrorType.internet
                ? _networkErrorView()
                : errorType == ErrorType.server || errorType == ErrorType.client
                    ? _errorView()
                    : Container();
      },
    );
  }

  Widget _listView(MainState state) {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 24),
        itemCount: state.taskResponse?.groupedTasks.length ?? 0, // The number of items in your list
        itemBuilder: (context, index) {
          // Build each item in the list based on the index
          final date = state.taskResponse?.groupedTasks.keys.elementAt(index);
          final tasks = state.taskResponse?.groupedTasks[date]!;

          return _listItemView(state, date, tasks, index);
        },
      ),
    );
  }

  Widget _listItemView(MainState state, String? date, List<Task>? tasks, int groupIndex) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: tasks?.length,
              itemBuilder: (context, index) {
                var task = tasks?[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    index == 0 ? Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Text(
                        date ?? "",
                        style: const TextStyle(
                          color: AppColor.dimBlack,
                          fontSize: 24,
                          fontFamily: AppString.FONT_FAMILY_BOLD,
                        ),
                      ),
                    ) : Container(),
                    Dismissible(
                      key: Key(task?.id ?? ""),
                      onDismissed: (direction) {
                        setState(() {
                          tasks?.removeAt(index);
                        });

                        // Then show a snackbar.
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${task?.title} dismissed',
                            ),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {
                                setState(() {
                                  if (task != null) tasks?.insert(index, task);
                                });
                              },
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            task?.image != null ? Image(
                              width: 48,
                              height: 48,
                              image: AssetImage(task!.image!),
                            ) : SizedBox(
                              width: 48,
                              height: 48,
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      task?.title ?? "",
                                      style: const TextStyle(
                                        color: AppColor.dimBlack,
                                        fontSize: 22,
                                        fontFamily: AppString.FONT_FAMILY_SEMI_BOLD,
                                      ),
                                    ),
                                    Text(
                                      task?.description ?? "",
                                      style: const TextStyle(
                                        color: AppColor.grey,
                                        fontSize: 18,
                                        fontFamily: AppString.FONT_FAMILY_REGULAR,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              })
        ],
      ),
    );
  }

  Widget _emptyView() {
    // return EmptyView(
    //   assetImage: "assets/images/stream_empty_ic.png",
    //   title: "Data Not Found",
    //   detail: "Please log out, and re-log in",
    //   buttonTitle: "Log Out",
    //   onPressed: () {
    //     _showPopupLogout("Log Out", "Are you sure you want to log out,\nand miss out on the latest deals?");
    //   },
    // );
    return Container();
  }

  Widget _networkErrorView() {
    // return ErrorView(
    //   assetImage: "assets/images/internet_error_ic.png",
    //   title: AppString.ERROR_INTERNET,
    //   detail: "Id modi eaque nemo est. Hic porro quis corporis veniam.\nEa sunt quos veniam aut culpa consectetur.",
    //   buttonTitle: "Retry",
    //   onPressed: () {
    //     _getData();
    //   },
    // );
    return Container();
  }

  Widget _errorView() {
    // return ErrorView(
    //   assetImage: "assets/images/server_error_ic.png",
    //   title: AppString.ERROR_SERVER,
    //   detail: "Id modi eaque nemo est. Hic porro quis corporis veniam.\nEa sunt quos veniam aut culpa consectetur.",
    //   buttonTitle: "Retry",
    //   onPressed: () {
    //     _getData();
    //   },
    // );
    return Container();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    DateFormat dateFormat = DateFormat(AppConstant.DATETIME_DEFAULT_PATTERN);
    String? appSuspendedTimeString = AppDependency.instance.sharedPreferencesManager.get(key: SharedPreferencesKey.appSuspendedTime);
    DateTime? appSuspendedTime = appSuspendedTimeString != null ? DateTime.parse(appSuspendedTimeString) : null;
    if (state == AppLifecycleState.paused) {
      AppDependency.instance.sharedPreferencesManager.update(key: SharedPreferencesKey.appSuspendedTime, value: dateFormat.format(DateTime.now()));
      passcodeShowing = false;
    } else if (state == AppLifecycleState.resumed && appSuspendedTime != null) {
      _checkAppPauseTime();
    }
  }

  _checkAppPauseTime() {
    String? appSuspendedTimeString = AppDependency.instance.sharedPreferencesManager.get(key: SharedPreferencesKey.appSuspendedTime);
    DateTime? appSuspendedTime = appSuspendedTimeString != null ? DateTime.parse(appSuspendedTimeString) : null;
    final currentTime = DateTime.now();
    final duration = currentTime.difference(appSuspendedTime!);
    elapsedTimeInSeconds = duration.inSeconds;

    // Check if the app was killed for at least 10 seconds
    bool? isPasscodeValid = AppDependency.instance.sharedPreferencesManager.getBool(key: SharedPreferencesKey.isPasscodeValid);

    if (elapsedTimeInSeconds >= 10 || isPasscodeValid == false) {
      AppDependency.instance.sharedPreferencesManager.updateBool(key: SharedPreferencesKey.isPasscodeValid, value: false);
      if (!passcodeShowing) {
        AppDependency.instance.navigatorCoordinate.goToEnterPasscodeScreen(context, AppConstant.MAIN_PAGE);
        passcodeShowing = true;
      }
    }
  }
}
