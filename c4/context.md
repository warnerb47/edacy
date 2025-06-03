```mermaid
graph TD
    User[Utilisateur] -->|Réserve un événement| Platform[Plateforme de Réservation]
    Organizer[Organisateur] -->|Gère les événements| Platform
    Platform -->|Paiements| Stripe[Service de paiement Stripe]
    Platform -->|Authentification| Keycloak[Service d’authentification Keycloak]
    Platform -->|Analyse d’usage| Analytics[Google Analytics]
```