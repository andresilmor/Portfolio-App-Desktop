package Classes {

	public class Scroll {

		import flash.display.MovieClip;
		import flash.display.Stage;
		import flash.events.MouseEvent;
		import flash.events.KeyboardEvent;
		import flash.events.Event;

		var up: Boolean = false;
		var down: Boolean = true;

		var isScrollUp: Boolean = false;
		var isScrollDown: Boolean = false;

		var scrollPage_mc: MovieClip;
		var stageRef: Stage;
		var scrollSensivity: Number;

		public function Scroll(stageRef: Stage, scrollPage_mc: MovieClip, scrollSensivity: Number = 15, haveWheelControl: Boolean = false, haveKeyboardControl: Boolean = false) {
			this.scrollSensivity = scrollSensivity;
			this.scrollPage_mc = scrollPage_mc;
			this.stageRef = stageRef;

			if (haveWheelControl)
				addWheelControl();
			if (haveKeyboardControl)
				addKeyboardControl();

			stageRef.addEventListener(Event.ENTER_FRAME, onScrollUp);
			stageRef.addEventListener(Event.ENTER_FRAME, onScrollDown)

		}

		public function addWheelControl() {
			stageRef.addEventListener(MouseEvent.MOUSE_WHEEL, controlScroll);
			
		}

		public function addKeyboardControl() {
			stageRef.addEventListener(KeyboardEvent.KEY_DOWN, detectKeyOn);
			stageRef.addEventListener(KeyboardEvent.KEY_UP, detectKeyOff);
			
		}

		private function controlScroll(event: MouseEvent): void {
			if (event.delta > 0) {
				isScrollDown = false;
				isScrollUp = true;
				
			} else if (event.delta < 0) {
				isScrollUp = false;
				isScrollDown = true;
				
			}
			
		}

		private function detectKeyOn(event: KeyboardEvent): void {
			if (event.keyCode == 38) {
				isScrollDown = false;
				isScrollUp = true;
				
			} else if (event.keyCode == 40) {
				isScrollUp = false;
				isScrollDown = true;
				
			}
			
		}

		function detectKeyOff(event: KeyboardEvent): void {
			if (event.keyCode == 38) {
				isScrollUp = false;
				
			} else if (event.keyCode == 40) {
				isScrollDown = false;
				
			}
			
		}


		function onScrollDown(event: Event): void {
			if (scrollPage_mc.y <= 200) {
				up = true;

			} else if (isScrollDown && !up) {
				down = false;
				scrollPage_mc.y -= scrollSensivity;
				
			}
			
			isScrollDown = false;
			
		}

		function onScrollUp(event: Event): void {
			if (scrollPage_mc.y >= 740) {
				down = true;

			} else if (isScrollUp && !down) {
				up = false;
				scrollPage_mc.y += scrollSensivity;

			}
			
			isScrollUp = false;
			
		}
		
		public function goTop(event:Event = null):void {
			scrollPage_mc.y = 740;
		}

		public function removeScrollWheelEventListener(event: Event = null): void {
			stageRef.removeEventListener(MouseEvent.MOUSE_WHEEL, controlScroll);
			removeScrollDefaultEventListener();
			
		}

		public function removeScrollKeyboardEventListener(event: Event = null): void {
			stageRef.removeEventListener(MouseEvent.MOUSE_UP, detectKeyOn);
			stageRef.removeEventListener(MouseEvent.MOUSE_DOWN, detectKeyOff);
			removeScrollDefaultEventListener();
			
		}

		private function removeScrollDefaultEventListener(): void {
			stageRef.removeEventListener(Event.ENTER_FRAME, onScrollUp);
			stageRef.removeEventListener(Event.ENTER_FRAME, onScrollDown)
			
		}

	}

}