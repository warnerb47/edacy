```mermaid
graph TD
    visitor[Visiteur] -->|Consulter les événements disponibles| Platform[Plateforme de Réservation]
    User[Utilisateur] -->|Réserve un événement| Platform
    Admin[Administrateur] -->|Gérer la plateforme| Platform
    Organizer[Organisateur] -->|Gère les événements| Platform
    Platform -->|payer| stripe[Stripe]
    Platform -->|envoie de sms| sms[Fournisseur SMS]
    Platform -->|envoie d'email| email[Fournisseur Email]
    Platform -->|s'authentifier avec| oauth[Providers OAuth]
```