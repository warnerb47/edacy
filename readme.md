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
    * Pour les requêtes cross-service: API composition + Saga orchestration
    * Style de communication entre microservice: Messaging avec l'Idempotent consumer
- Strategie de deployment:
    * service per container
    * canary releases

## 🛠️Composants et Choix de technology

| Composant                | Technologies/Services                  |
| ------------------------ | -------------------------------------- |
| **Cloud Provider**       | AWS                                    |
| **Authentification**     | Keycloak                               |
| **Moteur de recherche**  | Typesense                              |
| **Service Notification** | Novu                                   |
| **Service Réservation**  | Go + PostgreSQL                        |
| **Service Paiement**     | Java + Stripe + PostgreSQL             |
| **Application Mobile**   | Flutter                                |
| **Application Web**      | Angular SSR (landing), Angular (admin) |
| **Data visualization**   | Metabase                               |
| **Monitoring**           | AWS CloudWatch                         |
| **Sécurité**             | AWS WAF                                |

### Provider Cloud : AWS
A mon avis les géants du cloud AWS, Azure, GCP répondent tous à nos besoins. Le choix porte sur le type d'infrastrucute on-premise, cloud ou hybride. Pour notre cas d'étude on va utiliser le cloud avec AWS pour sa flexibilité. Le multicloud est une autre option qu'on ne va pas utiliser pour éviter de tout gérer sois même puisque le budget nous permet d'avoir ce luxe.

### Authentification : keycloak
Puisqu'il s'agit d'un plateform de réservation d’événements il est important de faciliter l'accés à nos service tout en maintenant un bon niveau de sécurité. Il nous faut une technologie qui implémente **oaut2.0** pour permettre à nos utilisateurs de créer un compte et de se connecter à travers leurs comptes existants sur d'autres plateformes. **Keycloak** est un choix incontournable grace à sa robustesse et sa grande communauté qui surpasse des alternatives comme **AWS Cognito**.

### Moteur de recherche : Typesense
Un moteur de recherche améliore l'expérience utilisateur grâce aux auto-completions, la recherche poussé comme le Geo-search pour voir les événements à proximité, la Semantic search  etc. Notre choix ce porte sur **Typesense** puisqu'il est opensource et plus léger que la pluspart des moteurs de recherche comme elasticsearch et propse des fonctionnalités intéressantes comme le Long-term memory pour les LLMs et la visualisation des donnés comme les graphes et les tableaux. 

### Service de notification: Novu
La notification est un point important pour cette plateform c'est pourquoi on a opter une infrastructure de notification qui regroupe tous les canaux: in-app, email, chat, push-notification, SMS etc. **Novu** est choix pertinent puisqu'il est opensource et permet de définir des workflows qui peuvent être vu comme des pipelines CI/CD pour la notification ce qui rend les notifications pertinantes, customisées et ciblées.

### service de reservation: go + PostgreSQL
Le service de réservation fait parti des microservices critiquent qui peuvent connaitre des pics de connexion il doit être performant et scalable c'est pourquoi on utilise le langage go qui est trés performant. Une base de données postgres permet d'appliquer des contrôles d'intégrité ce qui renforce la cohérance des données.

### service de paiement : Java + stripe + PostgreSQL
Le service de paiement est un microservice trés sensible c'est pourquoi on a opté pour java et prostgres des technologies robustes, largement utilisés et trés facile à intégrer avec des solutions existants. **Stripe** est une infrastructure financière trés flexible, facile à prendre en main et adapté pour notre modéle economique.

### application web: landing page (angular SSR)
Pour le landing page il faut optimiser nos métriques **Core Web Vitals** c'est pourquoi on va utiliser une technologie qui intégre le SSR (Server side rendering), le lazy loading, le caching ce qui est disponible avec **Angular**. L'utilisation des CDN permet aussi d'améliorer les performances.

### application web: admin-dashboard (angular)
L'interface des organisateurs sera une application web qui peut grandir en complexité (dashboard, gestion de comptes, notifications, comptabilité, etc) il faut utiliser une technologie qui a un ecosystéme complet, une structure rigoureuse et un state management robuste. **Angular** est un bon choix puisqu'il répond a toutes ces critéres contraire à des alternatives comme **React** qui n'offre pas une structure rigoureuse et laisses le choix au développeur.

### application mobile :  Flutter
L'application mobile permettra de reserver pour un évènement et sera pour le grand public l'idéal c'est quelle tourne sur le maximum de plateforme (IOS, Android, HarmonyOS, etc). C'est pourquoi on a choisi **Flutter**.

### Application web Datavisualization: Metabase
Pour l'interface des organisateurs il est interessant de mettre en place des dashboards pour la prise de décision. **Metabase** est un bon outil opensource pour générer des dashboards il est trés léger et peut se connecter à plusieurs source de données.

### system de cache: Redis:
Pour les services métiers il faut mettre en place un système de cache. Notre choix sera **Redis** qui est flexible, performant et dispose d'une grande communauté.

### system de monitoring avec AWS
Pour le monitoring on va utiliser CloudWatch qui est mis à disposition par AWS. Le but c'est d'éviter de tout faire sois même en délégant le monitoring au provider Cloud. **CloudWatch** offre beaucoup d'avantage comme l'automatisation du scaling grace aux seuils et aux actions, le systeme d'alerte, etc.

### Securite de l'infrastructure avec AWS
AWS met à disposition plusieurs service pour la sécurité à plusieurs niveau (application, reseau, accés, etc) parmi les outils essentiels on peut cité **AWS WAF**, AWS KMS, et AWS Secrets Manager.

### CI/CD et Déploiement
Pour le CI/CD **GitHub Actions**
