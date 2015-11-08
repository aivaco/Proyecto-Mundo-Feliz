module PagesHelper

    #Cambia el estado según lo ingresado.    
  def cambiaEstado (estado)
    if (estado == 'd')
      estado = "Definido"
    elsif (estado == 'p')
      estado = "En Progreso"
    elsif (estado =='t')
      estado = "Terminado"
    else
      estado = "Cancelado"
    end
    return estado
  end
  
  #Crea un documento de MD según los valores de un proyecto (no identar!)
def creaMD (nombre, razon, tiempo, presupuesto=0.0, costo=0.0, estado)
    
    estado = cambiaEstado(estado)
    if (estado != "Cancelado")
        imagen = "<center>![Lista](https://image.freepik.com/free-icon/notedpad-list_318-85609.png)</center>   "
    else
        imagen ="<center>![Cancelado](http://findicons.com/files/icons/1014/ivista/128/error.png)</center>   "
    end
    @markdown = "##{nombre}
###Necesidad:
#{razon}.
###Tiempo:
#{tiempo}.
 
###Precio:
El precio aproximado es de: $#{costo}.   
###Presupuesto:
Se cuenta con un presupuesto de $#{presupuesto} para completar el proyecto.

##{estado}.
 



#{imagen}"
return @markdown

end

end
