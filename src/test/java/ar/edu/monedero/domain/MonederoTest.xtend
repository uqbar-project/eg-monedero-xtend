package ar.edu.monedero.domain

import ar.edu.monedero.exceptions.BusinessException
import java.math.BigDecimal
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

import static org.junit.jupiter.api.Assertions.assertEquals
import static org.junit.jupiter.api.Assertions.assertThrows

@DisplayName("Dado un monedero")
class MonederoTest {
	
	Monedero monedero
	
	@BeforeEach
	def void init() {
		monedero = new Monedero(100)
	}
	
	@DisplayName("Al poner plata sube el monto del monedero")
	@Test
	def void ponerMontoMayorACeroDebePoderse() {
		monedero.poner(new BigDecimal(50))
		assertEquals(new BigDecimal(150), monedero.monto)
	}

	@DisplayName("No se puede poner un monto negativo")
	@Test
	def void ponerMontoNegativoDebeFallar() {
		assertThrows(BusinessException, [ monedero.poner(new BigDecimal(-50))])
	}

	@DisplayName("No se puede poner 0 pesos")
	@Test
	def void ponerCeroPesosDebeFallar() {
		assertThrows(BusinessException, [ monedero.poner(new BigDecimal(0))])
	}

	@DisplayName("Al sacar plata baja el monto del monedero")
	@Test
	def void sacarMontoMayorACeroDebePoderse() {
		monedero.sacar(new BigDecimal(50))
		assertEquals(new BigDecimal(50), monedero.monto)
	}

	@DisplayName("No se puede sacar un monto negativo")
	@Test
	def void sacarMontoNegativoDebeFallar() {
		assertThrows(BusinessException, [ monedero.sacar(new BigDecimal(-50))])
	}

	@DisplayName("No se puede sacar 0 pesos")
	@Test
	def void sacarCeroPesosDebeFallar() {
		assertThrows(BusinessException, [ monedero.sacar(new BigDecimal(0))])
	}

	@DisplayName("No se puede sacar más plata de la que hay")
	@Test
	def void sacarMasPlataQueLaDisponibleDebeFallar() {
		assertThrows(BusinessException, [ monedero.sacar(new BigDecimal(101))])
	}

	@DisplayName("Al sacar toda la plata el monedero debe quedar en 0 - caso borde")
	@Test
	def void sacarTodaLaPlataDejaElMonederoEnCero() {
		monedero.sacar(new BigDecimal(100))
		assertEquals(new BigDecimal(0), monedero.monto)
	}

}