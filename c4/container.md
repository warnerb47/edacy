```mermaid
graph TD
    Web[Application Web SSR] --> Gateway[API Gateway]
    Mobile[Application Mobile] --> Gateway
    Admin[Dashboard Admin] --> Gateway

    Gateway --> Auth[Service Authentification]
    Gateway --> Orchestrator[Saga Orchestrator]
    Orchestrator --> Reservation[Service de Réservation]
    Orchestrator --> Event[Service de Gestion d'Événements]
    Orchestrator --> Payment[Service de Paiement]
    Orchestrator --> Notify[Service de Notification]
    Gateway --> Search[Moteur de Recherche Typesense]
    Gateway --> LLM[Systéme de recommandation ]
```
