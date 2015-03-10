package ar.edu.monedero.runnable

import ar.edu.monedero.domain.MonederoModel
import ar.edu.monedero.ui.MonederoPanel
import org.uqbar.arena.Application
import org.uqbar.arena.windows.Window
import ar.edu.monedero.domain.Monedero

class MonederoApplication extends Application {
	
	static def void main(String[] args) { 
		new MonederoApplication().start
	}

	override protected Window<?> createMainWindow() {
		return new MonederoPanel(this, new MonederoModel(new Monedero(50)))
	}
	
}