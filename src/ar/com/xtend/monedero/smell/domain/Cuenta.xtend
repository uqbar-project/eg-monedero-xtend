package ar.com.xtend.monedero.smell.domain

import java.math.BigDecimal
import java.util.ArrayList
import java.util.List
import java.util.Date

public class Cuenta {
	val SALDO = "saldo";

	var BigDecimal saldo = new BigDecimal(0);
	var List<Movimiento> movimientos;

	// ********************************************************
	// ** Constructors & initialization
	// ********************************************************

	new(){
		this.saldo = new BigDecimal(0);
		this.inicializar();
	}
	
	new(double montoInicial) {
		this.saldo = new BigDecimal(montoInicial);
		this.inicializar();
	}

	def inicializar() {
		this.movimientos = new ArrayList<Movimiento>();
	}

	// ********************************************************
	// ** Actions
	// ********************************************************

	def poner(BigDecimal cuanto) {
		if (cuanto.doubleValue() <= 0) {
			throw new Exception(cuanto + ": el monto a ingresar debe ser un valor positivo");
		}
		if (this.getSaldo().subtract(cuanto).doubleValue() < 0) {
			throw new Exception("No puede sacar más de " + this.getSaldo() + " $");
		}
		var montoExtraidoHoy = this.getMontoExtraidoA(new Date());
		var limite = new BigDecimal(1000).subtract(montoExtraidoHoy);
		if (cuanto.doubleValue() > limite.doubleValue()) {
			throw new Exception("No puede extraer más de $ " + 1000 + " diarios, límite: " + limite);
		}
		if (this.getMovimientos().filter(movimiento | movimiento.isDeposito()).size() >= 3)
			{
				throw new Exception("Ya excedió los " + 3 + " depósitos diarios");
			}
				
		new Movimiento(new Date(),cuanto,true).agregateA(this)
	}

	def sacar(BigDecimal cuanto) {
		if (cuanto.doubleValue() <= 0) {
			throw new Exception(cuanto + ": el monto a ingresar debe ser un valor positivo");
		}
		if (this.getSaldo().subtract(cuanto).doubleValue() < 0) {
			throw new Exception("No puede sacar más de " + this.getSaldo() + " $");
		}
		var montoExtraidoHoy = this.getMontoExtraidoA(new Date());
		var limite = new BigDecimal(1000).subtract(montoExtraidoHoy);
		if (cuanto.doubleValue() > limite.doubleValue()) {
			throw new Exception("No puede extraer más de $ " + 1000 + " diarios, límite: " + limite);
		}
		if (this.getMovimientos().filter(movimiento | movimiento.isDeposito()).size() >= 3)
			{
				throw new Exception("Ya excedió los " + 3 + " depósitos diarios");
			}
		new Movimiento(new Date(),cuanto,false).agregateA(this)
	}

	// ********************************************************
	// ** Movimientos
	// ********************************************************

	def agregarMovimiento(Date fecha, BigDecimal cuanto, boolean esDeposito) {
		var movimiento = new Movimiento(fecha, cuanto, esDeposito)
		this.movimientos.add(movimiento);
	}


	def getMontoExtraidoA(Date fecha) {
		var total = new BigDecimal(0);
				
		for (Movimiento movimiento : this.getMovimientos().filter(movimiento | !movimiento.isDeposito() && movimiento.fecha == fecha))  {
			total = total.add(movimiento.getMonto());
		}
		return total;
	}

	def getMovimientos() {
		this.movimientos;
	}

	// ********************************************************
	// ** Accessors
	// ********************************************************

	def getSaldo() {
		this.saldo;
	}

	def setSaldo(BigDecimal saldo) {
		this.saldo = saldo;
	}

}
