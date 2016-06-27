-- Requête permettant de récupérer des enregistrement dont la date de traitement(sockée en numérique AAAMMJJ)
-- est inférieure à la date du jour – 3 ans
--
-- Réalisée par  Armelle Lermitte


  Select * from NOM_TABLE
  where NOM_COLONNE <
  (
  (select
  year (current date) * 10000 +
  month (current date) * 100 +
  day    (current date)
  from sysibm.sysdummy1) - 30000
  )
  ORDER by NOM_COLONNE desc