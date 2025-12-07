#show link:underline

= Exohabit — Wstępna dokumentacja

== Opis projektu

Habit tracker, ale za każdym razem gdy wykonamy zadanie odblokowuje się nowa planeta.
Możemy przeglądać dane o odblokowanych planetach
(pobierane z #link("https://exoplanetarchive.ipac.caltech.edu/")[NASA exoplanet api]).

== User stories
Jako użytkownik mogę:

- stworzyć konto/zalogować się aby mieć dostęp do danych na różnych urządzeniach
- stworzyć nowy nawyk i ustawić jego własności (np. czytać książkę _codziennie_ przez _godzinę_)
- edytować/usuwać istniejące nawyki
- zobaczyć odblokowane planety
- zobaczyć informacje o planecie (promień, średnia temperatura, rok odkrycia, ...)
- zobaczyć statystyki dla danego nawyku i ogólne

== Desired optional requirements
- support dla mobile, web, desktop
- logowanie (prawdopowobnie firebase)
- custom painting (planety)
- offline data persistance
