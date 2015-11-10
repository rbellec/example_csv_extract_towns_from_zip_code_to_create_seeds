require "csv"

# Liste des départements nous interessant. On travaille avec des entiers
# mais certains codes postaux contiennent des lettres (cas non addressé ici).
SELECTED_DEPARTEMENTS = [75, 77, 78, 91, 92, 93, 94, 95]



# Fonction renvoyant true si la ligne du CSV nous interesse, false sinon.
def accept?(row)
  # On accepte toutes les villes pour les quelles un code postal commence par 92.
  departement = row["Code_postal"].slice(0,2).to_i
  SELECTED_DEPARTEMENTS.include? departement
end


# Fonction utilisée sur toutes les lignes CSV matchant nos critères et faisant les opérations et la sortie.
def handle(row)
  puts "Location.new(name:'#{row["Nom_de_la_commune"].capitalize}' , zip_code:'#{row["Code_postal"]}')"
end

CSV.foreach('base_officielle_codes_postaux_09102015.csv',
             col_sep: ";", headers: true, :encoding => 'ISO-8859-1') do |row|
  if accept?(row)
    handle(row)
  end
end
