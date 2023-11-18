class FakeData {
  final data = {
    "title1": "Title",
    "heading": "HackUNC was great",
    "bullet1": "x y z: An overview of the exciting opportunities at HackUNC.",
    "bullet2":
        "y z a: Insights into the creative projects developed during the event.",
    "bullet3":
        "a b c: A look at the networking and collaboration among participants.",
    "bullet4": "b c d: Highlights of the keynote speeches and workshops.",
    "bullet5": "c d e: The impact of HackUNC on local tech communities.",
    "bullet6": "d e f: Future prospects and upcoming events following HackUNC.",
    "bullet7": "x y z: An overview of the exciting opportunities at HackUNC.",
    "bullet8":
        "y z a: Insights into the creative projects developed during the event.",
    "bullet9":
        "a b c: A look at the networking and collaboration among participants.",
    "bullet10": "b c d: Highlights of the keynote speeches and workshops.",
    "bullet11": "c d e: The impact of HackUNC on local tech communities.",
    "bullet12": "d e f: Future prospects and upcoming events following HackUNC."
  };

  final questions = {
    'What is Dart?':
        'Dart is the programming language used to code Flutter apps. Its an object-oriented language developed by Google and used for various applications, including mobile app development.',
    'Is Flutter better than React': 'true',
    'Which is the best database': "Firestore, Realtime Database, MongoDB",
    'What are some similarities between Dart and other programming languages like C# and Java?':
        'Dart shares similarities with languages like C# and Java in terms of its object-oriented nature, single inheritance, and familiar flow control statements like loops and conditions.',
    'How does Dart differ from languages like C# and Java?':
        'Dart differs from C# and Java in several ways, including type inference (where variable types are inferred by the compiler), default values being null for most data types, and not requiring a return type in method signatures.',
    'What are some unique features of Dart?':
        'Dart has unique features such as treating all data types as objects (including numbers), support for default parameter values in method signatures, and the presence of an inbuilt data type called Runes for dealing with UTF-32 code points.',
    'What are some commonly used Dart libraries?':
        'Some commonly used Dart libraries include dart:core for core functionality, dart:async for asynchronous programming, dart:math for mathematical functions, and dart:convert for converting between different data representations.',
    'How does Flutter utilize Dart in app development?':
        'Flutter uses Dart as its primary language for building applications. Dart is used to create the logic and structure of Flutter apps, leveraging various Flutter-specific libraries for UI elements like Widgets and design patterns such as Material and Cupertino.',
    'What is the role of Widgets in Flutter?':
        'Widgets in Flutter are components used to describe the UI of the app. They can be either Stateful or Stateless, with Stateful widgets rebuilding when their state changes.',
    'How does hot reloading benefit Flutter development?':
        'Hot reloading in Flutter allows developers to see real-time changes in the apps UI without restarting the entire build process. It enhances the development experience by rapidly reflecting code changes.',
    'What is the entry point for a Dart class in Flutter?':
        'The entry point for a Dart class in Flutter is the main() method. This method serves as the starting point for Flutter apps and is where the execution begins.',
    'How can one set up a Flutter app and start development?':
        'To set up a Flutter app, one can follow the Flutter documentation for installing the SDK and preferred IDE, create a new project using commands like Flutter: New Project, configure dependencies in pubspec.yaml, and start building the app logic in Dart files within the lib folder.'
  };

  final solutionCheck =  {
     'amber': 'The entry point for a Dart class is main(), your answer of mainF() is close but not accurate',
     'green': 'Yes, Widgets in Flutter are components that are used to describe the UI of the app. They can be either Stateful or Statless, with Stateful widgets rebuilding when their state changes',
     'red': 'Dart is not the same as C# and Java, it differs from it in several ways including type inference, default values being null for most data types, and so on'
  };
}
