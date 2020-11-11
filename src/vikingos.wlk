//1.Subir un vikingo a una expedición. Si no puede subir no debe hacerlo, y se debe avisar correspondientemente.
//2.Saber si una expedición vale o no la pena.

class Vikingo {
	var property castaSocial = jarl
	var property oro = 0
	
	method esProductivo()
	
	method puedeSubirA(expedicion) = self.esProductivo() and castaSocial.puedeIr(self,expedicion)

	method ganar(monedas){
		oro += monedas
	}
}

class Expediciones {
	
	const property integrantes = []
	var objetivos = []
	
	method puedeSubir(vikingo) {
		self.validarSiPuedeSubir(vikingo)
		integrantes.add(vikingo)		
		}
		
	method validarSiPuedeSubir(vikingo){
			if(not vikingo.puedeSubirA(self))
			self.error("No puede subir a la expedicion por no ser productivo")
	}
	
	method cantidadDeIntegrantesParaInvadir() = integrantes.size()
	
	method valeLaPena() = objetivos.all({objetivo => objetivo.valeLaPenaPara(self.cantidadDeIntegrantesParaInvadir())})

	method realizar() {
		objetivos.forEach({objetivo => objetivo.serInvadidoPor(self)})
	}
	
	method repartirBotin(botin) {
		integrantes.forEach({integrante => integrante.ganar(botin / self.cantidadDeIntegrantesParaInvadir())})
	}

}

class Casta {
	method puedeIr(vikingo, expedicion) = true
}

object jarl inherits Casta {
	
	override method puedeIr(vikingo, expedicion) = not vikingo.tieneArmas()
	
}

object karl {
	
}

object thrall {
	
}

class Soldado inherits Vikingo {
	var property cantidadVidasCobradas
	var armas
	
	method tieneArmas() = self.realizarValidacionDeCantidad(armas, 0)
	
	method cobroMasDe20Vidas() = self.realizarValidacionDeCantidad(cantidadVidasCobradas, 20)
	
	method realizarValidacionDeCantidad(cantidad, mayorA) = cantidad > mayorA
	
	override method esProductivo() = self.tieneArmas() and self.cobroMasDe20Vidas()
	
}

class Granjero inherits Vikingo {
	var cantHijos
	var hectareasDesignadas
	
	override method esProductivo() = hectareasDesignadas * 2 >= cantHijos
	
	method tieneArmas() = false
	
}

//OBJETIVOS

class Lugar {
	
	method botin(cantInvasores)
	method destruirse(cantInvasores)
	
	method serInvadidoPor(expedicion){
		expedicion.repartirBotin(self.botin(expedicion.cantidadDeIntegrantesParaInvadir()))
		self.destruirse(expedicion.cantidadDeIntegrantesParaInvadir())
	}
	
}

class Aldea inherits Lugar {
	var crucifijos
	
	override method botin(cantidadInvasores) = crucifijos
	
	method valeLaPenaPara(cantInvasores) = self.botin(cantInvasores) >= 15
	
	override method destruirse(cantInvasores){
		crucifijos = 0
	}
	
}

class AldeaAmurallada inherits Aldea {
	var minimaVikingos
	
	override method valeLaPenaPara(cantInvasores) = super(cantInvasores) and cantInvasores >= minimaVikingos
}

class Capital inherits Lugar {
	
	var property defensores
	var riqueza
	
	method valeLaPenaPara(cantInvasores) = cantInvasores <= self.botin(cantInvasores) / 3
	
	override method botin(cantidadInvasores) = 	self.defensoresDerrotados(cantidadInvasores) * riqueza
	
	method defensoresDerrotados(invasores) = defensores.min(invasores)
	
	override method destruirse(cantInvasores){
		defensores -= self.defensoresDerrotados(cantInvasores)
	}
}

/*Si pueden agregarse castillos sin nungun inconveniente, se definiría un nuevo
 * destino Castillo que hereda de Lugar, y simplemente tendria que entender los
 * comportamientos que cualquier lugar tiene, y ademas comportamientos nuevos.
 * 
 * class Castillos inherits Lugar {
 * 	y acá irían los mensajes que entiende un castillo
 */
























