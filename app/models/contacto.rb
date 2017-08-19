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
#    puts file_path.inspect
#    puts '.....'
#    puts file_path.original_filename
#    puts '.....'
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
          f.write("Linea");
          f.write("\t");
          f.write("Numero");
          f.write("\t");
          f.write("Nombre");
          f.write("\t");
          f.write("Observacion");
          f.write("\n");
        	(1..file.last_row).each do |i|
        		fila = file.row(i)

#           puts "#{i}\t#{fila[0]}\t#{fila[1]}"
    error = false

                #Escribe el contenido del archivo.
                numero = fila[0].to_s
                nombre = fila[1]
                numero = numero.gsub(/[ .,;()-]*/, '')
                if numero.last == '0'
                  numero = numero.to_i / 10
                end

                    puts "--antes--> #{numero}"
                    puts numero.inspect

#............................................................
                if numero.to_i > 4120100000 && numero.to_i < 4269999999
                  numero = numero.to_i
                  area = numero.to_s[0,3]
                  if area == '412' || area == '414' || area == '424' || area == '416' || area == '426'
                    # escribir en la base de datos
                    # falta validar existencia en la BD, el codigo va  aqui
#                   puts "--in---> #{numero}"


      if Contacto.exists?(numero: numero)
        error = true
        mensaje = 'Contacto existe en la BD'
      else
        @contacto=Contacto.new
        @contacto.numero = numero
        @contacto.nombre = nombre 
        @contacto.save         
      end




                  else
                    # escribiren el archivo de errores
#                    puts "--out--> #{fila[0]}"
                    error = true
                    mensaje = 'codigo de area incorrecto'
                  end 
                else
                  error = true
                  mensaje = 'Numero fuera de rango'
                end 

                if error
#                 puts "--error--> #{fila[0]} --- #{mensaje}"
                  f.write(i);
                  f.write("\t");
                  f.write(fila[0]);
                  f.write("\t");
                  f.write(nombre);
                  f.write("\t");
                  f.write(mensaje);
                  f.write("\n");
                end
#............................................................




          end
          f.close();
      };

  end

end
