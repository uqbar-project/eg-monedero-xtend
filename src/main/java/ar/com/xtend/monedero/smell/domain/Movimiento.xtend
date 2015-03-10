package ar.com.xtend.monedero.smell.domain

import java.math.BigDecimal
import java.text.DateFormat
import java.util.Date
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
public class Movimiento {
	Date fecha
	BigDecimal monto
	boolean esDeposito

	new(Date fecha, BigDecimal monto, boolean esDeposito) {
		this.fecha = fecha
		this.monto = monto
		this.esDeposito = esDeposito
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

	/* */
	def boolean isDeposito() {
		esDeposito
	}

	def boolean isExtraccion() {
		esDeposito
	}

	// ********************************************************
	// ** Validaciones
	// ********************************************************
	/* def ObtenerGanancia(Cuenta cuenta)
	{
	* 		if (cuenta.nombre == "Dodino")
				
				if (esDeposito)
				{
					var cuentaJavi = new Cuenta()
					var cuentaChris = new Cuenta()
					var cuentaPablo = new Cuenta()
					cuentajavi.saldo += cuenta.saldo * 0.25
					cuentaChris.saldo += cuenta.saldo * 0.25
					cuentaPablo.saldo += cuenta.saldo * 0.5
					cuenta.saldo = 0
				}
			
	}*/
	def agregateA(Cuenta cuenta) {
		cuenta.setSaldo(this.calcularValor(cuenta))
		cuenta.agregarMovimiento(fecha, monto, esDeposito)
	}

	def BigDecimal calcularValor(Cuenta cuenta) {
		if (esDeposito) {
			cuenta.saldo.add(this.monto)
		} else {
			cuenta.saldo.subtract(this.monto)
		}
	}
}
