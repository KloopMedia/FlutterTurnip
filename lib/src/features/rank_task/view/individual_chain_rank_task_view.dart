import 'package:flutter/material.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/card/card_with_chip_and_title.dart';
import 'package:go_router/go_router.dart';

import '../../../router/routes/routes.dart';
import '../../../widgets/widgets.dart';

class IndividualChainRankTaskView extends StatefulWidget {
  const IndividualChainRankTaskView({Key? key}) : super(key: key);

  @override
  State<IndividualChainRankTaskView> createState() => _IndividualChainRankTaskViewState();
}

class _IndividualChainRankTaskViewState extends State<IndividualChainRankTaskView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Column(
      children: [
        CardWithTitle(
          onTap: () => context.pushNamed(RankTaskDetailRoute.name),
          // chips: [StatusCardChip(item)],
          title: 'Написать 10 статей на ... тему ',
          body: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Место для описания и условий В данном задании вам предлагается написать статью на выбранную тему. Статьи являются важным средством передачи информаци. Ваша задача состоит в том, чтобы создать информативную и увлекательную статью, которая заинтересует читателей и передаст ключевую информацию о выбранной теме.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: theme.onSurfaceVariant,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 3
              ),
              const SizedBox(height: 20),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        width: 14,
                        height: 14,
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: theme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,//theme.primary
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Container(
                        width: 2,
                        height: 80,
                        decoration: BoxDecoration(
                          color: theme.primary,//neutral80
                          shape: BoxShape.rectangle,
                        ),
                        child: const Text(''),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Прочитать текст и заполнить недостающие буквы',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: theme.neutral40,
                          ),
                          softWrap: true,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Выполнено', //'Ожидает выполнения' //'Невыполнено'
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                              color: theme.tertiary
                          )
                        ),
                        const SizedBox(height: 7),
                        // Row(
                        //   children: [
                        //     Text(
                        //       'Начато: ', //'Закончено: '
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.w400,
                        //         fontSize: 14,
                        //         color: theme.neutral60
                        //       )
                        //     ),
                        //     Text(
                        //       '0', //'Ожидает выполнения' //'Невыполнено'
                        //       style: TextStyle(
                        //           fontWeight: FontWeight.w500,
                        //           fontSize: 16,
                        //           color: theme.primary
                        //       )
                        //     ),
                        //   ],
                        // ),

                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            alignment: Alignment.centerLeft
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Выполнить',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: theme.primary
                                ),
                              ),
                              const SizedBox(width: 5),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: theme.primary,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Divider(height: 1, color: theme.neutral90),
                        )
                      ],
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
        const SizedBox(height: 20),
        CardWithTitle(
          onTap: () => context.pushNamed(RankTaskDetailRoute.name),
          chips: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Необходимо получить ранг:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: theme.neutral60,
                  ),
                ),
                const SizedBox(width: 3),
                Row(
                  children: [
                    Container(
                      width: 32,
                      // margin: const EdgeInsets.only(left: 5),
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: Shadows.elevation3,
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: const Image(image: AssetImage('assets/images/rank_icon_sample.png'))),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Название ранга',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: theme.onSurfaceVariant,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: Alignment.centerLeft
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Получить',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: theme.primary
                          ),
                        ),
                        const SizedBox(width: 5),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: theme.primary,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
          title: 'Написать 10 статей на ... тему ',
          body: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Место для описания и условий В данном задании вам предлагается написать статью на выбранную тему. Статьи являются важным средством передачи информаци. Ваша задача состоит в том, чтобы создать информативную и увлекательную статью, которая заинтересует читателей и передаст ключевую информацию о выбранной теме.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: theme.onSurfaceVariant,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 3
              ),
              const SizedBox(height: 20),

            ],
          ),
        ),
      ],
    );
  }
}
