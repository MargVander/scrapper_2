require 'open-uri'


class Scrapper
	attr_accessor :mairie 

	def initialize #faire en sorte que l'array de hash sorte à chaque fois qu'on fait appelle à la la classe Scrapper.
		@mairie = perform

	end

	def get_townhall_email(townhall_url)
		town_email = []
		town_name = []
		townhall_url.each do |el| #ouvre les profils de toutes les villes et récupère chacune de leur adresse email.
			page = Nokogiri::HTML(open(el))
			page.xpath('//section[2]/div/table/tbody/tr[4]/td[2]').each do |email|
				town_email << email.text #mettre les email dans une array dédié
			end
		end
		page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
		page.xpath('//p/a').each do |el| 
			town_name << el.text #mettre les nom des ville dans une array dédié
		end
		townandmail = town_name.zip(town_email)
		final_array = []
		townandmail.each do |e|
			final_array << {e[0] => e[1]} #formule pour transformer le hash en array de hash
		end
		print final_array
		return final_array
	end

	def townhall_url
		page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
		town_link = []
		page.xpath('//p/a').each do |el|
			town_link << "http://annuaire-des-mairies.com#{el.attr('href')[1..-1]}" #recupère le nom de toutes les communes et les rentre dans le lien, afin de pouvoir avoir les liens contenant les infos de toutes les villes.
		end
		return town_link
	end

	def perform
		final = []
		final = get_townhall_email(townhall_url)
		return final
	end

	def save_as_JSON
		File.open("db/emails.json", "w") do |f|
			f.write(@mairie.to_json)
		end
	end

	def save_as_spreadsheet
		i = 1
		session = GoogleDrive::Session.from_config("config.json")
		ws = session.spreadsheet_by_key("1VpKH2P5HUAmQBFC_dtxkDvb3aHOJ8NI5qPA5wrbT924").worksheets[0]
		@mairie.map do |hash|
			hash.select do |key, value|
				ws["A#{i}"] = key  #mettre les noms des villes dans la première colonne
				ws["B#{i}"] = value  #mettre les emails dans la deuxième colonnes
				ws.save
				i = i + 1
				sleep 1 #faire en sorte que google ne bloque pas en attendant une seconde après chaque entré dans le tableur
			end
		end
	end

	def save_as_csv
		CSV.open("db/emails.csv", "wb") do |csv|
			@mairie.map do |hash|
				hash.select do |key, value| 
					csv << [key, value] #créer des colonnes avec des arrays constitué des key et value de tout les hashes.
				end
			end
		end


	end
end



