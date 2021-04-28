package Classes {

	public class PortfolioSlide {

		import flash.text.TextField;
		import flash.events.KeyboardEvent;
		import flash.events.Event;
		import Classes.Movie;
		import flash.net.*;

		var worksList: XMLList;
		var slideIndex: int = 0;

		var loader: URLLoader;

		var title_txt: TextField;
		var smallDescription_txt: TextField;
		var bigDescription_txt: TextField;
		var movie: Movie;

		public function PortfolioSlide(xmlRequestURL: String, title_txt: TextField, smallDescription_txt: TextField, bigDescription_txt: TextField, movie: Movie) {
			loader = new URLLoader();
			loader.load(new URLRequest(xmlRequestURL));

			this.title_txt = title_txt;
			this.smallDescription_txt = smallDescription_txt;
			this.bigDescription_txt = bigDescription_txt;
			this.movie = movie;

			title_txt.multiline = true;
			title_txt.wordWrap = true;

			this.smallDescription_txt.multiline = true;
			this.smallDescription_txt.wordWrap = true;
			
			this.bigDescription_txt.multiline = true;
			this.bigDescription_txt.wordWrap = true;

			loader.addEventListener(Event.COMPLETE, completeXMLLoader);

		}

		private function completeXMLLoader(e: Event): void {
			var xml: XML = new XML(e.target.data);
			worksList = xml.work;

			updateSlide(checkSlideIndex(worksList, 0));

			loader.removeEventListener(Event.COMPLETE, completeXMLLoader);
			
		}


		private function updateSlide(index: Number): void {
			title_txt.text = worksList[index].@Name;
			smallDescription_txt.text = worksList[index].@SmallDescription;
			bigDescription_txt.text = worksList[index].@BigDescription;
			movie.setLocation(worksList[index].@MovieURL);
			movie.launchMovie();
			
		}

		private function checkSlideIndex(slideArray: XMLList, index: Number): Number {
			if (index <= -1) {
				slideIndex = 0;
				
			} else if (index >= slideArray.length()) {
				slideIndex = slideArray.length() - 1;
				
			}
			
			return slideIndex;
			
		}

		public function controlSlide(event: KeyboardEvent): void {
			if (event.keyCode == 39) {
				updateSlide(checkSlideIndex(worksList, ++slideIndex));
				
			} else if (event.keyCode == 37) {
				updateSlide(checkSlideIndex(worksList, --slideIndex));

			}

		}
		
		public function showNextSlide(event: Event = null): void {
			updateSlide(checkSlideIndex(worksList, ++slideIndex));
		}
		
		public function showPreviousSlide(event: Event = null): void {
			updateSlide(checkSlideIndex(worksList, --slideIndex));
		}

	}
	
}