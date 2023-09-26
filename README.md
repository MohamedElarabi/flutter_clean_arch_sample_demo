# Clean Architecture for Flutter

This a sample app that implement Uncle Bob's Clean Architecture in Flutter.

There are 3 main Layers to help separate the code:

- Domain.
- Data.
- Presentation.

Domain Layer: defines the business logic of the application and contains UseCases, Domain Entities, and Repository Interfaces.

Data Layer: responsible for data retrieval and contains APIs, Local Storage, Data objects (Request, Response and DB objects), and the Repository Implementation.

Presentation the UI of the application and contains Screens, Widgets and Presentation logic.

## Libraries



A few resources to get you started if this is your first Flutter project:

- [Dio](https://pub.dev/packages/dio)
- [Equatable](https://pub.dev/packages/equatable)
- [Dartz](https://pub.dev/packages/dartz)
- [Flutter_bloc](https://pub.dev/packages/flutter_bloc)
- [get_it](https://pub.dev/packages/get_it)
