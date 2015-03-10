package ar.com.xtend.monedero.smell.finalIteration.domain

import java.math.BigDecimal
import java.util.Date

public class Deposito extends Movimiento {

	new(Date fecha, BigDecimal monto) {
		super(fecha, monto)
	}

	override isDeposito() {
		true
	}

	override isExtraccion() {
		false
	}

	override validar(Cuenta cuenta) {
		cuenta.validarCantidadDeDepositosDiaria()
	}

	override calcularValor(Cuenta cuenta) {
		cuenta.saldo.add(this.monto)
	}

	

}
