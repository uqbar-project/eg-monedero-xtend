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

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class MonederoPanel extends SimpleWindow<MonederoModel> {

	static String MENSAJE_ERROR_PROGRAMA = "Ocurrió un error en la aplicación. Consulte al administrador"
	
	new(WindowOwner owner, MonederoModel model) {
		super(owner, model)
		title = "Monedero"
		taskDescription = "Ingrese el monto en $ a poner/sacar del monedero"
	}

	override protected createFormPanel(Panel mainPanel) {
		new Panel(mainPanel) => [
			layout = new ColumnLayout(2)
			new Label(it).text = "Monto a ingresar"
			// o new NumericField(it)
			new TextBox(it) => [
				width = 150
				value <=> "montoAIngresar"
			]
			new Label(it).text = "$ actual"
			new Label(it) => [
				value <=> "montoActual"
				width = 150
			]
		]
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
			showError(MENSAJE_ERROR_PROGRAMA)
		}
	}

	def void sacar() {
		try {
			(modelObject as MonederoModel).sacar
		} catch (BusinessException e) {
			showWarning(e.message)
		} catch (Exception e) {
			showError(MENSAJE_ERROR_PROGRAMA)
		}
	}
	
}
