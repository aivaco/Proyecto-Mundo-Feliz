module RiesgoHelper
    #Para generar archivo de documento de riesgo con formato markdown. No Identar.
    def creaDR(tipo, descripcion)
        @markdown = "##{tipo}

###Descripción
#{descripcion}

<center>![Fungo icon](https://image.freepik.com/free-icon/hazard-sign_318-33916.png)</center>   "
return @markdown
    end
end
