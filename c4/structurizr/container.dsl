workspace {

    model {
        // People
        visitor = person "Visiteur" "Personne consultant les événements disponibles"
        user = person "Utilisateur" "Personne créant un compte pour réserver des événements"
        organizer = person "Organisateur" "Personne ou entreprise créant et gérant des événements"

        // External systems
        stripe = softwareSystem "Stripe" "Passerelle de paiement" {
            tags "External System"
        }
        smsProvider = softwareSystem "Fournisseur SMS" "Twilio" {
            tags "External System"
        }
        oauthProviders = softwareSystem "Providers OAuth" "Google, Facebook, Apple pour l'authentification" {
            tags "External System"
        }
        emailProvider = softwareSystem "Fournisseur Email" "Envoi d'emails transactionnels" {
            tags "External System"
        }

        // Main booking platform system
        bookingPlatform = softwareSystem "Plateforme de Réservation" {
            // Frontend containers
            webApp = container "Application Web" "Angular" "Frontend principal"
            mobileApp = container "Application Mobile" "Flutter" "Frontend mobile"

            // API layer
            apiGateway = container "API Gateway" "Java" "Gestion des requêtes externes"
            
            // Services
            authService = container "Service Authentification" "Keycloak" "Gestion des identités"
            bookingService = container "Service Réservation" "Go" "Gestion des réservations"
            paymentService = container "Service Paiement" "Java" "Traitement des paiements"
            notifService = container "Service Notification" "Novu" "Notifications multi-canaux"
            searchService = container "Service Recherche" "Typesense" "Recherche d'événements"
            cacheService = container "Service de Cache" "Redis" "Cache des données"
            sagaOrchestrator = container "Orchestrateur Saga" "AWS Step Functions" "Coordonne les transactions distribuées"

            // Databases
            bookingDb = container "Réservation DB" "PostgreSQL" "Stocke les réservations" {
                tags "Database"
            }
            paymentDb = container "Paiement DB" "PostgreSQL" "Stocke les transactions financières" {
                tags "Database"
            }
        }

        // Relationships
        // User to frontend
        visitor -> webApp "consulter les événements" "HTTPS"
        user -> webApp "Réserve des événements" "HTTPS"
        organizer -> webApp "Gère les événements" "HTTPS"
        
        visitor -> mobileApp "consulter les événements" "HTTPS"
        user -> mobileApp "Réserve des événements" "HTTPS"
        organizer -> mobileApp "Gère les événements" "HTTPS"

        // Frontend to API
        webApp -> apiGateway "Créer réservation" "GraphQL"
        mobileApp -> apiGateway "Créer réservation" "GraphQL"

        // API Gateway to services
        apiGateway -> sagaOrchestrator "Créer réservation" "GraphQL"
        apiGateway -> bookingService "récupérer réservations" "GraphQL"
        apiGateway -> paymentService "récupérer transactions" "GraphQL"
        apiGateway -> notifService "notifier" "REST"
        apiGateway -> authService "s'authentifier" "REST"
        apiGateway -> searchService "rechercher" "REST"
        apiGateway -> cacheService "Read/Write" "GraphQL"

        // Auth service to OAuth
        authService -> oauthProviders "s'authentifier" "REST"
        
        // Saga orchestrator flows
        sagaOrchestrator -> paymentService "Déclenche paiement" "GraphQL"
        sagaOrchestrator -> cacheService "Read/Write" "GraphQL"
        paymentService -> stripe "Processus paiement" "REST"
        
        sagaOrchestrator -> notifService "Déclenche notification" "REST"
        notifService -> smsProvider "Envoie SMS" "REST"
        notifService -> emailProvider "Envoie Email" "REST"
        
        sagaOrchestrator -> bookingService "Confirme réservation" "GraphQL"
        
        // Database interactions
        bookingService -> bookingDb "Read/Write" "SQL"
        paymentService -> paymentDb "Read/Write" "SQL"
        
        // Cache interactions
        bookingService -> cacheService "Read/Write" "GraphQL"
        paymentService -> cacheService "Read/Write" "GraphQL"
    }

    views {
        container bookingPlatform "DiagrammeDeConteneurs" {
            include *
            autolayout tb
        }

        theme default
    }
}