

class Vikingo {
	var castaSocial = jarl
	
	method esProductivo()
	
	method puedeSubirA(expedicion) = self.esProductivo() and castaSocial.puedeIr(self,expedicion)
}

class Expediciones {
	
	const property integrantes = []
	
	method puedeSubir(vikingo) {
		self.validarSiPuedeSubir(vikingo)
		integrantes.add(vikingo)		
		}
		
	method validarSiPuedeSubir(vikingo){
			if(not vikingo.puedeSubirA(self)){
			self.error("No puede subir a la expedicion por no ser productivo")
		}
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






