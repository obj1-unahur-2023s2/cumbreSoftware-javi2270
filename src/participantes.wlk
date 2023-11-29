import conocimientos.*
import cumbre.*

class Participante {
	const property pais
	const property conocimientos = #{}
	var property commits
	
	method esCape()
	
	method agregarConocimientos(listDeConoc){
		conocimientos.addAll(listDeConoc)
	}
	method cumpleRequisitos() = conocimientos.contains(programacionBasica)
	
	method hacerActividad(actividad){
		conocimientos.add(actividad.tema())
		commits += ( actividad.tema().commitsPorHora() * actividad.cantDeHoras() )
	}
}

class Programador inherits Participante {
	var horasDeCapacitacion = 0
	
	override method esCape() = commits > 500
	
	override method cumpleRequisitos() = 
		super() && commits >= cumbre.commits()
		
	override method hacerActividad(actividad){
		super(actividad)
		horasDeCapacitacion += actividad.cantDeHoras()
	}
}

class Especialista inherits Participante {
	
	override method esCape() = self.conocimientos().size() > 2
	
	override method cumpleRequisitos() = 
		super() and commits >= (cumbre.commits()-100) and conocimientos.contains(objetos)
	
}

class Gerente inherits Participante {
	const empresaDndTrabaja	
	
	override method esCape() = super() and empresaDndTrabaja.esMultinacional()
	
	override method cumpleRequisitos() = 
		super() and conocimientos.contains(manejoDeGrupos)
}


