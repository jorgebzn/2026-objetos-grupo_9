//Punto 1
class Guerrero {
    const potencialOfensivo
    var property energia
    const energiaOriginal
    var property experiencia = 0
    var property traje

    method poderDeAtaque() = potencialOfensivo

    method cantidadDePiezas() = traje.cantidadDePiezas()

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

    method cantidadDePiezas() = 1
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

class Pieza {

    const resistencia
    var desgaste = 0
    const desgastePorAtaque = 5  //mantengo el mismo desgaste por ataque que el traje.
    const desgasteMaximo = 20

    method resistencia() = resistencia

    method desgaste() = desgaste

    method estaGastada() = desgaste >= desgasteMaximo

    method usarPieza(){
        if (!self.estaGastada()){
            desgaste += desgastePorAtaque
        }
    }
}

class TrajeModularizado {
    const piezas = []

    method piezasSanas() = piezas.filter({pieza => !pieza.estaGastada()})

    method estaGastado() = piezas.all({pieza => pieza.estaGastada()})

    method usarTraje() {
        self.piezasSanas().forEach({pieza => pieza.usarPieza()}) 
        //decisión de diseño: al recibir un ataque todas las piezas reciben el impacto y se desgastan a la vez
    }

    method resistenciaTotal() = self.piezasSanas().sum({pieza => pieza.resistencia()})

    method mitigarDanio(danioBase) = danioBase - self.resistenciaTotal() 
    //el daño disminuye en una cantidad de unidades igual a la sumatoria de las resistencias de cada pieza que no esté gastada

    method experienciaGanada() = self.piezasSanas().size() / piezas.size() 

    method cantidadDePiezas() = piezas.size()
}

//Punto 5: Modelo de los distintos tipos de torneo.
object powerIsBest {
    method seleccionar(postulantes) =
        postulantes.sortedBy({uno, otro => uno.poderDeAtaque() > otro.poderDeAtaque()}).take(16)
}

object funny {
    method seleccionar(postulantes) =
        postulantes.sortedBy({uno, otro => uno.cantidadDePiezas() > otro.cantidadDePiezas()}).take(16)
}

object surprise {
    method seleccionar(postulantes) = postulantes.randomized().take(16)
}

class Torneo {
    const modalidad
    const postulantes

    method seleccionados() = modalidad.seleccionar(postulantes)
}