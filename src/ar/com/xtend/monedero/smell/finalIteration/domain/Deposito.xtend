package ar.com.xtend.monedero.smell.finalIteration.domain;

import java.math.BigDecimal;
import java.util.Date;

public class Deposito extends Movimiento {

	new(Date fecha, BigDecimal monto) {
		super(fecha, monto);
	}

	@Override
	override isDeposito() {
		true;
	}

	@Override
	override isExtraccion() {
		false;
	}

	@Override
	override validar(Cuenta cuenta) {
		cuenta.validarCantidadDeDepositosDiaria();
	}

	@Override
	override calcularValor(Cuenta cuenta) {
		cuenta.getSaldo().add(this.getMonto());
	}

	

}
