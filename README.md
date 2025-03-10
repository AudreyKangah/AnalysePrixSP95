# ⛽ Étude de Cas : Quelle est la station essence la moins chère autour de chez moi ?

## 📖 Description
Ce projet vise à analyser les prix des carburants en France afin d’identifier les stations essence les moins chères à proximité d’un point donné. L’objectif est d’aider une société de transport à optimiser les arrêts de sa flotte de camions en fonction des prix des carburants, permettant ainsi des économies substantielles.

---

## 🎯 Objectifs
✔️ Identifier les stations les moins chères dans une région donnée.  
✔️ Analyser la distribution des prix des carburants (SP95).  
✔️ Cartographier les stations avec une visualisation dynamique des prix.  
✔️ Aider à la prise de décision pour optimiser les arrêts des véhicules en transit.  

---

## 🛠 Outils Utilisés
- **Excel** : Nettoyage et prétraitement des données.  
- **MySQL Workbench** : Stockage et analyse des données.  
- **Power BI** : Création du dashboard interactif.  

---

## 📂 Sources des Données
- **DataGouv** : Prix des carburants en France (CSV, mise à jour septembre 2024).  
- **Google Maps API** : Obtention des coordonnées géographiques pour calculer les distances.  

---

## 📊 Méthodologie

### **1️⃣ Récupération des Données**
- Télécharger le fichier CSV contenant les prix des carburants depuis DataGouv.
- Vérifier la documentation et le modèle des données pour comprendre leur structure.

### **2️⃣ Nettoyage et Préparation des Données** *(Excel & MySQL Workbench)*
- Suppression des colonnes inutiles (horaires, services, etc.).
- Normalisation des noms de colonnes en **snake_case** (ex: `code_postal`, `prix_sp95`).
- Scinder la colonne `geom` en **latitude** et **longitude**.
- Vérification de la cohérence des données géographiques.

### **3️⃣ Chargement des Données dans MySQL Workbench**
- Création d’une base de données `analyse_cout_station` et d’une table `fr_carburant`.
- Importation du fichier CSV nettoyé dans la base de données.

### **4️⃣ Analyse SQL : Filtrage et Calculs** *(MySQL Workbench)*

#### **Trouver les stations les moins chères**
```sql
SELECT adresse, ville, prix_sp95 
FROM fr_carburant 
WHERE code_departement = '83' AND prix_sp95 IS NOT NULL 
ORDER BY prix_sp95 ASC 
LIMIT 10;
```

#### **Calculer la distance entre mon adresse et les stations**
```sql
SELECT 
      id, adresse, ville,
      CONCAT(adresse,' ',code_postal,' ',ville) AS adresse_complete,
      ROUND(prix_sp95,2) AS prix_sp95,
      (6371 * ACOS(
        COS(RADIANS(43.099752)) * COS(RADIANS(latitude)) * 
        COS(RADIANS(longitude) - RADIANS(6.017279)) + 
        SIN(RADIANS(43.099752)) * SIN(RADIANS(latitude))
	   )) AS distance_km
FROM fr_carburant
WHERE code_departement='83' AND prix_sp95 IS NOT NULL
ORDER BY distance_km ASC;
```

### **5️⃣ Création du Dashboard Power BI**
- **Définition des métriques :**
  - Nombre de stations essence.
  - Répartition des prix du SP95.
  - Liste détaillée des stations avec adresse et prix.
  - Carte interactive des stations avec code couleur (vert = moins cher, rouge = plus cher).
- **Filtrage dynamique :**
  - Sélection par prix.
  - Sélection par distance.
  - Vue détaillée lorsqu’on clique sur une station.

### **6️⃣ Visualisation & Dashboard Interactif** *(Power BI)*
- **Carte dynamique** avec les stations essences, prix et code couleur.
- **Graphique en barres** montrant la distribution des prix.
- **Tableau détaillé** listant les stations avec leur distance et prix.
- **Filtres interactifs** permettant d’affiner la recherche.

---

## 🚀 Résultats & Insights
✔️ **Optimisation des coûts de carburant** pour les transporteurs.  
✔️ **Identification rapide des stations les moins chères** sur une carte interactive.  
✔️ **Possibilité de filtrer les stations par prix et distance** pour une meilleure prise de décision.  
✔️ **Visualisation des tendances de prix** sur la région étudiée.  

---

## 📩 Contact
📧 Vous pouvez me contacter via **LinkedIn** pour échanger sur mes compétences en **Analyse de Données, MySQL et Power BI**. 😊
