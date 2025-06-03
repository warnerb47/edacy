```mermaid
---
title: Diagramme de Conteneurs Révisé - Plateforme de Réservation
---
C4Container
    title Diagramme de Conteneurs - Architecture Microservices avec Saga

    Person(visiteur, "Visiteur", "Personne consultant les événements disponibles")
    Person(utilisateur, "Utilisateur", "Personne créant un compte pour réserver des événements")
    Person(organisateur, "Organisateur", "Personne ou entreprise créant et gérant des événements")


    System_Boundary(system, "Plateforme de Réservation") {
        Container(web_app, "Application Web", "Angular", "Frontend principal")
        Container(mobile_app, "Application Mobile", "Flutter", "Frontend mobile")

        Container(api_gateway, "API Gateway", "Java", "Gestion des requêtes externes")
        Container(auth_service, "Service Authentification", "Keycloak", "Gestion des identités")
        
        Container(booking_service, "Service Réservation", "Go", "Gestion des réservations")
        ContainerDb(booking_db, "Réservation DB", "PostgreSQL", "Stocke les réservations")
        
        Container(payment_service, "Service Paiement", "Java", "Traitement des paiements")
        ContainerDb(payment_db, "Paiement DB", "PostgreSQL", "Stocke les transactions financières")
        
        Container(notif_service, "Service Notification", "Novu", "Notifications multi-canaux")
        
        Container(search_service, "Service Recherche", "Typesense", "Recherche d'événements")
        
        Container(saga_orchestrator, "Orchestrateur Saga", "AWS Step Functions", "Coordonne les transactions distribuées")
    }

    System_Ext(stripe, "Stripe", "Passerelle de paiement")
    System_Ext(sms_provider, "Fournisseur SMS", "Twilio")

    Rel(visiteur, web_app, "consulter les événements", "HTTPS")
    Rel(utilisateur, web_app, "Réserve des événements", "HTTPS")
    Rel(organisateur, web_app, "Gère les événements", "HTTPS")
    
    Rel(visiteur, mobile_app, "consulter les événements", "HTTPS")
    Rel(utilisateur, mobile_app, "Réserve des événements", "HTTPS")
    Rel(organisateur, mobile_app, "Gère les événements", "HTTPS")

    Rel(web_app, api_gateway, "Créer réservation", "GraphQL")
    Rel(mobile_app, api_gateway, "Créer réservation", "GraphQL")

    Rel(api_gateway, saga_orchestrator, "Créer réservation", "GraphQL")
    Rel(api_gateway, booking_service, "récupérer réservations", "GraphQL")
    Rel(api_gateway, payment_service, "récupérer transactions", "GraphQL")
    Rel(api_gateway, notif_service, "notifier", "REST")
    Rel(api_gateway, auth_service, "s'authentifier", "REST")
    
    Rel(saga_orchestrator, payment_service, "Déclenche paiement", "gRPC")
    Rel(payment_service, stripe, "Processus paiement", "API")
    
    Rel(saga_orchestrator, notif_service, "Déclenche notification", "gRPC")
    Rel(notif_service, sms_provider, "Envoie SMS", "API")
    
    Rel(saga_orchestrator, booking_service, "Confirme réservation", "gRPC")
    
    Rel(booking_service, booking_db, "Read/Write", "SQL")
    Rel(payment_service, payment_db, "Read/Write", "SQL")

    UpdateLayoutConfig($c4ShapeInRow="3", $c4BoundaryInRow="1")
```
