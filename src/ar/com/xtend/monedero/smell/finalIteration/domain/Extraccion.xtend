package ar.com.xtend.monedero.smell.finalIteration.domain;

import java.math.BigDecimal;
import java.util.Date;

public class Extraccion extends Movimiento {
	new(Date fecha, BigDecimal monto) {
		super(fecha, monto);
	}

	@Override
	override isDeposito() {
		 false;
	}

	@Override
	override isExtraccion() {
		true;
	}

	@Override
	override validar(Cuenta cuenta) {
		cuenta.validarLimiteExtraccionDiario(this.getMonto());
		cuenta.validarSaldoDisponibleParaExtraer(this.getMonto());
	}
	
	@Override
	override calcularValor(Cuenta cuenta) {
		cuenta.getSaldo().subtract(this.getMonto());
	}

}
