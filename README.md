Projet de Margaux Vanderbeken, moussaillonne de l'équipe lilloise pour TheHackingProject session 7

Lorsqu-on lance l'app, en faisant ruby app.rb dans le fichier, le programme lance l'execution du scrapper, vous verrez ainsi le array de hashes contenant les noms des villes du Val d'Oise accompagné de l'adresse email des mairies respective. Afin de récolter ces donné de la façon que vous voulez, il faut ajouter a.save_as_JSON, a.save_as_spreadsheet ou a.save_as_csv.

Mon config.json est en fichier caché, donc .config.json avec un point devant. Pour faire appel à ce fichier dans ma méthode save_to_spreadsheet dans mon fichier scrapper.rb, il faudra peut être enlever le point si vous voulez mettre votre propre fichier config.json, ou alors mettre vous même un point devant votre fichier config.json, sinon ça risque de ne pas fonctionner.

Le lien de mon spreadsheet google : https://docs.google.com/spreadsheets/d/1VpKH2P5HUAmQBFC_dtxkDvb3aHOJ8NI5qPA5wrbT924/edit?usp=sharing