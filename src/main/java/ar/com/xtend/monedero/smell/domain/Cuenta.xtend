package ar.com.xtend.monedero.smell.domain

import ar.com.xtend.monedero.smell.exceptions.MaximaCantidadDepositosException
import ar.com.xtend.monedero.smell.exceptions.MaximoExtraccionDiarioException
import ar.com.xtend.monedero.smell.exceptions.MontoNegativoException
import ar.com.xtend.monedero.smell.exceptions.SaldoMenorException
import java.math.BigDecimal
import java.util.ArrayList
import java.util.Date
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
public class Cuenta {
	var BigDecimal saldo = new BigDecimal(0)
	var List<Movimiento> movimientos

	// ********************************************************
	// ** Constructors & initialization
	// ********************************************************

	new(){
		this.saldo = new BigDecimal(0)
		this.inicializar()
	}
	
	new(double montoInicial) {
		this.saldo = new BigDecimal(montoInicial)
		this.inicializar()
	}

	def inicializar() {
		this.movimientos = new ArrayList<Movimiento>()
	}

	// ********************************************************
	// ** Actions
	// ********************************************************

	def poner(BigDecimal cuanto) {
		if (cuanto.doubleValue() <= 0) {
			throw new MontoNegativoException(cuanto + ": el monto a ingresar debe ser un valor positivo")
		}
		if (this.getMovimientos().filter(movimiento | movimiento.isDeposito()).size() >= 3)
			{
				throw new MaximaCantidadDepositosException("Ya excedi� los " + 3 + " dep�sitos diarios")
			}
				
		new Movimiento(new Date(),cuanto,true).agregateA(this)
	}

	def sacar(BigDecimal cuanto) {
		if (cuanto.doubleValue() <= 0) {
			throw new MontoNegativoException(cuanto + ": el monto a ingresar debe ser un valor positivo")
		}
		if (this.getSaldo().subtract(cuanto).doubleValue() < 0) {
			throw new SaldoMenorException("No puede sacar m�s de " + this.getSaldo() + " $")
		}
		var montoExtraidoHoy = this.getMontoExtraidoA(new Date())
		var limite = new BigDecimal(1000).subtract(montoExtraidoHoy)
		if (cuanto.doubleValue() > limite.doubleValue()) {
			throw new MaximoExtraccionDiarioException("No puede extraer m�s de $ " + 1000 + " diarios, l�mite: " + limite)
		}
		new Movimiento(new Date(),cuanto,false).agregateA(this)
	}

	// ********************************************************
	// ** Movimientos
	// ********************************************************

	def agregarMovimiento(Date fecha, BigDecimal cuanto, boolean esDeposito) {
		var movimiento = new Movimiento(fecha, cuanto, esDeposito)
		this.movimientos.add(movimiento)
	}

	def getMontoExtraidoA(Date fecha) {
		var total = new BigDecimal(0)
				
		for (Movimiento movimiento : this.getMovimientos().filter(movimiento | !movimiento.isDeposito() 
			 && movimiento.fecha == fecha))  {
				total = total.add(movimiento.getMonto())
		}
		return total
	}

	def getMovimientos() {
		this.movimientos
	}

}
