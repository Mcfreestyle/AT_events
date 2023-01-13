import 'package:at_events/models/category_model.dart';
import 'package:at_events/routes/route.dart';
import 'package:at_events/services/category_service.dart';
import 'package:at_events/services/event_service.dart';
import 'package:at_events/ui/theme/colors.dart';
import 'package:at_events/ui/widgets/card_widget.dart';
import 'package:at_events/ui/views/explorer/widgets/category_widget.dart';
import 'package:at_events/ui/views/explorer/widgets/tab_widget.dart';
import 'package:at_events/ui/widgets/floating_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    print('building ExploreView');
    final eventService = context.read<EventService>();
    eventService.eventsByCategory.clear();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            'Explore',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold, fontSize: 25,
              //fontSize: 34.0,
              //letterSpacing: 3,
            ),
          ),
          actions: [
            SizedBox(
              width: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingButtonWidget(
                    type: 'secondary',
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      Navigator.pushNamed(context, MyRoutes.rSEARCH);
                    },
                  ),
                  FloatingButtonWidget(
                    type: 'secondary',
                    icon: Transform.rotate(
                      angle: 0.6,
                      child: const Icon(
                        Icons.navigation_rounded,
                      ),
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      body: ExploreViewBody(),
    );
  }

  ButtonStyle _styleIconButton() {
    return ButtonStyle(
      shape: MaterialStateProperty.all(const CircleBorder()),
      backgroundColor: MaterialStateProperty.all(Colors.white),
      shadowColor: MaterialStateProperty.all(MyColor.secondary),
      elevation: MaterialStateProperty.all(3.5),
    );
  }
}

class ExploreViewBody extends StatelessWidget {
  const ExploreViewBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('building BodyWidget of ExploreView');
    final categoryService = context.watch<CategoryService>();
    final categories = categoryService.categories;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /*  tab events  */
          const SizedBox(
            width: double.infinity,
            child: TabEvents(),
          ),
          EventsByCategory(categories: categories),
          /*  */
        ],
      ),
    );
  }
}

class EventsByCategory extends StatefulWidget {
  const EventsByCategory({super.key, required this.categories});

  final List<Category> categories;

  @override
  State<EventsByCategory> createState() => _EventsByCategoryState();
}

class _EventsByCategoryState extends State<EventsByCategory> {
  List<bool> selectedCategories = [];
  bool isLoading = false;

  @override
  void initState() {
    print('categories: ${widget.categories}');
    _reseatSelectedCategories();
  }

  _reseatSelectedCategories() {
    selectedCategories.clear();
    for (Category category in widget.categories) {
      selectedCategories.add(false);
    }
  }

  Future getEventsByCategory(EventService eventService, int categoryId) async {
    setState(() {
      isLoading = true;
    });
    await eventService.showEventsByCategory(categoryId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final categoryService = context.read<CategoryService>();
    // final categories = categoryService.categories;
    final eventService = context.read<EventService>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            'Categorias',
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.categories.length,
            itemBuilder: (context, index) {
              final category = widget.categories[index];

              return CatEvent(
                icon: Image.asset(
                  'assets/icons/${category.name}.png',
                  color: selectedCategories[index]
                      ? MyColor.primary
                      : Colors.grey[400],
                ),
                text: Text(
                  category.name!,
                  style: TextStyle(
                      color: selectedCategories[index]
                          ? MyColor.primary
                          : Colors.grey[400]),
                ),
                onTap: () async {
                  setState(() {
                    _reseatSelectedCategories();
                    selectedCategories[index] = true;
                  });
                  getEventsByCategory(eventService, category.id!);
                },
              );
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 10, top: 10),
          child: Text(
            'Eventos',
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),
        ),
        /* lista de eventos */
        (isLoading == false)
            ? ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: eventService.eventsByCategory.length,
                itemBuilder: (context, index) {
                  final event = eventService.eventsByCategory[index];

                  return CardEvent(
                    title: event.name!,
                    date: event.date!,
                    place: event.place!,
                    interested: event.interested!,
                    uint8Image: event.uint8Image!,
                    onTap: () {
                      eventService.selectedEvent = event;
                      Navigator.pushNamed(context, MyRoutes.rEVENT);
                    },
                  );
                },
              )
            : Container(
                margin: EdgeInsets.only(top: 20),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
      ],
    );
  }
}


// CategoriesList(
//               categories: categoryService.categories,
//               eventService: eventService)

// class CategoryIcon extends StatefulWidget {
//   const CategoryIcon({
//     Key? key,
//     required this.category,
//     required this.eventService,
//   }) : super(key: key);

//   final Category category;
//   final EventService eventService;

//   @override
//   State<CategoryIcon> createState() => _CategoryIconState();
// }

// class _CategoryIconState extends State<CategoryIcon> {
//   bool isSelected = false;

//   @override
//   Widget build(BuildContext context) {
//     return CatEvent(
//       icon: Image.asset(
//         'assets/icons/${widget.category.name}.png',
//         color: isSelected ? MyColor.primary : MyColor.accent,
//       ),
//       text: Text(widget.category.name!),
//       onTap: () async {
//         setState(() {
//           isSelected = true;
//         });
//         await widget.eventService.showEventsByCategory(widget.category.id!);
//       },
//     );
//   }
// }
