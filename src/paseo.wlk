// Nota 6 (seis). Hay problemas con el polimorfismo, super y manejo de excepciones.

// 1) B. Repite código por no usar super correctamente.
// 2) MB.
// 3) Mal. No es polimórfico, hay distintos nombres para el mismo concepto.
// 4) B-. Falta división en subtareas.
// 5) R+. Repite código, falta delegación en juguete.
// 6) MB.
// 7) No implementado.
// 8) B-. Falta manejo de excepciones.
// Tests no andan!

// juguetes
class Juguete {

	var property min = null
	var property max = null

}

// familia
class Familia {

	var ninios = null // ¿Por qué null?

	// var juguete = null
	method puedePasear() = ninios.all({ n => n.puedePasear() })

	method infaltables() = ninios.filter({ n => n.maximaCalidad() })

	method salirDePaseo() {
		if (self.puedePasear()) {
			ninios.prendas().forEach({ p => p.desgastar()})
		}
		// Tirar excepción si falla la validación
	}

}

class Ninio {

	var property talle = null
	var prendas = #{}
	var property edad = null
	var property juguete = null
	var property abrigo = null

	// Usar >4 cuando el enunciado dice "al menos 5" obliga al lector a interpretar, más adecuado es poner >=5, que expresa con más exactitud lo que pide el enunciado.
	// Falta división en subtareas.
	method puedePasear() = prendas.size() > 4 and prendas.any({ p => p.abrigo() >= 3 }) and prendas.sum({ p => p.calidad(self) }) / prendas.size() >= 8

	method maximaCalidad() = prendas.max({ p => p.calidad(self) })

	method esChiquito() = edad < 4

}

class NinioProblematico inherits Ninio {
	// Repetición de código.
	override method puedePasear() = prendas.size() > 3 and prendas.any({ p => p.abrigo() >= 3 }) and prendas.sum({ p => p.calidad(self) }) / prendas.size() >= 8 and juguete.min() < edad and juguete.max() > edad

}

class Prenda {

	var property talle = null
	var desgaste = 0
	var abrigo = null

	method nivelComodidadRopaNueva(ninio) {
		return if (ninio.talle() == self.talle()) {
			8
		} else {
			0
		}
	}

	method nivelDeDesgaste(numI, numD) { // ¿Por qué recibe dos parámetros? ¿Quién manda este mensaje?
		desgaste = numI
	}

	// Más fácil desgaste.min(3)
	method desgaste() = if (desgaste <= 3) {
		desgaste
	} else {
		3
	}

	// nivel de comodidad
	method nivelComodidad(ninio) = self.nivelComodidadRopaNueva(ninio) - self.desgaste()

	// nivel de abrigo
	method nivelDeAbrigo() = abrigo

	method abrigoSet(num) { // Nombre muy raro
		abrigo = num
	}

	method calidad(ninio) = self.nivelDeAbrigo() + self.nivelComodidad(ninio)

	// desgastar
	method desgastar() {
		desgaste -= 1
	}

}

class PrendaPar inherits Prenda {

	var property derecho = null
	var property izquierdo = null
	var property persona = null

	// ¿Quién manda este mensaje?
	override method nivelDeDesgaste(numI, numD) {
		izquierdo = numI
		derecho = numD
	}

	method duenio(unaPersona) {
		persona = unaPersona
	}

	// Si la persona es chiquita debería afectar a la comodidad, no al desgaste.
	override method desgaste() = ((izquierdo.desgaste() + derecho.desgaste()) / 2) - if (persona.esChiquito()){1}else {0}

	// nivel de comodidad
	override method nivelComodidad(ninio) = (izquierdo.nivelComodidad(ninio) + derecho.nivelComodidad(ninio)) / 2

	// intercambiar par
	method intercambiar(otroPar) {
		var cambio
		if (self.talle() != otroPar.talle()) {
			self.error("no se puede intercambiar")
		} else {
			cambio = izquierdo
			self.derecho(otroPar.izquierda())
			otroPar.izquierda(cambio)
		}
	}

	method abrigoDelPar() { // Debería ser polimórfico con el resto de las prendas.
		abrigo = izquierdo.abrigo() + derecho.abrigo()
	}

	override method desgastar() {
		// Esto no funciona, no entiendo lo que se intenta hacer.
		desgaste = izquierdo.desgastar() + 0.2
		desgaste = derecho.desgastar() - 0.2
	}

}

class PrendaLiviana inherits Prenda {

	// Repetición innecesaria de lógica por no usar super.
	override method nivelComodidadRopaNueva(ninio) {
		return if (ninio.talle() == self.talle()) {
			10
		} else {
			2
		} // los dos puntos por ser liviana
	}

	override method nivelDeAbrigo() = abrigoPrendaLiviana.abrigo()

}

class PrendaPesada inherits Prenda {
	// Falta valor por default de abrigo = 3
}

object abrigoPrendaLiviana {

	var property abrigo = 1

}

//Objetos usados para los talles
object xs {

}

object s {

}

object m {

}

object l {

}

object xl {

}

