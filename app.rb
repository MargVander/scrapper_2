require 'bundler'
Bundler.require
require 'open-uri'

$:.unshift File.expand_path("./../lib", __FILE__)
require 'app/scrapper'

a = Scrapper.new
a.save_as_spreadsheet
#enregistrer les donnés du tableau dans la méthode que vous voulez en faisant a.save_as_JSON, a.save_as_spreadsheet ou a.save_as_csv