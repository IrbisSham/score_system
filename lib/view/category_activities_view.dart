import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:score_system/bloc/category_activity_bloc.dart';
import 'package:score_system/bloc/category_activity_state.dart';
import '../locator.dart';
import '../stream/custom_stream_builder.dart';
import '../widget/column_spacer.dart';
import '../widget/widget_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart' show Provider;

class CategoryActivitiesView extends StatefulWidget {
  const CategoryActivitiesView({Key? key}) : super(key: key);

  @override
  _CategoryActivitiesViewState createState() => _CategoryActivitiesViewState();
}

class _CategoryActivitiesViewState extends State<CategoryActivitiesView> {
  late CategoryActivityBloc categoryActivityBloc;

  @override
  void initState() {
    super.initState();
    categoryActivityBloc = locator<CategoryActivityBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return CustomStreamBuilder<CategoryActivityState>(
      builder: (context, model) {
        final state = model.state;
        if (state == States.loading) {
          return const _Loading();
        } else if (state == States.empty) {
          return const _Empty();
        } else if (state == States.error) {
          return const _Error();
        } else if (state == States.init) {
          return const _Init();
        } else if (state == States.populated) {
          // If accesed the state here, throws an error
          return const _DisplayWidget();
        }
        return const _Internal();
      },
      initialData: CategoryActivityInit(CategoryActivityBloc.INIT_CATEGORY_ENTITY_RESULT),
      stream: categoryActivityBloc.state,
    );
  }

}

class _Error extends StatelessWidget {
  const _Error({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ColumnSpacer(
        children: const [_Internal(), SearchErrorWidget()],
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ColumnSpacer(
        children: const [_Internal(), EmptyWidget()],
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ColumnSpacer(
        children: const [LoadingWidget(), _Internal()],
      ),
    );
  }
}

class _Init extends StatelessWidget {
  const _Init({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<CategoryActivityState>(context);
    final results = (state as CategoryActivityInit).result;

    return SingleChildScrollView(
      child: Column(
        children: [
          _Internal(),
          CategoryActivitiesResultWidget(items: results.items)],
      ),
    );
  }
}

class _DisplayWidget extends StatelessWidget {
  const _DisplayWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<CategoryActivityState>(context);
    final results = (state as CategoryActivityPopulated).result;

    return SingleChildScrollView(
      child: Column(
        children: [
          _Internal(),
          CategoryActivitiesResultWidget(items: results.items)],
      ),
    );
  }
}

class _Internal extends StatelessWidget {
  const _Internal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = locator<CategoryActivityBloc>();
    return Center(
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'CategoryActivitiesView.Hint'.tr(),
        ),
        style: const TextStyle(
          fontSize: 36.0,
          decoration: TextDecoration.none,
        ),
        onChanged: bloc.onTextChanged.add,
      ),
    );
  }
}