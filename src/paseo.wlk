//Esta clase no debe existir, 
//está para que el test compile al inicio del examen
//al finalizar el examen hay que borrar esta clase
/*class XXX {
 * 	var talle= null
 * 	var desgaste= null
 * 	var min= null
 * 	var max= null
 * 	var prendas= null
 * 	var ninios= null
 * 	var edad= null
 * 	var juguete = null
 * 	var abrigo = null
 } lo dejo anotado por las dudas pero no cuenta */
 
 // juguetes
 
 class Juguete {
 	
 	var property min= null
 	var property max= null
 	
 }
// familia
class Familia {

	var ninios = null
	
	//var juguete = null

method puedePasear()=
ninios.all({n=>n.puedePasear()})
method infaltables()=
ninios.filter({n=>n.maximaCalidad()})
method salirDePaseo(){
	if (self.puedePasear()){
	ninios.prendas().forEach({p=>p.desgastar()})	
	}
}

}

class Ninio {

	var property talle = null
	
	var prendas = #{}
	var property edad = null
	var property juguete = null
	var property abrigo = null


method puedePasear()=
prendas.size()>4 and
prendas.any({p=>p.abrigo()>=3}) and
prendas.sum({p=>p.calidad(self)})/prendas.size()>=8

method maximaCalidad()=
prendas.max({p=>p.calidad(self)})

 method esChiquito()=
 edad<4
}

class NinioProblematico inherits Ninio{
	override method puedePasear()=
prendas.size()>3 and
prendas.any({p=>p.abrigo()>=3}) and
prendas.sum({p=>p.calidad(self)})/prendas.size()>=8 and
juguete.min()< edad and juguete.max()> edad
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
	method nivelDeDesgaste(numI,numD){
		desgaste=numI
	}
	
	method desgaste() = if (desgaste <= 3) {
		desgaste
	} else {
		3
	}

	// nivel de comodidad
	method nivelComodidad(ninio) = self.nivelComodidadRopaNueva(ninio) - self.desgaste()
	// nivel de abrigo
	
	method nivelDeAbrigo()= abrigo
	
	method abrigoSet(num){
		abrigo=num
	}
	method calidad(ninio)=
	self.nivelDeAbrigo()+ self.nivelComodidad(ninio)
	// desgastar
	method desgastar(){
		desgaste-=1
	}
}

class PrendaPar inherits Prenda{
	var property derecho=null
	var property izquierdo=null
	
	var property persona=null
	
	
	
	
	
	override method nivelDeDesgaste(numI,numD){
		 izquierdo=numI
		 derecho = numD
	}
	
	method duenio(unaPersona){persona=unaPersona}
	


	
	override method desgaste()= ((izquierdo.desgaste() +derecho.desgaste())/2)
	-if (persona.esChiquito()){1}else {0}
	
	
	// nivel de comodidad
	override method nivelComodidad(ninio) = 
	
	(izquierdo.nivelComodidad(ninio)+derecho.nivelComodidad(ninio))/2
	
	// intercambiar par
	method intercambiar(otroPar){
		var cambio
		if (self.talle()!=otroPar.talle()){
			self.error("no se puede intercambiar")}
			else{
			cambio=izquierdo	
		self.derecho(otroPar.izquierda())
		otroPar.izquierda(cambio)}
	}
	
	method abrigoDelPar(){
		abrigo= izquierdo.abrigo() + derecho.abrigo()	
	}
	override method desgastar(){
		desgaste=izquierdo.desgastar()+0.2
		desgaste=derecho.desgastar()-0.2
	}

}

class PrendaLiviana inherits Prenda{
	override method nivelComodidadRopaNueva(ninio) {
		return if (ninio.talle() == self.talle()) {
			10
		} else {
			2
		}// los dos puntos por ser liviana
	}
	override method nivelDeAbrigo()=
	abrigoPrendaLiviana.abrigo()
}


class PrendaPesada inherits Prenda{
	
	
}

object abrigoPrendaLiviana{
	
	var property abrigo=1
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

