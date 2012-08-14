package ru.trylogic.unitouch.gestures
{

	import flash.events.Event;

	import ru.trylogic.unitouch.adapters.TouchContext;

	[Event(name="complete", type="flash.events.Event")]
	public class TapGesture extends AbstractGestureRecognizer
	{
		public var slop : uint = 10;

		protected var currentTouchPointID : int = -1;

		public function TapGesture()
		{
		}

		override public function onTouchBegin( context : TouchContext ) : void
		{
			if(currentTouchPointID == -1)
			{
				currentTouchPointID = context.touchPointID;
				dispatchEvent(new Event("onPress"));
			}
			else
			{
				onTouchCancel();
			}
		}

		override public function onTouchMove( context : TouchContext ) : void
		{
			if(context.touchPointID != currentTouchPointID)
			{
				return;
			}

			var dx : Number = context.beginX - context.localX;
			var dy : Number = context.beginY - context.localY;
			var distance : Number = Math.sqrt(dx * dx - dy * dy);
			if(distance > slop)
			{
				onTouchCancel();
			}
		}

		override public function onTouchEnd( context : TouchContext ) : void
		{
			if(context.touchPointID == currentTouchPointID)
			{
				dispatchEvent(new Event(Event.COMPLETE));
				dispatchEvent(new Event("onRelease"));
				currentTouchPointID = -1;
			}
		}

		override protected function onTouchCancel() : void
		{
			trace("canceled");
			currentTouchPointID = -1;
		}
	}
}
