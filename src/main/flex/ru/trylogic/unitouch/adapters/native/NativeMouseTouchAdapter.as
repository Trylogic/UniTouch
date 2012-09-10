package ru.trylogic.unitouch.adapters.native
{

	import flash.display.Stage;
	import flash.events.MouseEvent;

	import ru.trylogic.unitouch.UniTouch;

	import ru.trylogic.unitouch.adapters.AbstractTouchAdapter;

	import ru.trylogic.unitouch.adapters.ITouchAdapter;
	import ru.trylogic.unitouch.processor.ITouchProcessor;

	public class NativeMouseTouchAdapter extends AbstractTouchAdapter implements ITouchAdapter
	{
		protected const stage : Stage = UniTouch.stage;

		public function NativeMouseTouchAdapter( touchProcessor : ITouchProcessor )
		{
			super( touchProcessor );
		}

		override public function installTarget() : void
		{
			if ( _target == null )
			{
				return;
			}

			_target.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
		}

		override public function uninstallTarget() : void
		{
			if ( _target == null )
			{
				return;
			}

			_target.removeEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
			stage.removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			stage.removeEventListener( MouseEvent.MOUSE_UP, onMouseUp );
		}

		protected function onMouseDown( e : MouseEvent ) : void
		{
			onRawTouchBegin( 0, e.stageX, e.stageY );
			if ( _numTouches == 1 )
			{
				stage.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
				stage.addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			}
		}

		protected function onMouseMove( e : MouseEvent ) : void
		{
			onRawTouchMove( 0, e.stageX, e.stageY );
		}

		protected function onMouseUp( e : MouseEvent ) : void
		{
			onRawTouchEnd( 0, e.stageX, e.stageY );
			if ( _numTouches == 0 )
			{
				stage.removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
				stage.removeEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			}
		}
	}
}
