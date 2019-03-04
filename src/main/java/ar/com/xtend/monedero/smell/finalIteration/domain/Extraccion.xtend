package ar.com.xtend.monedero.smell.finalIteration.domain

import java.math.BigDecimal
import java.util.Date

class Extraccion extends Movimiento {
	
	new(Date fecha, BigDecimal monto) {
		super(fecha, monto)
	}

	override isDeposito() {
		 false
	}

	override isExtraccion() {
		true
	}

	override validar(Cuenta cuenta) {
		cuenta.validarLimiteExtraccionDiario(this.monto)
		cuenta.validarSaldoDisponibleParaExtraer(this.monto)
	}
	
	override calcularValor(Cuenta cuenta) {
		cuenta.saldo.subtract(this.monto)
	}

}
