package ru.trylogic.unitouch.gestures
{

	import flash.events.Event;

	import ru.trylogic.unitouch.gestures.*;

	[Event(name="recognized", type="flash.events.Event")]
	public class TapGesture extends AbstractGestureRecognizer
	{
		public var slop : uint = 10;

		public var distance : Number = 0;

		protected var beginX : Number = 0;
		protected var beginY : Number = 0;

		protected var currentTouchPointID : int = -1;

		public function TapGesture()
		{
		}

		override public function onTouchBegin( touchPointID : int, localX : Number, localY : Number, stageX : Number, stageY : Number ) : void
		{
			if(currentTouchPointID == -1)
			{
				currentTouchPointID = touchPointID;
				beginX = localX;
				beginY = localY;
				dispatchEvent(new Event("onPress"));
			}
		}

		override public function onTouchMove( touchPointID : int, localX : Number, localY : Number, stageX : Number, stageY : Number ) : void
		{
			if(touchPointID != currentTouchPointID)
			{
				return;
			}

			var dx : Number = beginX - localX;
			var dy : Number = beginY - localY;
			distance = Math.sqrt(dx * dx - dy * dy);
			if(distance > slop)
			{
				cancel();
			}
		}

		override public function onTouchEnd( touchPointID : int, localX : Number, localY : Number, stageX : Number, stageY : Number ) : void
		{
			if(touchPointID == currentTouchPointID)
			{
				dispatchEvent(new Event("recognized"));
				dispatchEvent(new Event("onRelease"));
				trace("onTouchEndRecognized");
			}

			trace("onTouchEnd");
			distance = 0;
			currentTouchPointID = -1;
		}

		override protected function cancel() : void
		{
			trace("canceled");
			distance = 0;
			currentTouchPointID = -1;
		}
	}
}
