package ru.trylogic.unitouch.adapters.native
{

	import flash.events.MouseEvent;

	import ru.trylogic.unitouch.adapters.AbstractTouchAdapter;

	import ru.trylogic.unitouch.adapters.ITouchAdapter;
	import ru.trylogic.unitouch.ITouchProcessor;

	public class NativeMouseTouchAdapter extends AbstractTouchAdapter implements ITouchAdapter
	{
		public function NativeMouseTouchAdapter( touchProcessor : ITouchProcessor )
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

			func( MouseEvent.MOUSE_DOWN, onMouseDown );
			func( MouseEvent.MOUSE_MOVE, onMouseMove );
			func( MouseEvent.MOUSE_UP, onMouseUp );
		}

		protected function onMouseDown( e : MouseEvent ) : void
		{
			onTouchBegin( 0, e.localX, e.localY, e.stageX, e.stageY );
		}

		protected function onMouseMove( e : MouseEvent ) : void
		{
			onTouchMove( 0, e.localX, e.localY, e.stageX, e.stageY );
		}

		protected function onMouseUp( e : MouseEvent ) : void
		{
			onTouchEnd( 0, e.localX, e.localY, e.stageX, e.stageY );
		}
	}
}
