package Classes {


	public class Form {

		//Dependências
		import flash.net.*;
		import flash.text.TextField;
		import flash.events.*;
		import flash.utils.Timer;

		//Cache
		var name_txt: TextField;
		var email_txt: TextField;
		var message_txt: TextField;
		var feedback_txt: TextField;

		const SENDING: String = "Sending";
		const SENT_SUCCESS: String = "Successful";
		const SENT_FAILED: String = "Unsuccessful";
		var url: String = "http://damformulario.epizy.com/php/sentEmail.php";
		var tmr: Timer;

		public function Form(email_txt: TextField, name_txt: TextField, message_txt: TextField, feedback_txt = null) {
			this.email_txt = email_txt;
			this.name_txt = name_txt;
			this.message_txt = message_txt;
			this.feedback_txt = feedback_txt;
			resetTextFields();

			setTextConfig();

		}

		private function resetTextFields(): void {
			name_txt.text = "";
			email_txt.text = "";
			message_txt.text = "";
			if (feedback_txt != null) {
				feedback_txt.visible = false;

			}

		}

		public function submitForm(evt: Event): void {
			clearErrors();

			var passChecks: Boolean = true;

			if (name_txt.text.length < 1) {
				if (feedback_txt != null) {
					feedback_txt.visible = true;
					feedback_txt.text = "Invalid subject";

				}

				passChecks = false;

			}

			if (!validateEmail(email_txt.text)) {
				if (feedback_txt != null) {
					feedback_txt.visible = true;
					feedback_txt.text = "Invalid email";

				}

				passChecks = false;

			}

			if (message_txt.text.length < 1) {
				if (feedback_txt != null) {
					feedback_txt.visible = true;
					feedback_txt.text = "Invalid message";

				}

				passChecks = false;

			}

			if (passChecks) {
				if (feedback_txt != null) {
					feedback_txt.visible = true;
					feedback_txt.text = SENDING;

				}

				var urlVars: URLVariables = new URLVariables();
				var urlReq: URLRequest = new URLRequest(url);
				var ldr: URLLoader = new URLLoader();

				urlVars.name = name_txt.text;
				urlVars.email = email_txt.text;
				urlVars.message = message_txt.text;
				
				urlReq.data = urlVars;
				urlReq.method = URLRequestMethod.POST;
				ldr.addEventListener(Event.COMPLETE, serverFeedback);
				ldr.load(urlReq);

			}

		}

		function clearErrors(): void {
			if (feedback_txt == null) {
				return;

			}

			feedback_txt.text = "";

		}

		function validateEmail(str: String): Boolean {
			var pattern: RegExp = /(\w|[_.\-])+@((\w|-)+\.)+\w{2,4}+/;
			var result: Object = pattern.exec(str);
			if (result == null) {
				return false;

			}

			return true;

		}

		function serverFeedback(evt: Event): void {
			var ldr: URLLoader = evt.target as URLLoader;
			
			ldr.dataFormat = URLLoaderDataFormat.VARIABLES;
			ldr.dataFormat = 'variables';
	
			trace(evt.target.data);
			var urlVars: URLVariables = new URLVariables(ldr.data);

			if (urlVars.result == SENT_SUCCESS) {
				feedback_txt.text = SENT_SUCCESS;
				resetTextFields();

			} else if (urlVars.result == SENT_FAILED) {
				feedback_txt.text = SENT_FAILED;

			}
			tmr = new Timer(3000, 1);
			tmr.addEventListener(TimerEvent.TIMER, afterTmrWait);
				
			tmr.start();

		}

		function afterTmrWait(evt: TimerEvent): void {
			tmr.stop();
			tmr.removeEventListener(TimerEvent.TIMER, afterTmrWait);
			resetContactForm();

		}


		function resetContactForm(): void {
			if (feedback_txt != null) {
				feedback_txt.visible = false;

			}

			clearErrors();

		}

		private function setTextConfig() {
			email_txt.multiline = false;
			email_txt.wordWrap = true;

			var emailPrevText: String;
			email_txt.addEventListener(Event.CHANGE, onUpdateEmail, false, 0, true);

			function onUpdateEmail(e: Event): void {
				if (email_txt.textHeight >= email_txt.height) {
					email_txt.text = emailPrevText;

				} else emailPrevText = email_txt.text;

			}

			name_txt.multiline = false;
			name_txt.wordWrap = true;

			var namePrevText: String;
			name_txt.addEventListener(Event.CHANGE, onUpdateName, false, 0, true);

			function onUpdateName(e: Event): void {
				if (name_txt.textHeight >= name_txt.height) {
					name_txt.text = namePrevText;

				} else namePrevText = name_txt.text;

			}

			message_txt.multiline = true;
			message_txt.wordWrap = true;

			var messagePrevText: String;
			message_txt.addEventListener(Event.CHANGE, onUpdateMessage, false, 0, true);

			function onUpdateMessage(e: Event): void {
				if (message_txt.textHeight >= message_txt.height) {
					message_txt.text = messagePrevText;

				} else messagePrevText = message_txt.text;

			}

		}

	}

}