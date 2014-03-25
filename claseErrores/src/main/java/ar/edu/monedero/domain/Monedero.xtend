package ar.edu.monedero.domain

import ar.edu.monedero.exceptions.BusinessException
import java.math.BigDecimal
import org.uqbar.commons.model.Entity
import org.uqbar.commons.utils.Observable

@Observable
class Monedero extends Entity {

	@Property BigDecimal monto

	new(double montoInicial) {
		monto = new BigDecimal(montoInicial)
	}
	
	def void poner(BigDecimal cuanto) {
		this.validarMonto(cuanto)
		this.sumarMonto(cuanto)
	}
	
	def void sacar(BigDecimal cuanto) {
		this.validarMonto(cuanto)
		if (monto < cuanto) {
			throw new BusinessException("No puede sacar más de " + monto + " $")
		}
		this.sumarMonto(cuanto.negate)
	}
	
	def sumarMonto(BigDecimal valor) {
		monto = monto.add(valor)
	}

	def void validarMonto(BigDecimal cuanto) {
		if (cuanto.doubleValue <= 0) {
			throw new BusinessException(cuanto + ": el monto a ingresar debe ser un valor positivo")
		}
	}

	override toString() {
		"Monedero ($ " + monto + ")" 
	}
	
}
