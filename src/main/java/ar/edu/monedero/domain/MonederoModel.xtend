package ar.edu.monedero.domain

import ar.edu.monedero.exceptions.BusinessException
import java.math.BigDecimal
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class MonederoModel {

	Monedero monedero
	String montoAIngresar
	
	new(Monedero model) {
		monedero = model
	}
	
	def void inicializar() {
		montoAIngresar = ""
		ObservableUtils.firePropertyChanged(this, "montoActual", montoActual)
	}
	
	def void sacar() {
		try {
			monedero.sacar(new BigDecimal(montoAIngresar))
			this.inicializar
		} catch (NumberFormatException e) {
			throw new BusinessException("Debe ingresar un monto válido")
		}
	}

	def void poner() {
		try {
			monedero.poner(new BigDecimal(montoAIngresar))
			this.inicializar
		} catch (NumberFormatException e) {
			throw new BusinessException("Debe ingresar un monto válido")
		}
	}
	
	def BigDecimal getMontoActual() {
		monedero.monto
	}

	
}
