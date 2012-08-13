package ru.trylogic.unitouch.adapters.native
{

	import flash.events.MouseEvent;
	import flash.events.TouchEvent;

	import ru.trylogic.unitouch.adapters.AbstractTouchAdapter;

	import ru.trylogic.unitouch.adapters.ITouchAdapter;
	import ru.trylogic.unitouch.ITouchProcessor;

	public class NativeTouchAdapter extends AbstractTouchAdapter implements ITouchAdapter
	{

		public function NativeTouchAdapter( touchProcessor : ITouchProcessor )
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

			func( TouchEvent.TOUCH_BEGIN, onNativeTouchBegin );
			func( TouchEvent.TOUCH_MOVE, onNativeTouchMove );
			func( TouchEvent.TOUCH_END, onNativeTouchEnd );
		}

		protected function onNativeTouchBegin( e : TouchEvent ) : void
		{
			onTouchBegin( e.touchPointID, e.localX, e.localY, e.stageX, e.stageY );
		}

		protected function onNativeTouchMove( e : TouchEvent ) : void
		{
			onTouchMove( e.touchPointID, e.localX, e.localY, e.stageX, e.stageY );
		}

		protected function onNativeTouchEnd( e : TouchEvent ) : void
		{
			onTouchEnd( e.touchPointID, e.localX, e.localY, e.stageX, e.stageY );
		}
	}
}
