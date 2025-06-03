# 🏗️ Proposition d’architecture — Plateforme de réservation d’événements
## 📌 Hypothèses
La proposition d'architecture logiciel dépends de plusieurs facteurs le budget, le nombre d'utilisateurs, la taile et la maturité de l'équipe etc. Dans notre cas d'étude on va faire les suppositions suivantes:
- nous disposons d'un budget conséquent
- nous comptons plusieurs milliers d’utilisateurs
- nous disposons d'une équipe de 20 à 30 ingénieurs de niveau intermédiaire ou expérimenté

## 🧩 Architecture choisie : Microservices
En se basant sur les hypothéses posés (budget conséquent et maturité de l'équipe) nous pouvons nous permettre d'utiliser une **architecture microservice** pour répondre aux contraintes liés au nombre d'utilisateurs.
### Description détaillé de notre architecture microservice
- Strategie de décomposition: décomposition par domaine métier (capability-based)
- Strategie de gestion des données:
    * Base de données par service
    * API composition pour la récupération des données à travers plusieurs microservice
    * Saga orchestration pour maintenir la consistance des données à travers plusieurs microservice
    * Style de communication entre microservice: Messaging avec l'Idempotent consumer


## 🛠️Composants et Choix de technology

| Composant                | Technologies/Services                  |
| ------------------------ | -------------------------------------- |
| **Cloud Provider**       | AWS                                    |
| **Authentification**     | Keycloak                               |
| **Moteur de recherche**  | Typesense                              |
| **Service Notification** | Node.js + PostgreSQL                   |
| **Service Réservation**  | Node.js + PostgreSQL                   |
| **Service Paiement**     | Java + Stripe + PostgreSQL             |
| **Service Facturation**  | Java + PostgreSQL                      |
| **Application Mobile**   | Kotlin (Android), Swift (iOS)          |
| **Application Web**      | Angular SSR (landing), Angular (admin) |
| **Analytics**            | Google Analytics                       |
| **Monitoring**           | AWS CloudWatch                         |
| **Sécurité**             | AWS Security services                  |

### Provider Cloud : AWS
A mon avis les géants du cloud AWS, Azure, GCP répondent tous à nos besoins. Le choix porte sur le type d'infrastrucute on-premise, cloud ou hybride. Pour notre cas d'étude on va utiliser le cloud avec AWS pour sa flexibilité. Le multicloud est une autre option qu'on ne va pas utiliser pour éviter de tout gérer sois même puisque le budget nous permet d'avoir ce luxe.

### Authentification : keycloak
Puisqu'il s'agit d'un plateform de réservation d’événements il est important de faciliter l'accés à nos service tout en maintenant un bon niveau de sécurité. Il nous faut une technologie qui implémente **oaut2.0** pour permettre à nos utilisateurs de créer un compte et de se connecter à travers leurs comptes existants sur d'autres plateformes. **Keycloak** est un choix incontournable grace à sa robustesse et sa grande communauté.

### Moteur de recherche : Typesense
Un moteur de recherche améliore l'expérience utilisateur grâce aux auto-completions, la recherche poussé comme le Geo-search pour voir les événements à proximité, la Semantic search  etc. Notre choix ce porte sur **Typesense** puisqu'il est opensource et plus léger que la pluspart des moteurs de recherche comme elasticsearch et propse des fonctionnalités intéressantes comme le Long-term memory pour les LLMs et la visualisation des donnés comme les graphes et les tableaux. 

### Service de notification: Novu
La notification est un point important pour cette plateform c'est pourquoi on a opter une infrastructure de notification qui regroupe tous les canaux: in-app, email, chat, push-notification, SMS etc. **Novu** est choix pertinent puisqu'il est opensource et permet de définir des workflows qui peuvent être vu comme des pipelines CI/CD pour la notification ce qui rend les notifications pertinantes, customisées et ciblées.

### service de reservation: go + PostgreSQL
Le service de réservation 

### composant UI partagés: storybook
### application mobile :  Kotlin et  swift
### application web: landing page (angular SSR) 
### application web: admin-dashboard (angular)
### service de paiement : Java + stripe + PostgreSQL
### service de facturation : Java + PostgreSQL
### system de monitoring: AWS monitoring 
### system de securite : AWS security 
### analytics:  Google Analytics 
