PROGRAM CodeFormatting(INPUT, OUTPUT);
VAR
  Ch, PrevCh, EndCh, EndCh2, EndCh3: CHAR; {Символы, которые мы будем считывать. EndCh-3 для проверки на End.}
  ReadingQuotes, ShouldAddSpace, ReadSemicolomn, ReadBegin, AnyContent: CHAR; {BOOLEAN-флаги}
BEGIN
  Ch := '&';             {Основной символ для чтения}
  ReadingQuotes := 'F';  {Находимся ли мы внутри ковычек}
  ShouldAddSpace := 'F'; {Должны ли мы добавить пробел (после запятой)}
  ReadSemicolomn := 'F'; {Прочитали ли мы точку с запятой}
  ReadBegin := 'F';      {Прочитали ли мы BEGIN}
  AnyContent := 'F';     {Есть ли у нас код помимо BEGIN END.}
  WHILE (Ch <> '.') OR (ReadingQuotes = 'T') {Читаем до точки ВНЕ ковычек}
  DO
    BEGIN
      PrevCh := Ch;
      READ(Ch);
      IF ReadingQuotes = 'T' {Если мы внутри ковычек - пишем код без форматирования}
      THEN
        BEGIN
          WRITE(Ch);
          IF Ch = ''''
          THEN
            ReadingQuotes := 'F'
        END
      ELSE IF Ch = ''''
      THEN
        BEGIN
          ReadingQuotes := 'T';
          WRITE(Ch)
        END
      ELSE
        BEGIN
          IF Ch <> ' ' {Пропускаем пробелы, так как мы их расставляем сами}
          THEN
            IF Ch = ',' {После запятой мы должны будем поставить пробел}
            THEN
              BEGIN
                ShouldAddSpace := 'T';
                WRITE(Ch)
              END
            ELSE IF Ch = ';'
            THEN
              ReadSemicolomn := 'T'
            ELSE
              BEGIN
                IF Ch = 'E' {Проверяем следующие 3 символа на то, если они вместе с Ch образуют END.}
                THEN
                  BEGIN
                    READ(EndCh, EndCh2, EndCh3);
                    WHILE EndCh3 = ' ' {Между точкой и END могут быть пробелы - избавляемся от них}
                    DO
                      READ(EndCh3);
                    IF EndCh3 = '.' {Если последний символ - точка, то это конец программы}
                    THEN
                      BEGIN
                        Ch := EndCh3;
                        IF AnyContent = 'T'
                        THEN
                          WRITELN;
                        WRITELN('END.')
                      END
                    ELSE {Если же последний символ не точка, то выведем символы, которые мы успели прочитать}
                      BEGIN
                        WRITE(Ch, EndCh, EndCh2, EndCh3);
                        Ch := EndCh3 {Для корректного присвоения PrevCh после}
                      END
                  END
                ELSE
                  BEGIN
                    IF ShouldAddSpace = 'T'
                    THEN
                      WRITE(' ')
                    ELSE IF (ReadSemicolomn = 'T') AND (AnyContent = 'T') {Проверка на флаг AnyContent для правильного форматирования кода вида 'BEGIN ; END' (с очевидно лишней ';')}
                    THEN
                      BEGIN
                        WRITELN(';');
                        WRITE('  ')
                      END;
                    ShouldAddSpace := 'F';
                    ReadSemicolomn := 'F';
                    IF (ReadBegin = 'T') AND (AnyContent = 'F') {Если мы прочитали BEGIN и есть код, кроме BEGIN и END, то переключаем флаг AnyContent и добавляем первую табуляцию}
                    THEN
                      BEGIN
                        AnyContent := 'T';
                        WRITE('  ')
                      END;
                    WRITE(Ch)
                  END
              END
          ELSE IF (PrevCh = 'N') AND (ReadBegin = 'F') {Прочитали ли мы BEGIN}
          THEN
            BEGIN
              ReadBegin := 'T';
              WRITELN
            END
        END        
    END
END.