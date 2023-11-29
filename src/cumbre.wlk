import conocimientos.*
import paises.*

object cumbre {
	const property paisesAuspiciantes = #{}
	const participantesRegistrados = #{}
	var property commits = 300
	const participantesIngresados = #{}
	const actividadesRealizadas = #{}
	
	method puedeIngresar(unParticipante) =
		unParticipante.cumpleRequisitos() and not self.tieneAccesoRestringido(unParticipante)
		
	method ingresarParticipante(unParticipante) {
		if ( not self.puedeIngresar(unParticipante)){
			self.error('El participante tiene el acceso restringido.')
		}
		participantesIngresados.add(unParticipante)
	}

	method esConflictivo(unPais)  =
			paisesAuspiciantes.any({p => unPais.tieneConflicto(p)})

	method paisesDeLosParticipantes() =
		participantesIngresados.map({p => p.pais()}).asSet()
	
	method cantDeParticDePais(pais) =
		participantesIngresados.count({part => part.pais() == pais})
	
	method paisConMasPartic() = 
		self.paisesDeLosParticipantes().max({p => self.cantDeParticDePais(p)})
	
	method particExtranjeros() = 
		participantesIngresados.filter({part => not paisesAuspiciantes.contains(part.pais())})
		
	method esRelevante() = participantesIngresados.all({part => part.esCape()})
	
	method tieneAccesoRestringido(unParticipante)=
		self.esConflictivo(unParticipante.pais()) and self.suPaisNoEsAuspiciante(unParticipante)
				or 
		(self.cantDeParticDePais(unParticipante.pais())== 1 
		 and self.suPaisNoEsAuspiciante(unParticipante))
	
	method suPaisNoEsAuspiciante(unParticipante) {
		return not self.paisesAuspiciantes().contains(unParticipante.pais())
	}
	method esSegura() = participantesRegistrados.all({part => self.puedeIngresar(part)})
	
	method realizarActividad(actividad){
		participantesIngresados.forEach({part => part.hacerActividad(actividad)})
		actividadesRealizadas.add(actividad)
	}
	method totalHorasDeActividadesRealizadas() =
		actividadesRealizadas.sum({act => act.cantDeHoras()})
	
	//////////////////////////////////////////////////////////////////////////////////////////	
	// metodos para facilitar agregado en los test		
	method registrarParticipantes(listDePartic){
		participantesRegistrados.addAll(listDePartic)
	}
	method ingresarParticipantes(listDePartic){
		participantesIngresados.addAll(listDePartic)
	}
	method agregarPaisesAuspiciantes(listDePaises){
		paisesAuspiciantes.addAll(listDePaises)
	}
}




