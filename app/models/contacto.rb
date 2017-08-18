class Contacto < ApplicationRecord
  puts '-------------------------'
  puts '---dentro del model------'
  puts '-------------------------'

  def self.open_file(file)
  	case File.extname(file.original_filename)
  	  when ".csv" then Roo::CSV.new(file.path, options={})
  	  when ".xls" then Roo::Excel.new(file.path, options={})
  	  when ".xlsx" then Roo::Excelx.new(file.path, options={})
    	else raise nil
  	end
  end

  def self.import(file_path)
  	# Abrir archivo
  	file = open_file(file_path)
  	# Leer archivo
  	(1..file.last_row).each do |i|
  		row = file.row(i)
  	  puts row
  	  #	@repartition=Repartition.new
	    #	@repartition.fond_repartition_id=row[4]
	    # @repartition.date_repartition=row[3]
  	  #	@repartition.save!
  	end
  end

end
