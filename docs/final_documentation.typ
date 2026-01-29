#set text(lang: "pl")
#show link:underline

= Exohabit -- dokumentacja

== Opis

Habit tracker, gdzie po wykonaniu nawyków użytkownik "odblokowuje" nowe planety.

Dane o planetach są brane z #link("https://exoplanetarchive.ipac.caltech.edu/")[Nasa Exoplanet Archive].

Aplikację można używać na wielu urządzeniach, po założeniu konta wszystkie dane są synchronizowane. Jednocześnie aplikację można używać offline i zsynchronizować dane po uzyskaniu połączenia, lub całkowicie bez zakładania konta.

== Użyte technologie

- Flutter
- Riverpod -- state management oraz dependency injection
- GoRouter -- nawigacja
- Drift -- lokalna baza danych (sqlite), potrzebna aby aplikacja działała offlne.
- Supabase -- autentykacja i relacyjna baza danych

== Zrealizowane opcjonalne wymagania

- Support dla mobile (android), desktop i web
- Animacje -- w tym customowe animacje obrotu planet (związane z ich rzeczywistymi danymi fizycznymi)
- Autentykacja (Supabase)
- Custom painting - planety
- Local data persistence (offline)
- Deploy -- przez github pages: https://freeplacki.github.io/Exohabit/

== Schemat bazy danych

#image("supabase_schema.png")

Z każdym użytkownikiem powiązane są jego nawyki, ukończenia nawyków i nagrodzone planety. Dodatkowo tabela Exoplanets zawiera zcacheowane dane z NASA.

== Użycie

Przeglądarkowa wersja dostępna jest pod: https://freeplacki.github.io/Exohabit/

Można skorzystać z konta testowego (z przykładowymi danymi):\
email: `test@example.com`, hasło: `testpassw`

=== Kompilacja

```bash
$ dart run build_runner watch -d
$ flutter run
```