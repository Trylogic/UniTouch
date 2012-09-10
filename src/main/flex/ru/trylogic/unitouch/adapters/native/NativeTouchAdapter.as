package ru.trylogic.unitouch.adapters.native
{

	import flash.display.Stage;
	import flash.events.TouchEvent;

	import ru.trylogic.unitouch.UniTouch;

	import ru.trylogic.unitouch.adapters.AbstractTouchAdapter;

	import ru.trylogic.unitouch.adapters.ITouchAdapter;
	import ru.trylogic.unitouch.processor.ITouchProcessor;

	public class NativeTouchAdapter extends AbstractTouchAdapter implements ITouchAdapter
	{
		protected const stage : Stage = UniTouch.stage;

		public function NativeTouchAdapter( touchProcessor : ITouchProcessor )
		{
			super( touchProcessor );
		}

		override public function installTarget() : void
		{
			if ( _target == null )
			{
				return;
			}

			_target.addEventListener( TouchEvent.TOUCH_BEGIN, onNativeTouchBegin );
		}

		override public function uninstallTarget() : void
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
			onRawTouchBegin( e.touchPointID, e.stageX, e.stageY );
			if ( _numTouches == 1 )
			{
				stage.addEventListener( TouchEvent.TOUCH_MOVE, onNativeTouchMove );
				stage.addEventListener( TouchEvent.TOUCH_END, onNativeTouchEnd );
			}
		}

		protected function onNativeTouchMove( e : TouchEvent ) : void
		{
			onRawTouchMove( e.touchPointID, e.stageX, e.stageY );
		}

		protected function onNativeTouchEnd( e : TouchEvent ) : void
		{
			onRawTouchEnd( e.touchPointID, e.stageX, e.stageY );
			if ( _numTouches == 0 )
			{
				stage.removeEventListener( TouchEvent.TOUCH_MOVE, onNativeTouchMove );
				stage.removeEventListener( TouchEvent.TOUCH_END, onNativeTouchEnd );
			}
		}
	}
}
