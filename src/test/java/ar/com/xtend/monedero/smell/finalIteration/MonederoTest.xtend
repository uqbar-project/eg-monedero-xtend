package ar.com.xtend.monedero.smell.finalIteration

import ar.com.xtend.monedero.smell.exceptions.MaximaCantidadDepositosException
import ar.com.xtend.monedero.smell.exceptions.MaximoExtraccionDiarioException
import ar.com.xtend.monedero.smell.exceptions.MontoNegativoException
import ar.com.xtend.monedero.smell.exceptions.SaldoMenorException
import ar.com.xtend.monedero.smell.finalIteration.domain.Cuenta
import java.math.BigDecimal
import org.junit.Before
import org.junit.Test

class MonederoTest {
	var Cuenta cuenta

	@Before
	def void init() {
		cuenta = new Cuenta()
	}

	@Test
	def void Poner() {
		cuenta.poner(new BigDecimal(1500))
	}

	@Test
	def void PonerMontoNegativo() throws Exception {
		try {
			cuenta.poner(new BigDecimal(-1500))
		} catch (MontoNegativoException ex) {
		}

	}

	@Test
	def void TresDepositos() {
		cuenta.poner(new BigDecimal(1500))
		cuenta.poner(new BigDecimal(456))
		cuenta.poner(new BigDecimal(1900))
	}

	@Test
	def void MasDeTresDepositos() {
		try {
			cuenta.poner(new BigDecimal(1500))
			cuenta.poner(new BigDecimal(456))
			cuenta.poner(new BigDecimal(1900))
			cuenta.poner(new BigDecimal(245))
		} catch (MaximaCantidadDepositosException ex) {
		}

	}

	@Test
	def void ExtraerMasQueElSaldo() {
		try {
			cuenta.setSaldo(new BigDecimal(90))
			cuenta.sacar(new BigDecimal(500))
		} catch (SaldoMenorException ex) {
		}
	}

	@Test
	def void ExtraerMasDe1000() {
		try {
			cuenta.setSaldo(new BigDecimal(5000))
			cuenta.sacar(new BigDecimal(1001))
		} catch (MaximoExtraccionDiarioException ex) {
		}
	}

	@Test
	def void ExtraerMontoNegativo() {
		try {
			cuenta.sacar(new BigDecimal(-500))
		} catch (MontoNegativoException ex) {
		}
	}

}
