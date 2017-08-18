class ArchivosController < ApplicationController
 Ruta_directorio_archivos = "public/archivos/";
 def subir_archivos
    @formato_erroneo = false;
    @archivo_existe  = false;
    if request.post?
       #Archivo subido por el usuario.
       archivo = params[:archivo];
       ruta_al_archivo = Ruta_directorio_archivos + archivo.original_filename;
       puts ruta_al_archivo
       #Verificamos que el archivo exista para mp subirlo.
       if File.exist?(ruta_al_archivo)
          puts archivo.original_filename
          subir_archivo  = "existe";
      else
          #Nombre original del archivo.
          nombre = archivo.original_filename;
          #Directorio donde se va a guardar.
          directorio = Ruta_directorio_archivos;
          #Extensión del archivo.
          extension = nombre.split(".")
          if extension.last == "txt" or extension.last == "pdf" or extension.last == "doc" or extension.last == "docx"
             #Ruta del archivo.
             path = File.join(directorio, nombre);
             #Crear en el archivo en el directorio. Guardamos el resultado en una variable, será true si el archivo se ha guardado correctamente.
             resultado = File.open(path, "wb") { |f| f.write(archivo.read) };
             #Verifica si el archivo se subió correctamente.
             if resultado
                subir_archivo = "ok";
             else
                subir_archivo = "error";
             end
             #Redirige al controlador "archivos", a la acción "lista_archivos" y con la variable de tipo GET "subir_archivos" con el valor "ok" si se subió el archivo y "error" si no se pudo.
          else
            @formato_erroneo = true;
          end
      end
    end
    if subir_archivo.present?
      redirect_to :controller => "archivos", :action => "listar_archivos", :subir_archivo => subir_archivo;
    end
 end

 def listar_archivos
    #Guardamos la lista de archivos de la carpeta "archivos".
    @archivos = Dir.entries(Ruta_directorio_archivos);
    #Mensaje que mostrará si la página viene desde otra acción.
    @mensaje = "";
    #Verificamos si existe la variable subir_archivo por GET.
    if params[:subir_archivo].present?
       if params[:subir_archivo] == "ok";
          @mensaje = "El archivo ha sido subido exitosamente.";
       else
         if params[:subir_archivo] == "existe";
          @mensaje = "El archivo EXISTE";
       else
          @mensaje = "El archivo no ha podido ser subido.";
       end
       end
    end
    #Verificamos si existe la variable eliminar_archivo por GET.
    if params[:eliminar_archivo].present?
       if params[:eliminar_archivo] == "ok";
          @mensaje = "El archivo ha sido eliminado exitosamente";
       else
          @mensaje = "El archivo no ha podido ser eliminado.";
       end
    end



 end
 def borrar_archivos
    #Recuperamos el nombre del archivo.
    archivo_a_borrar = params[:archivo_a_borrar];
    #Guardamos la ruta del archivo a eliminar.
    ruta_al_archivo = Ruta_directorio_archivos + archivo_a_borrar;
    #Verificamos que el archivo exista para eliminarlo.
    if File.exist?(ruta_al_archivo)
       #Si el archivo existe se intentará eliminarlo. Dentro de la variable resultado se guardará true si se pudo eliminar y false si no.
       resultado = File.delete(ruta_al_archivo);
    else
       #El archivo no existe así que no se pudo eliminar nada.
       resultado = false;
    end
    #Verifica si el archivo se eliminó correctamente.
    if resultado
       eliminar_archivo = "ok";
    else
       eliminar_archivo = "error";
    end
    redirect_to :controller => "archivos", :action => "listar_archivos", :eliminar_archivo => eliminar_archivo;
 end

end