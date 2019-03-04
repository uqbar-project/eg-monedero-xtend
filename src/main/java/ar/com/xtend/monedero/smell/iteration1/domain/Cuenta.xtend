package ar.com.xtend.monedero.smell.iteration1.domain

import java.math.BigDecimal
import java.util.ArrayList
import java.util.List
import java.util.Date
import ar.com.xtend.monedero.smell.exceptions.MontoNegativoException
import ar.com.xtend.monedero.smell.exceptions.MaximaCantidadDepositosException
import ar.com.xtend.monedero.smell.exceptions.MaximoExtraccionDiarioException
import ar.com.xtend.monedero.smell.exceptions.SaldoMenorException

class Cuenta {
	val MAX_DEPOSITOS_EN_DIA = 3
	val MAXIMO_EXTRACCION_DIARIO = 1000
	
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
		validarMonto(cuanto)
		validarCantidadDeDepositosDiaria()				
		new Movimiento(new Date(),cuanto,true).agregateA(this)
	}

	def sacar(BigDecimal cuanto) {
		validarMonto(cuanto)
		validarSaldoDisponibleParaExtraer(cuanto)
	    validarLimiteExtraccionDiario(cuanto)
		new Movimiento(new Date(),cuanto,false).agregateA(this)
	}
	
	// ********************************************************
	// ** Validations
	// ********************************************************

	def validarSaldoDisponibleParaExtraer(BigDecimal cuanto) {
		if (this.getSaldo().subtract(cuanto).doubleValue() < 0) {
			throw new SaldoMenorException("No puede sacar más de " + this.getSaldo() + " $")
		}
	}

	def validarLimiteExtraccionDiario(BigDecimal cuanto) {
		var montoExtraidoHoy = this.getMontoExtraidoA(new Date())
		var limite = new BigDecimal(MAXIMO_EXTRACCION_DIARIO).subtract(montoExtraidoHoy)
		if (cuanto.doubleValue() > limite.doubleValue()) {
			throw new MaximoExtraccionDiarioException("No puede extraer más de $ " + MAXIMO_EXTRACCION_DIARIO + " diarios, límite: " + limite)
		}
	}

	def validarCantidadDeDepositosDiaria() {
		if (this.getDepositos(new Date()).size() >= MAX_DEPOSITOS_EN_DIA) {
			throw new MaximaCantidadDepositosException("Ya excedió los " + MAX_DEPOSITOS_EN_DIA + " depósitos diarios")
		}
	}
	/**/
	def validarMonto(BigDecimal cuanto) {
		if (cuanto.doubleValue() <= 0) {
			throw new MontoNegativoException(cuanto + ": el monto a ingresar debe ser un valor positivo")
		}
	}
	
	// ********************************************************
	// ** Movimientos
	// ********************************************************

	def agregarMovimiento(Movimiento movimiento) {
			this.movimientos.add(movimiento)
		}
	
	def getDepositos(Date fecha) {
		var depositos = new ArrayList<Movimiento>()
		for (Movimiento movimiento : this.getMovimientos()) {
			if (movimiento.fueDepositado(fecha)) {
				depositos.add(movimiento)
			}
		}
		return depositos
	}

	def getExtracciones(Date fecha) {
		var extracciones = new ArrayList<Movimiento>()
		for (Movimiento movimiento : this.getMovimientos()) {
			if (movimiento.fueExtraido(fecha)) {
				extracciones.add(movimiento)
			}
		}
		return extracciones
	}

	def getMontoExtraidoA(Date fecha) {
		var total = new BigDecimal(0)
		for (Movimiento movimiento : this.getExtracciones(fecha))  {
			total = total.add(movimiento.getMonto())
		}
		return total
	}

	def getMovimientos() {
		this.movimientos
	}

	// ********************************************************
	// ** Accessors
	// ********************************************************

	def getSaldo() {
		this.saldo
	}

	def setSaldo(BigDecimal saldo) {
		this.saldo = saldo
	}

}
