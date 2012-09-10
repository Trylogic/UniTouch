package ru.trylogic.unitouch.adapters
{

	import ru.trylogic.unitouch.processor.IRawTouchListener;
	import ru.trylogic.unitouch.processor.ITouchProcessor;

	public class AbstractTouchAdapter implements ITouchAdapter, IRawTouchListener
	{
		protected var _target : *;

		protected var _numTouches : uint = 0;

		protected var _touchProcessor : ITouchProcessor;

		public function get numTouches() : uint
		{
			return _numTouches;
		}

		public function get target() : *
		{
			return _target;
		}

		public function AbstractTouchAdapter( touchProcessor : ITouchProcessor )
		{
			this._touchProcessor = touchProcessor;
			this._target = _touchProcessor.target;
			installTarget();
		}

		public function installTarget() : void
		{
		}

		public function uninstallTarget() : void
		{
		}

		public final function onRawTouchBegin( touchPointID : int, stageX : Number, stageY : Number ) : void
		{
			_numTouches++;
			_touchProcessor.onRawTouchBegin( touchPointID, stageX, stageY );
		}

		public final function onRawTouchMove( touchPointID : int, stageX : Number, stageY : Number ) : void
		{
			_touchProcessor.onRawTouchMove( touchPointID, stageX, stageY );
		}

		public final function onRawTouchEnd( touchPointID : int, stageX : Number, stageY : Number ) : void
		{
			_touchProcessor.onRawTouchEnd( touchPointID, stageX, stageY );
			_numTouches--;
		}

		public function dispose() : void
		{
			uninstallTarget();
			_target = null;
			_touchProcessor = null;
		}
	}
}
