package ar.edu.monedero;

import com.uqbar.commons.exceptions.BusinessException;
import java.math.BigDecimal;

@SuppressWarnings("all")
public class Monedero {
  private BigDecimal monto;
  
  public void sacar(final BigDecimal cuanto) {
    this.validarMonto(cuanto);
    boolean _lessThan = (this.monto.compareTo(cuanto) < 0);
    if (_lessThan) {
      String _plus = ("No puede sacar más de " + this.monto);
      String _plus_1 = (_plus + " $");
      BusinessException _businessException = new BusinessException(_plus_1);
      throw _businessException;
    }
    BigDecimal _negate = cuanto.negate();
    this.sumarMonto(_negate);
  }
  
  public BigDecimal sumarMonto(final BigDecimal valor) {
    BigDecimal _add = this.monto.add(valor);
    BigDecimal _monto = this.monto = _add;
    return _monto;
  }
  
  public void validarMonto(final BigDecimal cuanto) {
    double _doubleValue = cuanto.doubleValue();
    boolean _lessEqualsThan = (_doubleValue <= 0);
    if (_lessEqualsThan) {
      String _plus = (cuanto + ": el monto a ingresar debe ser un valor positivo");
      BusinessException _businessException = new BusinessException(_plus);
      throw _businessException;
    }
  }
}
