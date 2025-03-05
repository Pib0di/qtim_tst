import 'package:flutter/material.dart';

class AvatarCarousel extends StatefulWidget {
  final List<String> avatarUrls;
  final ValueChanged<int>? onPageChanged;

  const AvatarCarousel({
    super.key,
    required this.avatarUrls,
    this.onPageChanged,
  });

  @override
  State<AvatarCarousel> createState() => _AvatarCarouselState();
}

class _AvatarCarouselState extends State<AvatarCarousel> {
  int currentPage = 0;
  late final PageController pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: currentPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.avatarUrls.isEmpty) {
      return Container(
        color: Colors.grey,
        child: const Center(child: Text('Нет аватарок')),
      );
    }

    return Column(
      children: [
        SizedBox(
          height: 160, // Уменьшаем высоту для индикаторов
          child: PageView.builder(
            controller: pageController,
            itemCount: widget.avatarUrls.length == 1 ? 1 : null,
            itemBuilder: (context, index) {
              final realIndex = index % widget.avatarUrls.length;
              return Center(
                child: ClipOval(
                  child: Image.network(
                    widget.avatarUrls[realIndex],
                    width: 150, // Диаметр круга
                    height: 150,
                    fit: BoxFit.cover, // Обрезаем изображение под круг
                  ),
                ),
              );
            },
            onPageChanged: (int index) {
              widget.onPageChanged?.call(index);

              setState(() {
                currentPage = index % widget.avatarUrls.length;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.avatarUrls.length,
              (index) => Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: currentPage == index ? Colors.blue : Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
