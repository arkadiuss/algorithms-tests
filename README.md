# Algorithms tests
System for testing solutions from algorithmic contests.


## Instrukcja (PL)

### Struktura testu
- Wszystkie pliki powinny być w jednym folderze (na potrzeby przykładu jego nazwa to tests)
- Każdemu tworzonemu testowi osobny podfolder o nazwie zgodnej z nazwą programu (np. tests/counter)
- W każdym folderze danego testu znajdują się foldery: in, out, usertests, prog, brute, checker
        - in - folder do którego generowane są testy (<nazwa><nr_testu>.in)
        - out - folder do którego generowane są testy zarówno z bruta jak i z programu testowanego (<nazwa><nr_testu>.                         <prog|brute>.out
        - usertests - folder zawierający testy które użytkownik może wrzucić i nie będą zmieniane (testy z forum, ciekawsze                           testy). Jest tu zarówno in jak i prawidłowa (lub nie) odpowiedź (<nazwa><nr_testu>.in i <nazwa>                                 <nr_testu>.out)
        - prog - folder zawierający testowany program (<nazwa>.cpp)
        - brute - folder zawierający brute(<nazwa>.cpp)
        - checker - folder zawierający program sprawdzający poprawność wygenerowanej odpowiedzi
  
  Przykładowa stuktura na jakiej system był używany:
  
  - algorithmics
      - OI 
          - counter.cpp
          - counter_brute.cpp
          - metro_plan.cpp
          - metro_checker.cpp
      - AMPPZ
          - graphs.cpp
          - graphs_brute.cpp
      - tests
          - counter
              - in
              - out
              - prog
              - brute
              - usertests
          - metro_plan
              - in
              - out
              - checker
              - prog
            
### Podprogramy
System zawiera kilka podprogramów ułatwiających tworzenie testu:
- newtest.sh : skrypt pozwalający na stworzenie wymaganej struktury testu
               argumenty: nazwa_testu [ścieżka_do_rogramu] [ścieżka_do_bruta] [ścieżka_do_checkera]
               przykład: ./newtest.sh counter OI/counter.cpp OI/counter_brute.cpp
               UWAGA! Ścieżki do testu muszą być podane względem folderu nadrzędnego do tests
- update.sh : program automatycznie kopiujący program na którym pracujemy do folderu z testami (np. pracujemy na pliku                     OI/counter.cpp po użyciu update jest on kopiowany do test/counter.cpp)
              przykład: ./update,sh counter
              UWAGA! Działa tylko jeśli test był stworzony na pomocą newtest.sh i miał podane argumenty ścieżek
- checkProg.sh : program testujący rozwiązanie i porównujący odpowiedzi z programu i bruta dla każdego testu lub sprawdzający                  je za pomocą checkera
                 argumenty: nazwa_programu liczba_testów mode
                 mode: 1 - porównywanie odpowiedzi z programu i bruta, 2 - sprawdzanie odpowiedzi za pomocą checkera
                 przykład: ./checkProg.sh counter 100 1
                 
### Generowanie in'ów
W każdym folderze z testem musi byc zawarty plik makeIn.cpp zawierający funkcję void makeIn(int,fstream*), ta funkcja odpowiada za generowanie każdego testu (int zawiea nr testu, fstream* plik do którego się go wypisuje). Przykładem jest plik makeIn_template.cpp który jest również kopiowany podczas wywoałania ./newtest.sh. Plik ten jest dołączany podczas kompilacji generatorki testów i odpowiada za generowanie testów do porównania.
               
