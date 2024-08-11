# 2024-project-phase-mobile-tasks
This repository contains the mobile task management framework for the 2024 project phase. It is designed to streamline task organization, enhance collaboration, and improve productivity for mobile development teams.

 This app follows a layered architecture pattern, consisting of three main layers: presentation, domain, and data.
 
 Architecture:
    Presentation Layer: Responsible for handling user interactions and displaying the user interface.
    Domain Layer: Contains the business logic and rules of the application.
    Data Layer: Handles data storage, retrieval, and manipulation.

 Data Flow:
    User interacts with the app through the presentation layer.
    Presentation layer communicates with the domain layer to perform business logic operations.
    Domain layer interacts with the data layer to view all products, view single Product, create products, delete products or update products.
    Data layer communicates with external data sources and internal data source, such as databases or APIs, to retrieve or store data.
 