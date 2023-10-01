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
import 'package:test_purple_ventures/widgets/error_view.dart';

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
  int elapsedTimeInSeconds = 0;
  int offset = 0;
  String selectedTab = AppConstant.STATUS_TODO;
  bool passcodeShowing = false;
  bool isTabBarClick = false;
  bool isLoadingMore = false;
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _bloc = MainBloc();
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
    _scrollController.addListener(() {
      final maxExtent = _scrollController.position.maxScrollExtent;
      final currentExtent = _scrollController.offset;
      const threshold = 50.0;
      if (maxExtent - currentExtent <= threshold) {
        _getMoreData();
      }
    });
  }

  void _getData() {
    isLoading?.add(true);
    offset = 0;
    _bloc.groupedTasks = {};
    _bloc.add(GetTodoListEvent(offset: offset, status: selectedTab));
  }

  void _getMoreData() {
    if ((_bloc.state.taskResponse?.pageNumber ?? 0) < (_bloc.state.taskResponse?.totalPages ?? 0) - 1) {
      if (!isLoadingMore) {
        isLoadingMore = true;
        offset += 1;
        _bloc.add(LoadMoreTodoListEvent(offset: offset, status: selectedTab));
      }
    }
  }

  void _blocListener(BuildContext context, MainState state) {
    if (state.status is StateSuccess) {
      errorType = null;
      isLoading?.add(false);
      isLoadingMore = false;
      if ((state.taskResponse?.tasks?.length ?? 0) > 0) {
        _bloc.groupItemsByDate(state.taskResponse?.tasks);
      }
    } else if (state.status is StateFail) {
      isLoading?.add(false);
      String? message = (state.status as StateFail).errorMessage;
      setState(() {
        if (message == AppString.ERROR_INTERNET) {
          errorType = ErrorType.internet;
        } else {
          errorType = ErrorType.server;
        }
      });
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
                child: _buildUI(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUI() {
    return Column(
      children: [
        Stack(
          children: [
            _headerBackground(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _settingIcon(),
                  _title(),
                  _tabBar(),
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

  Widget _headerBackground() {
    return Positioned.fill(
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: const BoxDecoration(
          color: AppColor.lightViolet,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
        ),
      ),
    );
  }

  Widget _settingIcon() {
    return GestureDetector(
      onTap: () {
        AppDependency.instance.navigatorCoordinate.goToSettingScreen(context);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 16, bottom: 16),
        alignment: Alignment.topRight,
        child: const Icon(
          Icons.settings,
          color: AppColor.grey,
        ),
      ),
    );
  }

  Widget _title() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 8),
          child: const Text(
            "Hi! User",
            style: TextStyle(
              color: AppColor.darkGrey,
              fontSize: 40,
              fontFamily: AppString.FONT_FAMILY_BOLD,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 8, top: 8),
          child: const Text(
            "Have a nice day.",
            style: TextStyle(
              color: AppColor.darkGrey,
              fontSize: 24,
              fontFamily: AppString.FONT_FAMILY_BOLD,
            ),
          ),
        )
      ],
    );
  }

  Widget _tabBar() {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      height: 50,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: AppColor.moreLightGrey),
      child: TabBar(
        controller: _tabController,
        onTap: (index) {
          isTabBarClick = true;
        },
        splashFactory: NoSplash.splashFactory,
        indicatorPadding: const EdgeInsets.all(8),
        indicator: BoxDecoration(
          gradient: const LinearGradient(
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
        tabs: const [
          Tab(
            child: Text(
              "To-do",
              style: TextStyle(
                fontSize: 22,
                fontFamily: AppString.FONT_FAMILY_MEDIUM,
              ),
            ),
          ),
          Tab(
            child: Text(
              "Doing",
              style: TextStyle(
                fontSize: 22,
                fontFamily: AppString.FONT_FAMILY_MEDIUM,
              ),
            ),
          ),
          Tab(
            child: Text(
              "Done",
              style: TextStyle(
                fontSize: 22,
                fontFamily: AppString.FONT_FAMILY_MEDIUM,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabBarView() {
    return BlocBuilder<MainBloc, MainState>(
      buildWhen: (o, n) => true,
      builder: (context, state) {
        return errorType == null
            ? isLoading?.value == false
                ? _bloc.groupedTasks.isEmpty
                    ? _emptyView()
                    : _listView(state)
                : Container()
            : errorType == ErrorType.internet
                ? _networkErrorView(state)
                : errorType == ErrorType.server
                    ? _errorView(state)
                    : Container();
      },
    );
  }

  Widget _listView(MainState state) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.only(bottom: 24),
      itemCount: _bloc.groupedTasks.length,
      itemBuilder: (context, index) {
        final date = _bloc.groupedTasks.keys.elementAt(index);
        final tasks = _bloc.groupedTasks[date]!;
        return _itemView(state, date, tasks, index);
      },
    );
  }

  Widget _itemView(MainState state, String? date, List<Task>? tasks, int groupIndex) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: tasks?.length,
              itemBuilder: (context, index) {
                var task = tasks?[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    index == 0
                        ? Container(
                            margin: const EdgeInsets.only(top: 30),
                            child: _buildDayView(date),
                          )
                        : Container(),
                    Dismissible(
                      key: Key(task?.id ?? ""),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                        child: Container(margin: const EdgeInsets.only(right: 16), child: const Align(alignment: Alignment.centerRight, child: Icon(Icons.delete, color: Colors.white))),
                      ),
                      confirmDismiss: (DismissDirection direction) async {
                        return await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return _showDialog();
                          },
                        );
                      },
                      onDismissed: (direction) {
                        setState(() {
                          tasks?.removeAt(index);
                        });
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
                      child: _buildTaskItemView(task),
                    ),
                  ],
                );
              })
        ],
      ),
    );
  }

  Widget _buildDayView(date) {
    return Text(
      date ?? "",
      style: const TextStyle(
        color: AppColor.dimBlack,
        fontSize: 24,
        fontFamily: AppString.FONT_FAMILY_BOLD,
      ),
    );
  }

  Widget _buildTaskItemView(task) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          task?.image != null
              ? Image(
            width: 48,
            height: 48,
            image: AssetImage(task!.image!),
          )
              : const SizedBox(
            width: 48,
            height: 48,
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 12),
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
    );
  }

  Widget _showDialog() {
    return AlertDialog(
      title: const Text("Confirm"),
      content: const Text("Are you sure you wish to delete this item?"),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text(
            "DELETE",
            style: const TextStyle(
              color: Colors.red,
              fontSize: 20,
              fontFamily: AppString.FONT_FAMILY_MEDIUM,
            ),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text(
            "CANCEL",
            style: const TextStyle(
              color: AppColor.darkGrey,
              fontSize: 20,
              fontFamily: AppString.FONT_FAMILY_MEDIUM,
            ),
          ),
        ),
      ],
    );
  }

  Widget _emptyView() {
    return ErrorView(
      assetImage: "assets/images/empty_ic.png",
      title: AppString.EMPTY_DATA,
      detail: "",
    );
  }

  Widget _networkErrorView(MainState state) {
    return ErrorView(
      assetImage: "assets/images/internet_error_ic.png",
      title: AppString.ERROR_INTERNET,
      detail: state.status is StateFail ? ((state.status as StateFail).errorMessage ?? "") : "",
      buttonTitle: "Retry",
      onPressed: () {
        _getData();
      },
    );
  }

  Widget _errorView(MainState state) {
    return ErrorView(
      assetImage: "assets/images/error_ic.png",
      title: AppString.ERROR_DEFAULT,
      detail: state.status is StateFail ? ((state.status as StateFail).errorMessage ?? "") : "",
      buttonTitle: "Retry",
      onPressed: () {
        _getData();
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
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
