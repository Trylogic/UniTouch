package ru.trylogic.unitouch.adapters.starling
{

	import ru.trylogic.unitouch.adapters.AbstractTouchAdapter;
	import ru.trylogic.unitouch.processor.ITouchProcessor;

	import starling.core.Starling;
	import starling.display.DisplayObject;

	import starling.events.Touch;

	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class StarlingTouchAdapter extends AbstractTouchAdapter
	{
		public function StarlingTouchAdapter( touchProcessor : ITouchProcessor )
		{
			super( touchProcessor );
		}

		override public function installTarget() : void
		{
			if ( _target == null )
			{
				return;
			}

			(_target as DisplayObject).addEventListener( TouchEvent.TOUCH, onStarlingTouch );
		}

		override public function uninstallTarget() : void
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
				switch ( touch.phase )
				{
					case TouchPhase.BEGAN:
					{
						onRawTouchBegin( touch.id, touch.globalX, touch.globalY );
						if ( _numTouches == 1 )
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
				switch ( touch.phase )
				{
					case TouchPhase.MOVED:
					{
						onRawTouchMove( touch.id, touch.globalX, touch.globalY );
					}
						break;
					case TouchPhase.ENDED:
					{
						onRawTouchEnd( touch.id, touch.globalX, touch.globalY );
						if ( _numTouches == 0 )
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
