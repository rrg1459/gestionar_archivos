class Contacto < ApplicationRecord

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
    puts file_path.inspect
    puts '.....'
    puts file_path.original_filename
    puts '.....'
  	file = open_file(file_path)
  	# Leer archivo
#       File.open("public/archivos/errores.txt", "wb"){|f|;
      File.open("public/archivos/errores.xls", "a+"){|f|;
          f.write("\n");
          f.write("Archivo de errores ");
          f.write("\n");
          f.write(Time.now);
          f.write("\n");
          f.write(file_path.original_filename);
          f.write("\n");
        	(1..file.last_row).each do |i|
        		fila = file.row(i)
            puts "#{i}\t#{fila[0]}\t#{fila[1]}"

                #Escribe el contenido del archivo.
                puts 'dentro de escribie'
                f.write(i);
                f.write("\t");
                f.write(fila[0]);
                f.write("\t");
                f.write(fila[1]);
                f.write("\n");
          	  #	@repartition=Repartition.new
        	    #	@repartition.fond_repartition_id=row[4]
        	    # @repartition.date_repartition=row[3]
          	  #	@repartition.save!
          end
          f.close();
      };

  end

end
