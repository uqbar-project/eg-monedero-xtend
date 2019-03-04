package ar.com.xtend.monedero.smell.finalIteration.domain

import ar.com.xtend.monedero.smell.exceptions.MontoNegativoException
import java.math.BigDecimal
import java.text.DateFormat
import java.util.Date
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
abstract class Movimiento {
	Date fecha
	BigDecimal monto

	new(Date fecha, BigDecimal monto) {
		this.fecha = fecha
		this.monto = monto
		this.validarMonto()
	}

	def fueDepositado(Date fecha) {
		isDeposito() && esDeLaFecha(fecha)
	}

	def fueExtraido(Date fecha) {
		isExtraccion() && esDeLaFecha(fecha)
	}

	/**
	 * Uso un date format para elminar los segundos... no es muy feliz pero no se me ocurre nada mejor.
	 */
	def esDeLaFecha(Date fecha) {
		var dateFormat = DateFormat.getDateInstance()
		dateFormat.format(this.fecha).equals(dateFormat.format(fecha))
	}

	def boolean isDeposito()

	def boolean isExtraccion()

	// ********************************************************
	// ** Validaciones
	// ********************************************************
	def validarMonto() {
		if (this.getMonto().doubleValue() <= 0) {
			throw new MontoNegativoException(this.getMonto() + ": el monto a ingresar debe ser un valor positivo")
		}
	}

	def void validar(Cuenta cuenta)

	def void agregateA(Cuenta cuenta) {
		this.validar(cuenta)
		cuenta.setSaldo(this.calcularValor(cuenta))
		cuenta.agregarMovimiento(this)
	}

	def BigDecimal calcularValor(Cuenta cuenta)
	
}
