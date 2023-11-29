class Pais {
	const conflicto = #{}
	
	method registrarConflicto(unPais){
		conflicto.add(unPais)
	}
	
	method tieneConflicto(unPais) = 
		conflicto.contains(unPais)
}
