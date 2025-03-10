/* Creation de la table custumer_reviews */
create table fr_carburant(
          id int primary key,
          code_postal int,
          adresse text,
		  ville text,
		  latitude text,
          longitude text,
          prix_sp95 text,
          debut_rupture_sp95_si_temporaire text,
          type_rupture_sp95 text,
          carburants_disponibles text,
          carburants_indisponibles text,
          carburants_en_rupture_temporaire text,
          carburants_en_rupture_definitive text,
          departement text,
          code_departement text,
          region text,
          code_region text
);

/* Afficher toute la table */
SELECT* FROM fr_carburant;

/* Afficher seulement quelques colonnes de la table */
SELECT adresse, prix_sp95, latitude, longitude,  ville,  code_departement 
FROM fr_carburant;

/* Trouver le prix min/max du SP95 */
SELECT min(prix_sp95) as min_prix_sp95, max(prix_sp95) as max_prix_sp95                                                               
FROM fr_carburant;

/* Afficher les stations essence du département: 83 */
SELECT adresse, prix_sp95, latitude, longitude,  ville, code_departement 
FROM fr_carburant
WHERE code_departement="83";

/* Compter les stations essence du département: 83 */
SELECT count(id) as nb_stations_83
FROM fr_carburant
WHERE code_departement='83';

/* Afficher les stations essence du département 83 qui ont du SP95 */
SELECT adresse, prix_sp95, latitude, longitude,  ville, code_departement 
FROM fr_carburant
WHERE code_departement='83' AND prix_sp95 IS NOT NULL;

/* Trouver la station la moins chère pour le SP95 du département 83 */
SELECT adresse, prix_sp95, latitude, longitude,  ville, code_departement 
FROM fr_carburant
WHERE code_departement='83' AND prix_sp95 IS NOT NULL
ORDER BY prix_sp95;

/* Quelle est la station essence la moins chère autour de chez moi ? */
CREATE VIEW station_moins_chere AS 
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

