workspace {

    model {
        visitor = person "Visiteur" "Personne consultant les événements disponibles"
        user = person "Utilisateur" "Personne créant un compte pour réserver des événements"
        organizer = person "Organisateur" "Personne ou entreprise créant et gérant des événements"

        bookingSystem = softwareSystem "Plateforme de Réservation d'Événements" "Permet de découvrir, réserver et gérer des événements" {
            tags "System"
        }

        stripe = softwareSystem "Stripe" "Système de paiement externe" {
            tags "External System"
        }
        oauth = softwareSystem "Providers OAuth" "Google, Facebook, Apple pour l'authentification" {
            tags "External System"
        }
        smsProvider = softwareSystem "Fournisseur SMS" "Envoi de notifications SMS" {
            tags "External System"
        }
        emailProvider = softwareSystem "Fournisseur Email" "Envoi d'emails transactionnels" {
            tags "External System"
        }

        visitor -> bookingSystem "Consulte les événements"
        user -> bookingSystem "S'inscrit, se connecte, réserve des billets"
        organizer -> bookingSystem "Crée et gère des événements, consulte les statistiques"

        bookingSystem -> stripe "Processus les paiements"
        bookingSystem -> oauth "Authentification sociale"
        bookingSystem -> smsProvider "Envoie des notifications SMS"
        bookingSystem -> emailProvider "Envoie des emails de confirmation"
    }

    views {
        systemContext bookingSystem "DiagrammeDeContexte" {
            include *
            autolayout lr
        }

        theme default
    }
}