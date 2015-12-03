module AlianzaHelper
    
    #Para generar archivo de documentos alianza con formato markdown. No Identar.
    def creaDA(tipo,nombreEmp,proposito,fechaFin)
        @markdown = "##{tipo}
##Empresa:
#{nombreEmp}.

###Propósito:
#{proposito}.
###Fecha de finalización:
> #{fechaFin.to_s}.

<center>![Fungo icon](http://www.clipartbest.com/cliparts/ncE/EjR/ncEEjRLei.jpeg)</center>    "
return @markdown
    end
end
