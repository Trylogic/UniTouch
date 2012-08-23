package ru.trylogic.unitouch.adapters.native
{

	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.TouchEvent;
	import flash.geom.Point;

	import ru.trylogic.unitouch.adapters.AbstractTouchAdapter;

	import ru.trylogic.unitouch.adapters.ITouchAdapter;
	import ru.trylogic.unitouch.ITouchProcessor;

	import tl.ioc.IoCHelper;

	public class NativeTouchAdapter extends AbstractTouchAdapter implements ITouchAdapter
	{
		private static const stage : Stage = IoCHelper.resolve( Stage, NativeTouchAdapter );

		public function NativeTouchAdapter( touchProcessor : ITouchProcessor )
		{
			super( touchProcessor );
		}

		override public function addEventListeners() : void
		{
			if ( _target == null )
			{
				return;
			}

			_target.addEventListener( TouchEvent.TOUCH_BEGIN, onNativeTouchBegin );
		}

		override public function removeEventListeners() : void
		{
			if ( _target == null )
			{
				return;
			}

			_target.removeEventListener( TouchEvent.TOUCH_BEGIN, onNativeTouchBegin );
			stage.removeEventListener( TouchEvent.TOUCH_MOVE, onNativeTouchMove );
			stage.removeEventListener( TouchEvent.TOUCH_END, onNativeTouchEnd );
		}

		protected function onNativeTouchBegin( e : TouchEvent ) : void
		{
			onTouchBegin( e.touchPointID, e.stageX, e.stageY );
			if ( numTouches == 1 )
			{
				stage.addEventListener( TouchEvent.TOUCH_MOVE, onNativeTouchMove );
				stage.addEventListener( TouchEvent.TOUCH_END, onNativeTouchEnd );
			}
		}

		protected function onNativeTouchMove( e : TouchEvent ) : void
		{
			onTouchMove( e.touchPointID, e.stageX, e.stageY );
		}

		protected function onNativeTouchEnd( e : TouchEvent ) : void
		{
			onTouchEnd( e.touchPointID, e.stageX, e.stageY );
			if ( numTouches == 0 )
			{
				stage.removeEventListener( TouchEvent.TOUCH_MOVE, onNativeTouchMove );
				stage.removeEventListener( TouchEvent.TOUCH_END, onNativeTouchEnd );
			}
		}
	}
}
