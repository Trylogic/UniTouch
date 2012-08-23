package ru.trylogic.unitouch.adapters.native
{

	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.EventPhase;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	import ru.trylogic.unitouch.adapters.AbstractTouchAdapter;

	import ru.trylogic.unitouch.adapters.ITouchAdapter;
	import ru.trylogic.unitouch.ITouchProcessor;

	import tl.ioc.IoCHelper;

	public class NativeMouseTouchAdapter extends AbstractTouchAdapter implements ITouchAdapter
	{
		private static const stage : Stage = IoCHelper.resolve( Stage, NativeMouseTouchAdapter );

		public function NativeMouseTouchAdapter( touchProcessor : ITouchProcessor )
		{
			super( touchProcessor );
		}

		override public function addEventListeners() : void
		{
			if ( _target == null )
			{
				return;
			}

			_target.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
		}

		override public function removeEventListeners() : void
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
			onTouchBegin( 0, e.stageX, e.stageY );
			if ( numTouches == 1 )
			{
				stage.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
				stage.addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			}
		}

		protected function onMouseMove( e : MouseEvent ) : void
		{
			onTouchMove( 0, e.stageX, e.stageY );
		}

		protected function onMouseUp( e : MouseEvent ) : void
		{
			onTouchEnd( 0, e.stageX, e.stageY );
			if ( numTouches == 0 )
			{
				stage.removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
				stage.removeEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			}
		}
	}
}
