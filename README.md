# Pascal code formatter (lab 10.2)

## Алгоритм работы:
* 1 - Чтение символа
* 2 - Проверка символа:
    * Если символ - **кавычка**, то мы переключаем в случае необходимости флаг *ReadingQuotes* и выводим этот символ
    * Если флаг *ReadingQuotes* в состояние **T**rue, то выводим символ (мы не форматируем код внутри кавычек)
    * Если символ - **пробел**, то мы проверяем, прочитали ли мы BEGIN, и пропускаем этот символ
    * Если символ - **запятая**, то мы должны будем поставить пробел позднее (с помощью флага *ShouldAddSpace*), выводим запятую
    * Если символ - **точка с запятой**, то мы должны будем вывести её, если она не лишняя позже (с помощью флага *ReadSemicolomn*)
    * Если символ - **буква E**, то мы читаем следующие 3 символа, чтобы проверить, конец ли у нас кода (*END.*). Если это не конец, то выводим прочитанные символы, иначе выводим *END.*
    * Если любой другой символ - то мы проверяем, надо ли поставить пробел (после запятой с помощью флага *ShouldAddSpace*), надо ли поставить точку с запятой и перенести строчку (с помощью флага *ReadSemicolomn*). Обнуляем все флаги и выводим символ.
* 3 - Возвращение в шаг 1, если последний прочитанный символ не точка.
