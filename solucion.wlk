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
    }

    method comerSemilla() {
        energia = energiaOriginal
    }
}

//Punto 2
class TrajeComun {
    const porcentajeProteccion
    
    method mitigarDanio(danioBase) {
        return danioBase - (danioBase * porcentajeProteccion / 100)
    }
    
    method experienciaGanada() = 1
}

object configuracionEntrenamiento {
    var property aumentoExperiencia = 2 
}

class TrajeDeEntrenamiento {

    method mitigarDanio(danioBase) = danioBase
    
    method experienciaGanada() = 1 * configuracionEntrenamiento.aumentoExperiencia()
}