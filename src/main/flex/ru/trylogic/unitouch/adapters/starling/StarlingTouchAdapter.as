package ru.trylogic.unitouch.adapters.starling
{

	import flash.geom.Point;

	import ru.trylogic.unitouch.ITouchProcessor;
	import ru.trylogic.unitouch.adapters.AbstractTouchAdapter;

	import starling.core.Starling;
	import starling.display.DisplayObject;

	import starling.events.Touch;

	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class StarlingTouchAdapter extends AbstractTouchAdapter
	{
		private const ZERO_POINT : Point = new Point( 0, 0 );

		public function StarlingTouchAdapter( touchProcessor : ITouchProcessor )
		{
			super( touchProcessor );
		}

		override public function addEventListeners() : void
		{
			if ( _target == null )
			{
				return;
			}

			(_target as DisplayObject).addEventListener( TouchEvent.TOUCH, onStarlingTouch );
		}

		override public function removeEventListeners() : void
		{
			if ( _target == null )
			{
				return;
			}

			(_target as DisplayObject).removeEventListener( TouchEvent.TOUCH, onStarlingTouch );
			Starling.current.stage.removeEventListener( TouchEvent.TOUCH, onStarlingStageTouch );
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
						onTouchBegin( touch.id, touch.globalX, touch.globalY );
						if ( numTouches == 1 )
						{
							Starling.current.stage.addEventListener( TouchEvent.TOUCH, onStarlingStageTouch );
						}
					}
						break;
				}
			}
		}

		protected function onStarlingStageTouch( e : TouchEvent ) : void
		{
			var touch : Touch = e.getTouch( Starling.current.stage );
			if ( touch )
			{
				var location : Point = (_target as DisplayObject).localToGlobal( ZERO_POINT );
				switch ( touch.phase )
				{
					case TouchPhase.MOVED:
					{
						onTouchMove( touch.id, touch.globalX, touch.globalY );
					}
						break;
					case TouchPhase.ENDED:
					{
						onTouchEnd( touch.id, touch.globalX, touch.globalY );
						if ( numTouches == 0 )
						{
							Starling.current.stage.removeEventListener( TouchEvent.TOUCH, onStarlingStageTouch );
						}
					}
						break;
				}
			}
		}
	}
}
