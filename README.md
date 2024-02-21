# Activité 3 de l'ECF finale pour bachelor DevOps

# Mise en place du Monitoring des Spark Jobs et de MongoDB

## Table des matières
1. [Prérequis](#prerequis)
2. [Configuration du Monitoring des Spark Jobs](#monitoring-spark-jobs)
3. [Configuration du Monitoring de MongoDB](#monitoring-mongodb)
4. [Suivi via Cloud9](#suivi-via-cloud9)
5. [Monitoring AWS CloudWatch](#monitoring-aws-cloudwatch)

---

## Prérequis <a name="prerequis"></a>

Avant de commencer, je m'assure de disposer des éléments suivants :
- Accès à un compte AWS avec les autorisations appropriées.
- Terraform installé sur ma machine.
- Connaissance de base de Terraform et AWS.

---

## Configuration du Monitoring des Spark Jobs <a name="monitoring-spark-jobs"></a>

### 1. Créer un cluster Apache Spark avec Amazon EMR
J'utilise Terraform pour créer un cluster Apache Spark avec Amazon EMR. Je m'assure de spécifier le type d'instance approprié, le nombre d'instances, etc.

### 2. Configurer l'Interface Web de Spark (Spark Web UI)
L'interface Web de Spark fournit des informations détaillées sur les jobs Spark en cours d'exécution. Une fois le cluster EMR déployé, j'accède à l'interface Web de Spark à l'URL fournie et je surveille les performances des jobs Spark.

### 3. Configurer d'autres outils de monitoring (optionnel)
En plus de l'interface Web de Spark, je peux configurer d'autres outils de monitoring pour suivre les performances de mes jobs Spark, tels que CloudWatch pour les métriques AWS, Elasticsearch + Kibana pour la visualisation des logs, etc.

---

## Configuration du Monitoring de MongoDB <a name="monitoring-mongodb"></a>

### 1. Créer un cluster MongoDB avec Amazon DocumentDB
J'utilise Terraform pour créer un cluster MongoDB avec Amazon DocumentDB. Je m'assure de spécifier le nombre d'instances, la version du moteur, les identifiants de connexion, etc.

### 2. Configurer le CloudWatch Logs Export
J'active l'exportation des logs CloudWatch pour mon cluster MongoDB. Cela me permettra de surveiller les logs d'audit et de profiler MongoDB via CloudWatch.

### 3. Utiliser des outils de monitoring tiers (optionnel)
En plus du monitoring intégré à Amazon DocumentDB, je peux utiliser des outils tiers tels que MongoDB Compass, Datadog, New Relic, etc., pour surveiller et analyser les performances de mon cluster MongoDB.

---

## Suivi via Cloud9 <a name="suivi-via-cloud9"></a>

Je peux utiliser Cloud9 pour suivre et gérer mes ressources AWS ainsi que mes configurations Terraform. En utilisant l'environnement de développement Cloud9, je peux accéder à mes fichiers Terraform, exécuter des commandes Terraform et surveiller le processus de déploiement en temps réel.

---

En suivant ces étapes, je pourrai mettre en place efficacement le monitoring des Spark Jobs et de MongoDB dans mon environnement AWS, tout en utilisant Cloud9 pour suivre le processus de déploiement.

---
## Monitoring AWS <a name="Monitoring AWS"></a>
Pour configurer le monitoring sur AWS via CloudWatch, je dois effectuer quelques étapes supplémentaires pour activer la collecte de métriques pour les ressources que je souhaite surveiller :

## Pour mes instances EC2 :

Je dois m'assurer que mes instances EC2 ont le service CloudWatch Agent installé et configuré pour collecter des métriques système. Je peux installer le CloudWatch Agent en suivant les instructions fournies par AWS dans la documentation officielle : Installation du CloudWatch Agent sur Amazon EC2 Linux Instances.

## Pour mes clusters EMR :

Amazon EMR publie automatiquement des métriques CloudWatch pour divers aspects de mes clusters. Je n'ai pas besoin de configurer quoi que ce soit de plus. Je dois simplement m'assurer d'utiliser les ressources Terraform appropriées pour créer des alarmes basées sur ces métriques.

## Pour mes clusters DocumentDB :

De même, Amazon DocumentDB publie automatiquement des métriques CloudWatch. Je dois simplement configurer des alarmes basées sur ces métriques à l'aide des ressources Terraform mentionnées précédemment.

## Création d'actions d'alarme :

Pour que les alarmes déclenchées en réponse à des événements de métriques spécifiques effectuent des actions spécifiques, comme l'envoi d'une notification par courrier électronique ou l'exécution d'une fonction Lambda, je dois configurer des actions d'alarme. Cela peut inclure la création d'un sujet SNS (Simple Notification Service) pour envoyer des notifications par courrier électronique ou des messages texte, ou la configuration d'autres services AWS pour réagir aux alarmes.

## Permissions IAM :

Je dois m'assurer que les rôles IAM associés à mes ressources ont les autorisations appropriées pour publier des métriques CloudWatch et pour créer des alarmes CloudWatch. Cela garantira que Terraform peut configurer ces ressources correctement.

---
Une fois ces configurations effectuées, les métriques pertinentes seront collectées et je pourrai créer des alarmes CloudWatch à l'aide de Terraform pour surveiller ces métriques et déclencher des actions en cas de dépassement des seuils définis.






