package Classes {

	public class NavegationController {

		//Dependências
		import flash.events.MouseEvent;
		import flash.events.TouchEvent;
		import flash.events.FocusEvent;
		import flash.display.SimpleButton;
		import flash.display.MovieClip;
		import flash.net.URLRequest;
		import flash.net.navigateToURL;
		import flash.events.Event;
		import flash.display.Stage;
		import flash.desktop.NativeApplication;


		var buttonsInScene: Array = new Array();
		var isDesktop: Boolean;

		public function NavegationController(isDesktop: Boolean = true) {
			this.isDesktop = isDesktop;

		}
		
		public function addButtonQuitApplication(btnId: SimpleButton): void {
			buttonsInScene.push(new Array(btnId, isDesktop ? MouseEvent.MOUSE_DOWN : TouchEvent.TOUCH_TAP, quitApplication()));
			btnId.addEventListener(buttonsInScene[buttonsInScene.length - 1][1], buttonsInScene[buttonsInScene.length - 1][2]);

		}
		
		private function quitApplication(): Function {
			return function (): void {
				NativeApplication.nativeApplication.exit();

			}

		}


		public function addButtonGoToScene(btnId: SimpleButton, movieClip: MovieClip, frame: Number, scene: String): void {
			buttonsInScene.push(new Array(btnId, isDesktop ? MouseEvent.MOUSE_DOWN : TouchEvent.TOUCH_TAP, goToScene(movieClip, frame, scene)));
			//trace("/// Botoes em cena: " + buttonsInScene.length + " Btn nome: " + btnId.name + " to " + scene);
			btnId.addEventListener(buttonsInScene[buttonsInScene.length - 1][1], buttonsInScene[buttonsInScene.length - 1][2]);

		}

		private function goToScene(movieClip: MovieClip, frame: Number, scene: String): Function {
			return function (event: Event): void {
				removeAllButtonsEvents();
				movieClip.gotoAndPlay(frame, scene);

			}

		}

		public function addButtonOpenLink(btnId: SimpleButton, link: String): void {
			buttonsInScene.push(new Array(btnId, isDesktop ? MouseEvent.MOUSE_DOWN : TouchEvent.TOUCH_TAP, openLink(link)));
			//trace("/// Botoes em cena: " + buttonsInScene.length);
			btnId.addEventListener(buttonsInScene[buttonsInScene.length - 1][1], buttonsInScene[buttonsInScene.length - 1][2]);

		}

		private function openLink(link: String): Function {
			return function (event: Event): void {
				var url: String = link;
				var urlReq: URLRequest = new URLRequest(url);
				navigateToURL(urlReq);

			}

		}

		public function addButtonFunction(btnId: SimpleButton, specificFunction: Function): void {
			buttonsInScene.push(new Array(btnId, isDesktop ? MouseEvent.MOUSE_DOWN : TouchEvent.TOUCH_TAP, specificFunction));
			//trace("/// Botoes em cena: " + buttonsInScene.length);
			btnId.addEventListener(buttonsInScene[buttonsInScene.length - 1][1], buttonsInScene[buttonsInScene.length - 1][2]);

		}

		public function addButtonOverWithSubmenu(btnFatherId: SimpleButton, btnSonsId: Array, submenuBackground: MovieClip): void {
			var btnSonsIndex: Array = new Array();
			for each(var btn in btnSonsId) {
				btn.visible = false;
				btnSonsIndex.push(buttonsInScene.length);
				buttonsInScene.push(new Array(btn, isDesktop ? MouseEvent.MOUSE_OVER : TouchEvent.TOUCH_TAP, null));

			}

			var submenuBackgroundIndex: Number = buttonsInScene.length;
			buttonsInScene.push(new Array(submenuBackground, isDesktop ? MouseEvent.MOUSE_OUT : TouchEvent.TOUCH_TAP, null));

			buttonsInScene[submenuBackgroundIndex][2] = hideSubmenu(buttonsInScene.length, btnSonsIndex, submenuBackgroundIndex);

			for each(var btnIndex in btnSonsIndex) {
				buttonsInScene[btnIndex][2] = revealSubmenu(buttonsInScene.length, btnSonsIndex, submenuBackgroundIndex);

			}

			buttonsInScene.push(new Array(btnFatherId, isDesktop ? MouseEvent.MOUSE_OVER : TouchEvent.TOUCH_TAP, revealSubmenu(buttonsInScene.length, btnSonsIndex, submenuBackgroundIndex)));

			btnFatherId.addEventListener(buttonsInScene[buttonsInScene.length - 1][1], buttonsInScene[buttonsInScene.length - 1][2]);

			btnFatherId.visible = true;

		}

		private function revealSubmenu(btnFatherIndex: Number, btnSonsIndex: Array, submenuBackgroundIndex: Number): Function {
			return function (event: Event): void {
				buttonsInScene[btnFatherIndex][0].visible = false;

				buttonsInScene[btnFatherIndex][0].removeEventListener(buttonsInScene[btnFatherIndex][1], buttonsInScene[btnFatherIndex][2]);

				for each(var btnIndex in btnSonsIndex) {
					buttonsInScene[btnIndex][0].visible = true;
					buttonsInScene[btnIndex][0].removeEventListener(buttonsInScene[btnIndex][1], buttonsInScene[btnIndex][2]);

				}

				buttonsInScene[submenuBackgroundIndex][0].addEventListener(buttonsInScene[submenuBackgroundIndex][1], buttonsInScene[submenuBackgroundIndex][2]);

			}

		}

		private function hideSubmenu(btnFatherIndex: Number, btnSonsIndex: Array, submenuBackgroundIndex: Number): Function {
			return function (event: Event): void {
				buttonsInScene[btnFatherIndex][0].visible = true;

				buttonsInScene[btnFatherIndex][0].addEventListener(buttonsInScene[btnFatherIndex][1], buttonsInScene[btnFatherIndex][2]);

				for each(var btnIndex in btnSonsIndex) {
					buttonsInScene[btnIndex][0].visible = false;
					buttonsInScene[btnIndex][0].addEventListener(buttonsInScene[btnIndex][1], buttonsInScene[btnIndex][2]);

				}

				buttonsInScene[submenuBackgroundIndex][0].removeEventListener(buttonsInScene[submenuBackgroundIndex][1], buttonsInScene[submenuBackgroundIndex][2]);

			}

		}

		public function addButtonGoToFrame(btnId: SimpleButton, movieClip: MovieClip, frame: Number): void {
			removeButtonEvent(btnId, (isDesktop ? MouseEvent.MOUSE_DOWN : TouchEvent.TOUCH_TAP).toString());
			buttonsInScene.push(new Array(btnId, isDesktop ? MouseEvent.MOUSE_DOWN : TouchEvent.TOUCH_TAP, goToFrame(movieClip, frame)));
			btnId.addEventListener(buttonsInScene[buttonsInScene.length - 1][1], buttonsInScene[buttonsInScene.length - 1][2]);

		}
		/*
		public function AddKeyboardgFrameNavigation(stageRef: Stage, direction: String, frame: Number): void{
			stage.removeEventListener(
			RemoveButtonEvent(btnId, (isDesktop ? MouseEvent.MOUSE_DOWN : TouchEvent.TOUCH_TAP).toString());
			buttonsInScene.push(new Array(btnId, isDesktop ? MouseEvent.MOUSE_DOWN : TouchEvent.TOUCH_TAP, GoToFrame(movieClip, frame)));
			btnId.addEventListener(buttonsInScene[buttonsInScene.length - 1][1], buttonsInScene[buttonsInScene.length - 1][2]);
		}
		*/
		private function goToFrame(movieClip: MovieClip, frame: Number): Function {
			return function (event: Event): void {
				movieClip.gotoAndPlay(frame);

			}

		}

		public function removeButtonEvent(btnId: SimpleButton, eventName: String) {
			for (var index: Number = buttonsInScene.length - 1; index >= 0; index--) {
				if (buttonsInScene[index][2] == null) {
					continue;

				}

				if (buttonsInScene[index][0].name == btnId.name && buttonsInScene[index][1].toString() == eventName) {
					buttonsInScene[index][0].removeEventListener(buttonsInScene[index][1], buttonsInScene[index][2]);
					buttonsInScene.splice(index, 1);
					//trace("/<<<< Botoes em cena: " + buttonsInScene.length + " Btn nome: " + buttonsInScene[index][0].name + " to " + buttonsInScene[index][1]);

				}

			}

		}

		public function removeAllButtonsEvents(): void {
			for (var index: Number = buttonsInScene.length - 1; index >= 0; index--) {
				if (buttonsInScene[index][0] == null || buttonsInScene[index][1] == null || buttonsInScene[index][2] == null) {
					trace("Erro");
					continue;

				} else {
					buttonsInScene[index][0].removeEventListener(buttonsInScene[index][1], buttonsInScene[index][2]);
					//trace("/<<<< Botoes em cena: " + buttonsInScene.length + " Btn nome: " + buttonsInScene[index][0].name + " to " + buttonsInScene[index][1]);

				}

				buttonsInScene.pop();
			}

		}

	}

}