package Classes {

	public class Movie {

		import flash.display.MovieClip;
		import flash.events.Event;
		import fl.video.*;
		import flash.display.Stage;
		import flash.display.DisplayObject;
		import flash.media.SoundMixer;

		var flvPlayer: FLVPlayback;
		var movieHolder: MovieClip;
		var moviePlaceHolder: MovieClip;
		var stageRef: Stage;
		var movieLocation: String;
		var fvbPlayerSkin: String;

		public function Movie(stageRef: Stage, fvbPlayerSkin: String, moviePlaceHolder_mc: MovieClip = null, movieLocation: String = null) {
			movieHolder = new MovieClip;
			this.stageRef = stageRef;
			this.movieLocation = movieLocation;
			this.moviePlaceHolder = moviePlaceHolder_mc;
			this.fvbPlayerSkin = fvbPlayerSkin;
			movieHolder.name = "movieHolder";
			this.moviePlaceHolder.parent.addChild(movieHolder);
			flvPlayer = new FLVPlayback();

			if (moviePlaceHolder == null) {
				return;

			}

			movieHolder.x = moviePlaceHolder.x;
			movieHolder.y = moviePlaceHolder.y;

		}

		public function setPlaceHolder(moviePlaceHolder_mc: MovieClip) {
			this.moviePlaceHolder = moviePlaceHolder_mc;
			movieHolder.x = moviePlaceHolder.x;
			movieHolder.y = moviePlaceHolder.y;

		}

		public function setLocation(movieLocation: String) {
			this.movieLocation = movieLocation;

		}


		public function removeVideo(event: Event): void {
			if(moviePlaceHolder.parent.contains(movieHolder)) {
				moviePlaceHolder.parent.removeChild(movieHolder);
			
			}

		}

		public function launchMovie(): void {
			if(movieLocation == null || movieLocation.length == 0) {
				moviePlaceHolder.parent.removeChild(movieHolder);
				return;
			}
			flvPlayer.fullScreenTakeOver = false;
			flvPlayer.skin = fvbPlayerSkin;
			flvPlayer.source = movieLocation;
			flvPlayer.skinAutoHide = true;
			flvPlayer.skinBackgroundColor = 0x434B54;

			flvPlayer.width = moviePlaceHolder.width;
			flvPlayer.height = moviePlaceHolder.height;
			flvPlayer.name = "flvPlayer";

			if (moviePlaceHolder.parent.contains(movieHolder)) {
				moviePlaceHolder.parent.removeChild(movieHolder);
				movieHolder = new MovieClip;
				movieHolder.x = moviePlaceHolder.x;
				movieHolder.y = moviePlaceHolder.y;

			}
			
			this.moviePlaceHolder.parent.addChild(movieHolder);
			movieHolder.addChild(flvPlayer);

		}

	}

}