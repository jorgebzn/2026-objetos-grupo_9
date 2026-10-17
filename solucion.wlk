//Punto 1
class Guerrero {
    const potencialOfensivo
    var property energia
    const energiaOriginal
    var property experiencia = 0
    var property traje

    method atacar(otroGuerrero) {
        otroGuerrero.recibirAtaque(potencialOfensivo)
    }

    method recibirAtaque(potencialAtacante) {
        const danioBase = potencialAtacante * 0.10
        
        const danioFinal = traje.mitigarDanio(danioBase)
        energia = 0.max(energia - danioFinal)

        experiencia += traje.experienciaGanada()
        //Punto 3 
        traje.usarTraje()
    }

    method comerSemilla() {
        energia = energiaOriginal
    }
}
//Punto 3
class Traje {
    var  desgaste = 0
    const desgastePorAtaque = 5
    const desgasteMaximo = 100

    method desgaste () =  desgaste
    method usarTraje () {
        if (!self.estaGastado()) {
            desgaste += desgastePorAtaque
        }  
    }

    method estaGastado () = desgaste >= desgasteMaximo
    
    method mitigarDanio(danioBase) 
    
    method experienciaGanada()  
}
//Punto 2
class TrajeComun inherits Traje {
    const porcentajeProteccion
    
   override method mitigarDanio(danioBase) {
        // return danioBase - (danioBase * porcentajeProteccion / 100)
        //Punto 3
        if (self.estaGastado()) {
            return danioBase

        } else {
            return (danioBase - (danioBase * porcentajeProteccion / 100))
        }
    }
    
   override method experienciaGanada() = 1
}

object configuracionEntrenamiento {
    var property aumentoExperiencia = 2 
}

class TrajeDeEntrenamiento inherits Traje {

    override method mitigarDanio(danioBase) = danioBase
    
    // method experienciaGanada() = 1 * configuracionEntrenamiento.aumentoExperiencia()
    override method experienciaGanada() {
        if (self.estaGastado()) {
            return 1 

        } else {
            return (1 * configuracionEntrenamiento.aumentoExperiencia())
        }
    }
}