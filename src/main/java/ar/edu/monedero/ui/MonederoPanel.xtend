package ar.edu.monedero.ui

import ar.edu.monedero.domain.MonederoModel
import ar.edu.monedero.exceptions.BusinessException
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

class MonederoPanel extends SimpleWindow<MonederoModel> {

	new(WindowOwner owner, MonederoModel model) {
		super(owner, model)
	}

	override protected createFormPanel(Panel mainPanel) {
		val form = new Panel(mainPanel)
		form.layout = new ColumnLayout(2)
		new Label(form).text = "Monto a ingresar"
		val textMontoAIngresar = new TextBox(form)
		textMontoAIngresar.bindValueToProperty("montoAIngresar")
		new Label(form).text = "$ actual"
		new Label(form).bindValueToProperty("montoActual")
	}

	override protected void addActions(Panel actions) {
		new Button(actions).setCaption("Poner").onClick[|this.poner]

		new Button(actions) //
		.setCaption("Sacar").onClick[|this.sacar]
	}
	
	def void poner() {
		try {
			(modelObject as MonederoModel).poner
		} catch (BusinessException e) {
			showWarning(e.message)
		} catch (Exception e) {
			showError("Ocurrió un error en la aplicación. Consulte al administrador")
		}
	}

	def void sacar() {
		try {
			(modelObject as MonederoModel).sacar
		} catch (BusinessException e) {
			showWarning(e.message)
		} catch (Exception e) {
			showError("Ocurrió un error en la aplicación. Consulte al administrador")
		}
	}
	
}
