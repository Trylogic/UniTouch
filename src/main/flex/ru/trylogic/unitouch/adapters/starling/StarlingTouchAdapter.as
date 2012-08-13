package ru.trylogic.unitouch.adapters.starling
{

	import flash.geom.Point;

	import ru.trylogic.unitouch.ITouchProcessor;
	import ru.trylogic.unitouch.adapters.AbstractTouchAdapter;

	import starling.events.Touch;

	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class StarlingTouchAdapter extends AbstractTouchAdapter
	{
		public function StarlingTouchAdapter( touchProcessor : ITouchProcessor )
		{
			super( touchProcessor );
		}

		override public function processEventListeners( action : uint ) : void
		{
			if ( _target == null )
			{
				return;
			}

			var func : Function = action == ADD_LISTENERS ? _target.addEventListener : _target.removeEventListener;

			func( TouchEvent.TOUCH, onStarlingTouch );
		}

		protected function onStarlingTouch( e : TouchEvent ) : void
		{
			var touch : Touch = e.getTouch( _target );
			if ( touch )
			{
				var location : Point = touch.getLocation( _target );
				switch ( touch.phase )
				{
					case TouchPhase.BEGAN:
					{
						onTouchBegin( touch.id, location.x, location.y, touch.globalX, touch.globalY );
					}
						break;
					case TouchPhase.MOVED:
					{
						onTouchMove( touch.id, location.x, location.y, touch.globalX, touch.globalY );
					}
						break;
					case TouchPhase.ENDED:
					{
						onTouchEnd( touch.id, location.x, location.y, touch.globalX, touch.globalY );
					}
						break;
				}
			}
		}
	}
}
